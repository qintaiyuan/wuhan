import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../app/data/models/device_model.dart';
import '../app/network/services/network_service.dart';
import '../constants/Constants.dart';

class DeviceService extends GetxService {
  var devices = <DeviceInfo>[].obs;
  var currentDevice = Rxn<DeviceInfo>();
  late Box<DeviceInfo> _deviceBox;
  final NetworkService _networkService = Get.find();

  Future<DeviceService> init() async {
    _deviceBox = await Hive.openBox<DeviceInfo>(deviceBox);
    _findCurDevice();
    return this;
  }

  void _findCurDevice() {
    currentDevice.value = _deviceBox.getAt(0);
  }

  Future<void> fetchDevicesFromNetwork() async {
    try {
      var response = await _networkService.get<List<DeviceInfo>>(
        '/device/v1/devices',
        queryParameters: {"models": anchorModel},
        fromJsonT: (json) =>
            (json as List).map((item) => DeviceInfo.fromJson(item)).toList(),
      );
      print('home_controller - ${response.data}');
      devices.clear();
      devices.addAll(response.data ?? []);
      _deviceBox.clear();
      _deviceBox.addAll(devices);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch devices from network');
    }
  }

  void addDevice(DeviceInfo device) {
    devices.add(device);
    _deviceBox.add(device);
    currentDevice.value = device;
  }
}
