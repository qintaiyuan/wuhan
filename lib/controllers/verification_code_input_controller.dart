import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class VerificationCodeInputController extends GetxController {
  Function(String)? onVerificationCodeChangedCallback;
  var countdown = 0.obs;
  var phoneNumber = ''.obs;
  var isEnable = false.obs;
  TextEditingController verificationCodeController = TextEditingController();

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
    // if (phoneNumber.value.length == 11) {
    startCountdown();
    // 添加发送验证码的网络请求逻辑
    // } else {
    //   Get.snackbar('error'.tr, 'invalidPhoneNumber'.tr);
    // }
  }
}
