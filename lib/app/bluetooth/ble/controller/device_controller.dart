import 'dart:async';

import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get/get.dart';

class DeviceController extends GetxController {
  final String deviceId;
  final FlutterReactiveBle _ble = FlutterReactiveBle();

  Rx<DeviceConnectionState> connectionState = Rx(DeviceConnectionState.disconnected);
  late StreamSubscription<ConnectionStateUpdate> _connection;

  DeviceController(this.deviceId);

  @override
  void onInit() {
    super.onInit();
    _connectToDevice();
  }

  void _connectToDevice() {
    _connection = _ble.connectToDevice(id: deviceId).listen((update) {
      connectionState.value = update.connectionState;
    }, onError: (e) {
      connectionState.value = DeviceConnectionState.disconnected;
      print("Error connecting to device $deviceId: $e");
    });
  }

  void disconnectFromDevice() {
    _connection.cancel();
    connectionState.value = DeviceConnectionState.disconnected;
  }

  @override
  void onClose() {
    _connection.cancel();
    super.onClose();
  }
}
