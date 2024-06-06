import 'package:get/get.dart';
import 'package:wuhan/app/bluetooth/ble/scan/device_scan_helper.dart';
import 'package:wuhan/app/bluetooth/ble/scan/strategy/scan_strategy.dart';
import 'package:wuhan/app/data/models/device_model.dart';

import '../controller/device_controller.dart';
import '../interf/ble_interface.dart';

class BleService extends GetxService implements IBleService {
  final DeviceScanHelper deviceScanHelper = DeviceScanHelper();
  RxList<DeviceInfo> devicesList = <DeviceInfo>[].obs;
  RxMap connectedDevices = RxMap<String, DeviceController>();

  @override
  void scanDevices({required List<ScanStrategy> strategies}) {
    devicesList.value = [];
    deviceScanHelper.scanDevices((deviceInfo) {
      if (devicesList.isEmpty) {
        devicesList.add(deviceInfo);
      } else {
        final existingDevice = devicesList
            .firstWhere((d) => d.device?.id == deviceInfo.device?.id);
        if (existingDevice.device?.id.isEmpty == true) {
          devicesList.add(deviceInfo);
        }
      }
    }, strategies: strategies);
  }

  @override
  void stopScan() {
    deviceScanHelper.stopScan();
  }

  // @override
  // Stream<DiscoveredDevice> scanForDevices(
  //     {required List<ScanFilter> strategies}) {
  //   return _ble.scanForDevices(
  //       withServices: [], scanMode: ScanMode.lowLatency).where((device) {
  //     return strategies
  //         .any((strategy) => strategy.matches(device.manufacturerData));
  //   });
  // }

  @override
  void connectToDevice(String deviceId) {
    if (!connectedDevices.containsKey(deviceId)) {
      final controller = DeviceController(deviceId);
      connectedDevices[deviceId] = controller;
      Get.put(controller, tag: deviceId);
    }
  }

  @override
  void disconnectFromDevice(String deviceId) {
    if (connectedDevices.containsKey(deviceId)) {
      connectedDevices[deviceId]?.disconnectFromDevice();
      connectedDevices.remove(deviceId);
      Get.delete<DeviceController>(tag: deviceId);
    }
  }
}
