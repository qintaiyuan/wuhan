import 'dart:async';

import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:wuhan/app/bluetooth/ble/base/base_ble_reducer.dart';
import 'package:wuhan/app/bluetooth/ble/interf/iresponse_listener.dart';
import 'package:wuhan/app/utils/log_manager.dart';

import '../interf/ible_master.dart';
import '../models/command_result.dart';
import 'base_ble_response.dart';
import 'base_command.dart';

abstract class BaseBleMaster extends BaseBleReducer implements IBleMaster {
  final String TAG = 'BaseBleMaster';

  BaseBleMaster(super.deviceId);

  final Map<int, BaseCommand> cmdMaps = {};

  @override
  void connectDevice(void Function(DeviceConnectionState event)? onDeviceState,
      {Duration connectionTimeout = const Duration(seconds: 10)}) async {
    super.connectToDevice(
      (ConnectionStateUpdate event) {
        onDeviceState?.call(event.connectionState);
        this.onDeviceState?.call(event.connectionState);
      },
      connectionTimeout: connectionTimeout,
      onError: (error) {
        onDeviceState?.call(DeviceConnectionState.disconnected);
      },
    );
  }

  @override
  void connectAdvertisingDevice(
      void Function(DeviceConnectionState event)? onDeviceState,
      {Duration prescanDuration = const Duration(seconds: 10),
      Duration connectionTimeout = const Duration(seconds: 10)}) {
    super.connectToAdvertisingDevice(
        (ConnectionStateUpdate event) {
          onDeviceState?.call(event.connectionState);
          this.onDeviceState?.call(event.connectionState);
        },
        withServices: [],
        prescanDuration: prescanDuration,
        connectionTimeout: connectionTimeout,
        onError: (error) {
          onDeviceState?.call(DeviceConnectionState.disconnected);
        });
  }

  @override
  Future<void> writeData(BaseCommand command) async {
    writeCommandData(command);
  }

  @override
  Future<CommandResult<R>> writeDataWithResponse<R extends BaseBleResponse>(
      BaseCommand command) async {
    final completer = Completer<CommandResult<R>>();
    try {
      if (isDisConnected()) {
        LogManager.d('发送命令失败 设备蓝牙未连接', tag: TAG);
        return CommandResult.error('Ble Not Connected');
      }
      if (!cmdMaps.containsKey(command.seq)) {
        cmdMaps[command.seq] = command;
      }
      Timer? timeoutTimer;
      // 设置命令的响应监听器
      command.iResponseListener = IResponseListener(
        onResponseSuccess: (res) {
          timeoutTimer?.cancel();
          cmdMaps.remove(command.seq);
          if (!completer.isCompleted) {
            completer.complete(CommandResult.success(res as R?));
          }
        },
        onResponseFailed: (errCode, errMsg) {
          timeoutTimer?.cancel();
          cmdMaps.remove(command.seq);
          if (!completer.isCompleted) {
            completer.complete(CommandResult<R>.error(errMsg, errCode));
          }
        },
      );
      writeCommandData(command);
      // 处理超时
      timeoutTimer = Timer(Duration(seconds: command.timeout), () {
        LogManager.d('发送命令失败 命令超时command:$command', tag: TAG);
        completer.complete(CommandResult.error('Timeout waiting for response'));
      });
      // 等待响应或超时
      return completer.future;
    } catch (e) {
      LogManager.d('发送命令失败 error:${e.toString()}', tag: TAG);
      return CommandResult.error(e.toString());
    }
  }

  @override
  bool isDisConnected() => super.hasDisConnected();

  @override
  void disconnect() => super.disconnectFromDevice();

  @override
  Future<void> setMTU(int mtu) async {
    await super.setMTU(mtu);
  }

  @override
  Future<void> enableNotification() async {
    await super.enableNotification();
  }

  @override
  void Function(DeviceConnectionState event)? onDeviceState;
}
