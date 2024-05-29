import 'dart:convert';

import 'package:crypto/crypto.dart';

class HashCalculator {
  String getHashUsingHmacSHA256(String token, String text) {
    var key = utf8.encode(token);
    var bytes = utf8.encode(text);

    var hmacSha256 = Hmac(sha256, key);
    var digest = hmacSha256.convert(bytes);

    return digest.toString();
  }
}
