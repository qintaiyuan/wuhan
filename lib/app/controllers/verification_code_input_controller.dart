import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../network/services/network_service.dart';
class VerificationCodeInputController extends GetxController {
  Function(String)? onVerificationCodeChangedCallback;
  var countdown = 0.obs;
  var phoneNum = "".obs;
  var isEnable = false.obs;
  TextEditingController verificationCodeController = TextEditingController();
  final NetworkService _networkService = Get.find();

  @override
  void onInit() {
    super.onInit();
    verificationCodeController.addListener(() {
      onVerificationCodeChanged(verificationCodeController.text);
    });
  }

  void startCountdown() {
    countdown.value = 60;
    _updateCountdown();
  }

  void _updateCountdown() {
    if (countdown.value > 0) {
      Future.delayed(const Duration(seconds: 1), () {
        countdown.value--;
        _updateCountdown();
      });
    }
  }

  void onVerificationCodeChanged(String value) {
    String formatted = value.length > 6 ? value.substring(0, 6) : value;
    if (value != formatted) {
      verificationCodeController.text = value.substring(0, 6);
      verificationCodeController.selection = TextSelection.fromPosition(
        TextPosition(offset: formatted.length),
      );
    }
    if (onVerificationCodeChangedCallback != null) {
      onVerificationCodeChangedCallback!(formatted);
    }
    // _updateButtonState();
  }

  Future<void> sendVerificationCode() async {
    try {
      var response = await _networkService.post(
        '/passport/v1/codes',
        data: {
          'phone': phoneNum.value,
          'type': "1",
        },
        fromJsonT: (json) => json as bool,
      );
      Get.snackbar('message', response.message.toString());
      print(response.message);
      startCountdown();
    } catch (e) {
      Get.snackbar('error'.tr, e.toString());
      print("-------error=${e.toString()}");
    }
  }
}
