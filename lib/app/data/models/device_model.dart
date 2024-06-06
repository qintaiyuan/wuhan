import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class DeviceInfo extends HiveObject {
  @HiveField(0)
  int deviceId;
  @HiveField(1)
  final String model;
  @HiveField(2)
  final String nickname;
  @HiveField(3)
  final String mac;
  @HiveField(4)
  final String leftSn;
  @HiveField(5)
  final String rightSn;
  @HiveField(6)
  DiscoveredDevice? device;

  DeviceInfo(
      {required this.deviceId,
      required this.model,
      required this.nickname,
      required this.mac,
      required this.leftSn,
      required this.rightSn,
      this.device});

  factory DeviceInfo.fromJson(Map<String, dynamic> json) {
    return DeviceInfo(
      deviceId: json['deviceId'],
      model: json['model'],
      nickname: json['nickname'],
      mac: json['mac'],
      leftSn: json['leftSn'],
      rightSn: json['rightSn'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deviceId': deviceId,
      'model': model,
      'nickname': nickname,
      'mac': mac,
      'leftSn': leftSn,
      'rightSn': rightSn,
    };
  }

  @override
  String toString() {
    return 'DeviceInfo{id: $deviceId, name: $nickname, model: $model, rightSn: $rightSn, leftSn: $leftSn, device: $device}';
  }
}
