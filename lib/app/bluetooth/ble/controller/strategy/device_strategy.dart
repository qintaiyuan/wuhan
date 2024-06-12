import '../../../../../constants/Constants.dart';

abstract class DeviceStrategy {
  final String deviceId;
  final String deviceModel;
  DeviceStrategy(this.deviceId, this.deviceModel);

  @override
  String toString() {
    return 'deviceId:$deviceId  deviceModel:$deviceModel';
  }
}
class AnchorDeviceStrategy extends DeviceStrategy {
  AnchorDeviceStrategy(String deviceId)
      : super(deviceId, anchorModel);
}
