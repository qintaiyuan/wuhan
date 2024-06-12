class GattProfile {
  final String serviceUUID;
  final String txCharacteristicUUID;
  final String rxCharacteristicUUID;
  final String readcharacteristicUuid; // readData 特征

  GattProfile({
    required this.serviceUUID,
    required this.txCharacteristicUUID,
    required this.rxCharacteristicUUID,
    this.readcharacteristicUuid = ''
  });
}
