class GattProfile {
  final String serviceUUID;
  final String txCharacteristicUUID;
  final String rxCharacteristicUUID;

  GattProfile({
    required this.serviceUUID,
    required this.txCharacteristicUUID,
    required this.rxCharacteristicUUID,
  });
}
