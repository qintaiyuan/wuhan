import 'dart:async';

import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:wuhan/app/bluetooth/ble/interf/ible_config.dart';

import '../../../utils/log_manager.dart';
import 'base_command.dart';

abstract class BaseBleReducer implements IBleConfig {
  final String deviceId;
  final FlutterReactiveBle _ble = FlutterReactiveBle();
  final String TAG = 'BaseBleReducer';

  // 连接订阅
  StreamSubscription<ConnectionStateUpdate>? _connection;
  static const int desiredMTUSize = 512;
  var deviceConnectionState = DeviceConnectionState.disconnected;

  BaseBleReducer(this.deviceId);

  // 连接设备
  Future<StreamSubscription<ConnectionStateUpdate>> connectToDevice(
      void Function(ConnectionStateUpdate event)? onData,
      {Duration connectionTimeout = const Duration(seconds: 10),
      Function? onError}) async {
    LogManager.d('connectToDevice for $deviceId', tag: TAG);
    await disconnectFromDevice();
    var profile = getGattProfile();
    _connection = _ble
        .connectToDevice(
      id: deviceId,
      servicesWithCharacteristicsToDiscover: {
        Uuid.parse(profile.serviceUUID): [
          Uuid.parse(profile.rxCharacteristicUUID),
          Uuid.parse(profile.txCharacteristicUUID)
        ]
      },
      connectionTimeout: connectionTimeout,
    )
        .listen((update) async {
      LogManager.d('connectState for $deviceId ${update.connectionState}',
          tag: TAG);
      onData?.call(update);
    }, onError: onError);
    return _connection!;
  }

  //连接advertising设备
  Future<StreamSubscription<ConnectionStateUpdate>> connectToAdvertisingDevice(
      void Function(ConnectionStateUpdate event)? onData,
      {required List<Uuid> withServices,
      Duration prescanDuration = const Duration(seconds: 10),
      Duration connectionTimeout = const Duration(seconds: 10),
      Function? onError}) async {
    LogManager.d('connectToAdvertisingDevice for $deviceId', tag: TAG);
    await disconnectFromDevice();
    var profile = getGattProfile();
    _connection = _ble
        .connectToAdvertisingDevice(
            id: deviceId,
            withServices: withServices,
            prescanDuration: prescanDuration,
            servicesWithCharacteristicsToDiscover: {
              Uuid.parse(profile.serviceUUID): [
                Uuid.parse(profile.rxCharacteristicUUID),
                Uuid.parse(profile.txCharacteristicUUID)
              ]
            },
            connectionTimeout: connectionTimeout)
        .listen((update) async {
      LogManager.d(
          'connectState for device:$deviceId ${update.connectionState}',
          tag: TAG);
      onData?.call(update);
    }, onError: onError);
    return _connection!;
  }

  Future<void> _configureDeviceParameters(
      {required DeviceConnectionState state}) async {
    deviceConnectionState = state;
    if (state == DeviceConnectionState.connected) {
      await setMTU(desiredMTUSize);
      await enableNotification();
      print('enable success');
    }
  }

  bool hasDisConnected() {
    return deviceConnectionState == DeviceConnectionState.disconnected;
  }

  Future<void> disconnectFromDevice() async {
    if (_connection != null) {
      await _connection!.cancel();
      _connection = null;
      LogManager.d('device:$deviceId Disconnected from the device.', tag: TAG);
    }
  }

  Future<void> setMTU(int mtu) async {
    try {
      final mtu =
          await _ble.requestMtu(deviceId: deviceId, mtu: desiredMTUSize);
      LogManager.d('device:$deviceId BLE Status MTU negotiated to $mtu.',
          tag: TAG);
    } catch (e) {
      LogManager.d('device:$deviceId BLE Error Failed to negotiate MTU: $e.',
          tag: TAG);
    }
  }

  Future<void> enableNotification() async {
    var profile = getGattProfile();
    _ble
        .subscribeToCharacteristic(QualifiedCharacteristic(
      serviceId: Uuid.parse(profile.serviceUUID),
      characteristicId: Uuid.parse(profile.rxCharacteristicUUID),
      deviceId: deviceId,
    ))
        .listen((data) {
      LogManager.d('device:$deviceId Received data: $data.', tag: TAG);
      parseData(data);
    }, onError: (error) {
      LogManager.d('device:$deviceId BLE Error Notification error: $error.',
          tag: TAG);
    });
  }

  Future<void> readData(Uuid characteristicUuid) async {
    var profile = getGattProfile();
    final result = await _ble.readCharacteristic(
      QualifiedCharacteristic(
        serviceId: Uuid.parse(profile.serviceUUID),
        characteristicId: Uuid.parse(profile.readcharacteristicUuid),
        deviceId: deviceId,
      ),
    );
    LogManager.d('device:$deviceId Read data: $result.', tag: TAG);
  }

  Future<void> writeCommandData(BaseCommand command) async {
    var profile = getGattProfile();
    final characteristic = QualifiedCharacteristic(
      serviceId: Uuid.parse(profile.serviceUUID),
      characteristicId: Uuid.parse(profile.txCharacteristicUUID),
      deviceId: deviceId,
    );
    await _ble.writeCharacteristicWithoutResponse(characteristic,
        value: command.getData());
  }
}
