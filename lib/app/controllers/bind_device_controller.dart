import 'dart:async';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wuhan/app/bluetooth/ble/services/ble_service.dart';
import 'package:wuhan/app/data/models/binding_state.dart';

import '../../services/device_service.dart';
import '../bluetooth/ble/scan/strategy/anchor_scan_strategy.dart';
import '../data/models/bind_device_state_model.dart';
import '../data/models/device_model.dart';

class BindDeviceController extends GetxController
    with GetTickerProviderStateMixin {
  RxList<DeviceInfo> devicesList = <DeviceInfo>[].obs;
  final BleService _bleService = Get.find();
  var currentScreen = DeviceBindState.SETUP_GUIDE.obs;
  Rx<BindingState> bindState = Rx(BindingState.CONNECTING);
  final DeviceService _deviceService = Get.find<DeviceService>();
  DeviceInfo? _deviceInfo;
  @override
  void onInit() {
    super.onInit();
    devicesList.bindStream(_bleService.devicesList.stream);
    ever(
        _bleService.devicesList,
        (value) => {
              if (devicesList.isNotEmpty &&
                  currentScreen.value == DeviceBindState.ADD_DEVICE)
                {_switchScreen(DeviceBindState.DEVICE_FIND_ONE)}
            });
  }

  void _switchScreen(DeviceBindState screen) {
    currentScreen.value = screen;
  }

  void searchDevice() async {
    if (await _requestPermissions()) {
      _switchScreen(DeviceBindState.ADD_DEVICE);
      _bleService.scanDevices(strategies: [AnchorScanStrategy()]);
    }
  }

  void bindDevice(DeviceInfo deviceInfo) async {
    _switchScreen(DeviceBindState.CONNECTING);
    stopScan();
    final success = await _bleService.bindDevice(deviceInfo);
    if (success) {
      bindState.value = BindingState.SUCCESS;
      _deviceInfo = deviceInfo;
    } else {
      bindState.value = BindingState.FAILED;
    }
  }

  void seeMoreDevice() {
    _switchScreen(DeviceBindState.DEVICE_FIND_MORE);
  }

  Future<bool> _requestPermissions() async {
    final status = await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.bluetoothAdvertise,
      Permission.location
    ].request();

    return status[Permission.location]!.isGranted &&
        status[Permission.bluetoothScan]!.isGranted &&
        status[Permission.bluetoothConnect]!.isGranted &&
        status[Permission.bluetoothAdvertise]!.isGranted;
  }

  void dimissDialog() {
    Get.back();
    stopScan();
  }

  void switchSuccessPage() async {
    _switchScreen(DeviceBindState.CONNECT_SUCCESS);
    await Future.delayed(const Duration(seconds: 2));
    _deviceService.addDevice(_deviceInfo!);
    dimissDialog();
  }

  void switchFailedPage() {
    _switchScreen(DeviceBindState.CONNECT_FAILED);
  }

  void switchGuidePage() {
    _switchScreen(DeviceBindState.SETUP_GUIDE);
  }

  void stopScan() {
    _bleService.stopScan();
  }

  @override
  void onClose() {
    stopScan();
    super.onClose();
  }
}
