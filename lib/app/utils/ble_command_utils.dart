class BleCommandUtils {
  static int _seq = -128; // Byte.MIN_VALUE in Dart

  static int getBleCmdSeq() {
    _seq++;
    if (_seq > 127) { // Byte.MAX_VALUE in Dart
      _seq = -128;
    }
    return _seq;
  }
}