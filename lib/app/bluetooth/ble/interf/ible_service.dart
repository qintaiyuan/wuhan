import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import '../../../data/models/device_model.dart';
import '../scan/specific_scan_filter.dart';
import '../scan/strategy/scan_strategy.dart';

abstract class IBleService {
  void scanDevices({required List<ScanStrategy> strategies});

  void stopScan();

  void reConnectDevice(DeviceInfo deviceInfo);

  Future<bool> bindDevice(DeviceInfo deviceInfo);

  void disconnectFromDevice(String deviceId);
}
