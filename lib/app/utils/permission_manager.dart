import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  static Future<bool> requestBluetoothAndLocationPermissions() async {
    final status = await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.bluetoothAdvertise,
      Permission.location,
    ].request();

    return status[Permission.location]?.isGranted == true &&
        status[Permission.bluetoothScan]?.isGranted == true &&
        status[Permission.bluetoothConnect]?.isGranted == true &&
        status[Permission.bluetoothAdvertise]?.isGranted == true;
  }
}
