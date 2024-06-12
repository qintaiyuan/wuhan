import 'package:wuhan/app/bluetooth/ble/base/base_ble_master.dart';
import 'package:wuhan/app/bluetooth/ble/models/gatt_profile.dart';

class AnchorBleMaster extends BaseBleMaster {
  AnchorBleMaster(super.deviceId);

  @override
  GattProfile getGattProfile() {
    return GattProfile(
        serviceUUID: '0000AF00-0000-1000-8000-00805F9B34FB',
        txCharacteristicUUID: '0000AF05-0000-1000-8000-00805F9B34FB',
        rxCharacteristicUUID: '0000AF06-0000-1000-8000-00805F9B34FB');
  }

  @override
  void parseData(List<int> data) {}
}
