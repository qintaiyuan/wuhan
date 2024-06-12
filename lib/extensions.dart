import 'dart:typed_data';

extension SortedQueryString on Map<String, String> {
  String toSortedQueryString() {
    if (isEmpty) return '';
    final sortedEntries = entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    final queryString = sortedEntries.map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}').join('&');
    return queryString;
  }
}

extension PhoneNumberFormatter on String {
  String formatPhoneNumber() {
    if (length != 11) {
      throw ArgumentError('Invalid phone number length. Expected length is 11.');
    }

    String start = substring(0, 3);
    String end = substring(7);

    return '$start****$end';
  }
}

extension ByteArrayExtensions on Uint8List {
  String toHexString({String prefix = '0x', String separator = ''}) {
    return '$prefix${map((byte) => byte.toRadixString(16).padLeft(2, '0')).join(separator).toUpperCase()}';
  }
}

extension ByteArrayExtension on List<int> {
  bool isMatch(List<int> pattern) {
    if (length < pattern.length) return false;

    bool flag = true;
    for (int i = 0; i < pattern.length; i++) {
      if ((this[i] & pattern[i]) != pattern[i]) {
        flag = false;
        break;
      }
    }
    return flag;
  }
}

extension IntExtension on int {
  bool isOne(int pos) {
    return (this >> pos) & 1 == 1;
  }
}

extension ListExtension<T> on List<T> {
  String toMacAddress({bool isReverse = true}) {
    List<int> macBytes = List<int>.from(this);

    if (isReverse) {
      // 交换第0位和第1位
      int temp0 = macBytes[0];
      macBytes[0] = macBytes[1];
      macBytes[1] = temp0;

      // 交换第3位和第5位
      int temp3 = macBytes[3];
      macBytes[3] = macBytes[5];
      macBytes[5] = temp3;
    }

    // 转换为Mac地址字符串
    return macBytes.map((byte) => byte.toRadixString(16).padLeft(2, '0').toUpperCase()).join(':');
  }
}

extension IntExtensions on int {
  List<int> toByteArray({bool fullInt = true}) {
    int len = fullInt ? 4 : 2;
    List<int> targets = List.filled(len, 0);

    if (len == 4) {
      targets[3] = this & 0xFF;
      targets[2] = (this >> 8) & 0xFF;
      targets[1] = (this >> 16) & 0xFF;
      targets[0] = (this >> 24) & 0xFF;
    } else {
      targets[1] = this & 0xFF;
      targets[0] = (this >> 8) & 0xFF;
    }

    return targets;
  }
}
