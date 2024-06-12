import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:wuhan/app/bluetooth/ble/base/base_ble_response.dart';

import '../base/base_command.dart';
import '../models/command_result.dart';

abstract class IBleMaster {
  // 连接设备
  void connectDevice(void Function(DeviceConnectionState event)? onDeviceState,
      {Duration connectionTimeout = const Duration(seconds: 10)});

  //连接advertising设备
  void connectAdvertisingDevice(
    void Function(DeviceConnectionState event)? onDeviceState, {
    Duration prescanDuration = const Duration(seconds: 10),
    Duration connectionTimeout = const Duration(seconds: 10),
  });

  bool isDisConnected();

  void disconnect();

  Future<void> setMTU(int mtu);

  Future<void> enableNotification();

  Future<void> writeData(BaseCommand command);

  Future<CommandResult<R>> writeDataWithResponse<R extends BaseBleResponse>(
      BaseCommand command);

  // void Function(DeviceConnectionState event)? onDeviceState;
  void Function(DeviceConnectionState event)? onDeviceState;

}
