import 'dart:async';

import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:wuhan/app/bluetooth/ble/interf/ible_config.dart';

abstract class BaseBleReducer implements IBleConfig {
  final FlutterReactiveBle _ble = FlutterReactiveBle();
  late StreamSubscription<ConnectionStateUpdate> _connectionSubscription;
  late StreamSubscription<List<int>> _notificationSubscription;
  late QualifiedCharacteristic _rxCharacteristic;
  late QualifiedCharacteristic _txCharacteristic;
  late StreamSubscription<ConnectionStateUpdate> _connection;
  static const int desiredMTUSize = 512;

  void connectToDevice(String deviceId) {
    // _connection = _ble.connectToDevice(id: deviceId).listen((update) {
    //   connectionState.value = update.connectionState;
    // }, onError: (e) {
    //   connectionState.value = DeviceConnectionState.disconnected;
    //   print("Error connecting to device $deviceId: $e");
    // });
  }

  Future<void> _configureDeviceParameters(String deviceId) async {
    await _requestMTU(deviceId);
  }

  Future<void> _requestMTU(String deviceId) async {
    try {
      final mtu =
          await _ble.requestMtu(deviceId: deviceId, mtu: desiredMTUSize);
      print("BLE Status MTU negotiated to $mtu");
    } catch (e) {
      print("BLE Error Failed to negotiate MTU: $e");
    }
  }

  void enableNotification() {
    _notificationSubscription =
        _ble.subscribeToCharacteristic(_rxCharacteristic).listen((data) {

      // Handle received data
      print("Received data: $data");
    }, onError: (error) {
      print("BLE Error Notification error: $error");
    });
  }
}
