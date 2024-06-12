import '../models/gatt_profile.dart';

abstract class IBleConfig {
  GattProfile getGattProfile();

  void parseData(List<int> data);
}
