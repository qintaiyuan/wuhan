import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var phoneNumber = ''.obs;
  var verificationCode = ''.obs;
  var isButtonEnabled = false.obs;
  var agreeToTerms = false.obs;

  TextEditingController verificationCodeController = TextEditingController();

  void onPhoneNumberChanged(String value) {
    phoneNumber.value = value;
    _updateButtonState();
  }

  void onVerificationCodeChanged(String value) {
    verificationCode.value = value;
    _updateButtonState();
  }

  void _updateButtonState() {
    isButtonEnabled.value =
        phoneNumber.value.length == 11 && verificationCode.value.length == 6;
  }

  Future<void> login() async {
    if (!agreeToTerms.value) {
      Get.snackbar('error'.tr, 'agreeToTermsError'.tr);
    } else if (isButtonEnabled.value) {
      // 添加登录的网络请求逻辑
    } else {
      Get.snackbar('error'.tr, 'invalidCredentials'.tr);
    }
  }
}
