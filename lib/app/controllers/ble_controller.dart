import 'dart:async';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wuhan/extensions.dart';

class BleController extends GetxController {
  final FlutterReactiveBle _ble = FlutterReactiveBle();
  final RxList<DiscoveredDevice> devicesList = <DiscoveredDevice>[].obs;
  late StreamSubscription<DiscoveredDevice> _scanStream;

  void startScan() async {
    if (await _requestPermissions()) {
      _scanStream = _ble.scanForDevices(
          withServices: [],
          scanMode: ScanMode.lowLatency).listen((device) {
        Uint8List byteArray = Uint8List.fromList([0x12, 0x34, 0xAB, 0xCD]);
        print(byteArray.toHexString()); // 输出：0x1234ABCD
        print('scanDevice---${device}');
        print('scanDevice---${device.manufacturerData.toHexString()}');
        final existingDevice = devicesList.firstWhere((d) => d.id == device.id,
            orElse: () => DiscoveredDevice(
                  id: '',
                  name: '',
                  serviceData: {},
                  manufacturerData: Uint8List(0),
                  rssi: 0,
                  serviceUuids: [],
                ));

        if (existingDevice.id.isEmpty) {
          devicesList.add(device);
          print('-----scanDevice---$device');
        }
      });
    } else {
      // Handle permission denial
      print("Permission denied");
    }
  }

  void stopScan() {
    _scanStream.cancel();
  }

  @override
  void onClose() {
    _scanStream.cancel();
    super.onClose();
  }

  Future<bool> _requestPermissions() async {
    final status = await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.bluetoothAdvertise,
      Permission.location
    ].request();

    return status[Permission.location]!.isGranted &&
        status[Permission.bluetoothScan]!.isGranted &&
        status[Permission.bluetoothConnect]!.isGranted &&
        status[Permission.bluetoothAdvertise]!.isGranted;
  }
}
