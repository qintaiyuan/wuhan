import 'dart:async';

import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:wuhan/app/bluetooth/ble/scan/strategy/scan_strategy.dart';

import '../../../data/models/device_model.dart';

class DeviceScanHelper {
  final FlutterReactiveBle _ble = FlutterReactiveBle();
  late StreamSubscription<DeviceInfo> _scanStream;

  void scanDevices(void Function(DeviceInfo event) onData,{required List<ScanStrategy> strategies}) {
    stopScan();
    _scanStream = _scanForDevices(strategies: strategies).listen(onData);
  }

  Stream<DeviceInfo> _scanForDevices({required List<ScanStrategy> strategies}) {
    return _ble.scanForDevices(
        withServices: [],
        scanMode: ScanMode.lowLatency).asyncExpand((device) async* {
      for (var strategy in strategies) {
        if (strategy.matches(device.manufacturerData)) {
          var filteredDevice = strategy.filterScanResults(device);
          if (filteredDevice != null) { // 检查返回结果是否为 null
            yield filteredDevice;
            break;
          }
          break;
        }
      }
    });
  }

  void stopScan() {
    try {
      // 0x11000030B1420A0A000000518C09B2DAB138518C09B2DAB1
      // 0x11000030B14A0A0A000000518C09B2DAB137518C09B2DAB1
      //0x000030B100000000003030304133
      _scanStream.cancel();
    } catch(e) {
      // 如果 _scanStream 尚未初始化，这里会捕获到异常
      print('_scanStream has not been initialized yet.');
    }

  }
}
