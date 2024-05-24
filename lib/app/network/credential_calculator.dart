import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import '../../constants/constants.dart';
import '../../services/user_service.dart';

class CredentialCalculator {
  final String postParameter;
  final HttpType type;
  final UserService _userService = Get.find();
  CredentialCalculator({
    required this.postParameter,
    required this.type,
  });

  String _md5(String input) {
    var bytes = utf8.encode(input);
    var digest = md5.convert(bytes);
    return digest.toString().padLeft(32, '0');
  }

  String _signature(String nounce, String timeStamp) {
    String text = (type == HttpType.Get)
        ? (postParameter.isEmpty
        ? 'nonce=$nounce&timestamp=$timeStamp'
        : '$postParameter&nonce=$nounce&timestamp=$timeStamp')
        : (postParameter.isEmpty
        ? 'nonce=$nounce&timestamp=$timeStamp'
        : 'data=$postParameter&nonce=$nounce&timestamp=$timeStamp');
    String passToken = _userService.user.value?.passToken ?? '';
    String key = passToken.isEmpty ? serviceToken : '$serviceToken$passToken';

    var hmacSha256 = Hmac(sha256, utf8.encode(key));
    var digest = hmacSha256.convert(utf8.encode(text));
    return digest.toString();
  }

  String getAuthInfo() {
    final timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    final nounce = _md5((int.parse(timeStamp) + Random().nextInt(10000)).toString());
    return 'HEXA1-HMAC-SHA256 nonce=$nounce, timestamp=$timeStamp, signature=${_signature(nounce, timeStamp.toString())}';
  }
}

enum HttpType { Post, Get }
