import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:wuhan/Extensions.dart';
import 'package:wuhan/app/data/models/device_model.dart';

abstract class ScanStrategy {
  List<List<int>> getManufacturerDatas();

  DeviceInfo? filterScanResults(DiscoveredDevice device);

  bool matches(List<int> manufacturerData) {
    var manufacturerDatas = getManufacturerDatas();
    for (int i = 0; i < manufacturerDatas.length; i++) {
      if (!manufacturerData.isMatch(manufacturerDatas[i])) {
        return false;
      }
    }
    return true;
  }
}
