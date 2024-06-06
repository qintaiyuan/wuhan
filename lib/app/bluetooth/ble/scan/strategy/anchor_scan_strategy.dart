import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get/get.dart';
import 'package:wuhan/Extensions.dart';
import 'package:wuhan/app/bluetooth/ble/scan/strategy/scan_strategy.dart';
import 'package:wuhan/app/data/models/device_model.dart';

import '../parse/mma_parse.dart';

class AnchorScanStrategy extends ScanStrategy {
  final List<int> unPariringFeature = [
    0x67,
    0x0A,
    0x00,
    0x00,
    0x00,
    0x30,
    0xB1
  ];
  final bool isBond;
  final MmaParse mmaParse = MmaParse();

  AnchorScanStrategy({this.isBond = false});

  @override
  List<List<int>> getManufacturerDatas() {
    return [unPariringFeature];
  }

  @override
  DeviceInfo? filterScanResults(DiscoveredDevice device) {
    var manufacturerData = device.manufacturerData;
    print(
        'AnchorScanStrategy manufacturerData---${manufacturerData.toHexString()}');
    var bondState = mmaParse.getDeviceBondState(false, manufacturerData);
    if (bondState != isBond) return null;
    var deviceModel = mmaParse.getDeviceModel(false, manufacturerData);
    var mac = mmaParse.getDeviceMac(manufacturerData);
    var deviceInfo = DeviceInfo(
        deviceId: 0,
        model: deviceModel,
        nickname: 'anchorDeviceName'.tr,
        mac: mac,
        leftSn: "",
        rightSn: "",
        device: device);
    print('deviceinfo----$deviceInfo');
    return deviceInfo;
  }
}
