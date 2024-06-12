import 'dart:async';

import 'package:get/get.dart';
import 'package:wuhan/app/bluetooth/ble/controller/strategy/device_strategy.dart';
import 'package:wuhan/app/bluetooth/ble/scan/device_scan_helper.dart';
import 'package:wuhan/app/bluetooth/ble/scan/strategy/scan_strategy.dart';
import 'package:wuhan/app/data/models/device_model.dart';

import '../../../utils/log_manager.dart';
import '../controller/device_controller.dart';
import '../interf/ible_service.dart';
import '../interf/idevice_controller.dart';

class BleService extends GetxService implements IBleService {
  final DeviceScanHelper deviceScanHelper = DeviceScanHelper();
  RxList<DeviceInfo> devicesList = <DeviceInfo>[].obs;
  RxMap connectedDevices = RxMap<String, IdeviceController>();
  Rxn<IdeviceController> curDeviceController = Rxn<IdeviceController>();

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

  @override
  void reConnectDevice(DeviceInfo deviceInfo) {
    final deviceId = deviceInfo.device!.id;
    if (!connectedDevices.containsKey(deviceId)) {
      final controller = DeviceController(AnchorDeviceStrategy(deviceId));
      connectedDevices[deviceId] = controller;
      Get.put(controller, tag: deviceId);
      curDeviceController.value = controller;
    }
    curDeviceController.value?.bindDevice();
  }

  @override
  void disconnectFromDevice(String deviceId) {
    if (connectedDevices.containsKey(deviceId)) {
      connectedDevices[deviceId]?.disconnectFromDevice();
      connectedDevices.remove(deviceId);
      Get.delete<DeviceController>(tag: deviceId);
    }
  }

  @override
  Future<bool> bindDevice(DeviceInfo deviceInfo) async {
    try {
      final deviceId = deviceInfo.device!.id;
      final controller = DeviceController(AnchorDeviceStrategy(deviceId));
      final success = await controller.bindDevice();
      if(success) {
        connectedDevices[deviceId] = controller;
        Get.put(controller, tag: deviceId);
        curDeviceController.value = controller;
      }
      return success;
    } catch (e) {
      LogManager.e("Error bindDevice: $e");
      return false;
    }
  }
}
