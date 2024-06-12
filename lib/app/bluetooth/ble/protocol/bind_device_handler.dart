import 'dart:async';

import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:wuhan/app/utils/log_manager.dart';

import '../interf/ible_master.dart';

class BindDeviceHandler {
  final IBleMaster iBleMaster;

  BindDeviceHandler(this.iBleMaster);

  Future<bool> bindDevice() async {
    await connectBle();
    await iBleMaster.enableNotification();
    await iBleMaster.setMTU(512);
    return true;
  }


  Future<bool> connectBle() async {
    try {
      Completer<bool> completer = Completer<bool>();

      iBleMaster.connectDevice((DeviceConnectionState state) {
        if (state == DeviceConnectionState.connected) {
          if (!completer.isCompleted) {
            completer.complete(true);
          }
        } else if (state == DeviceConnectionState.disconnected ||
            state == DeviceConnectionState.disconnecting) {
          if (!completer.isCompleted) {
            completer.completeError(
                Exception('Failed to connect to BLE device'));
          }
        }
      });

      return await completer.future;
    } catch (e) {
      LogManager.e("Error connecting to BLE device: $e");
      rethrow;
    }
  }
}
