import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../models/device_state.dart';

abstract class IdeviceController{
  late Rx<DeviceState> connectionState;
  Future<void> reConnect({Duration connectionTimeout = const Duration(seconds: 10)});
  Future<void> bindDevice({Duration connectionTimeout = const Duration(seconds: 10)});
  void connectBle(void Function(DeviceConnectionState event)? onData,
      {Duration connectionTimeout = const Duration(seconds: 10)}) ;
  bool isChannelSuccess();
  void disconnectFromDevice();
}