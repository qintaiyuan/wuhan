import 'dart:async';

import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get/get.dart';
import 'package:wuhan/app/bluetooth/ble/controller/strategy/device_strategy.dart';
import 'package:wuhan/app/bluetooth/ble/interf/idevice_controller.dart';
import 'package:wuhan/app/bluetooth/ble/models/device_state.dart';
import 'package:wuhan/app/bluetooth/ble/protocol/bind_device_handler.dart';

import '../../../utils/log_manager.dart';
import '../device/anchor_ble_master.dart';
import '../interf/ible_master.dart';

class DeviceController extends GetxController implements IdeviceController {
  final DeviceStrategy deviceStrategy;
  late final IBleMaster iBleMaster;
  final String TAG = 'DeviceController';
  @override
  Rx<DeviceState> connectionState = Rx(DeviceState.disconnected);

  DeviceController(this.deviceStrategy) {
    iBleMaster = _createIBleMaster(deviceStrategy);
    iBleMaster.onDeviceState = (DeviceConnectionState state) {
      _updateConnectState(state);
    };
  }

  void _updateConnectState(DeviceConnectionState state) {
    LogManager.d('DeviceConnectionState for$state $deviceStrategy', tag: TAG);
    switch (state) {
      case DeviceConnectionState.connecting:
        connectionState.value = DeviceState.connecting;
        break;
      case DeviceConnectionState.connected:
        connectionState.value = DeviceState.connected;
        break;
      case DeviceConnectionState.disconnecting:
        connectionState.value = DeviceState.disconnecting;
        break;
      case DeviceConnectionState.disconnected:
        connectionState.value = DeviceState.disconnected;
        break;
    }
  }

  @override
  Future<bool> bindDevice(
      {Duration connectionTimeout = const Duration(seconds: 10)}) async {
    LogManager.d('bindDevice for $deviceStrategy', tag: TAG);
    final success = await BindDeviceHandler(iBleMaster).bindDevice();
    if (success) {
      connectionState.value = DeviceState.channelSuccessed;
    } else {
      disconnectFromDevice();
      connectionState.value = DeviceState.disconnected;
    }
    return success;
  }

  @override
  Future<void> reConnect(
      {Duration connectionTimeout = const Duration(seconds: 10)}) async {
    LogManager.d('bindDevice for $deviceStrategy', tag: TAG);
  }

  @override
  void connectBle(void Function(DeviceConnectionState event)? onData,
      {Duration connectionTimeout = const Duration(seconds: 10)}) {
    LogManager.d('bindDevice for $deviceStrategy', tag: TAG);
    iBleMaster.connectDevice(onData, connectionTimeout: connectionTimeout);
  }

  @override
  void disconnectFromDevice() => iBleMaster.disconnect();

  @override
  bool isChannelSuccess() =>
      connectionState.value == DeviceState.channelSuccessed;

  IBleMaster _createIBleMaster(DeviceStrategy deviceStrategy) {
    switch (deviceStrategy.runtimeType) {
      //下划线 _ 是用来表示忽略匹配的对象。这样做的目的是告诉编译器我们只关心对象的类型，而不关心具体的对象实例
      case AnchorDeviceStrategy _:
        return AnchorBleMaster(deviceStrategy.deviceId);
      default:
        return AnchorBleMaster(deviceStrategy.deviceId);
    }
  }
}
