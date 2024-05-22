import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var phoneNumber = ''.obs;
  var verificationCode = ''.obs;
  var isButtonEnabled = false.obs;
  var agreeToTerms = false.obs;
  var countdown = 0.obs;
  TextEditingController phoneController = TextEditingController();
  TextEditingController verificationCodeController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    phoneController.addListener(() {
      phoneNumber.value = phoneController.text.replaceAll(' ', '');
      _updateButtonState();
    });
  }

  void onPhoneNumberChanged(String value) {
    String formatted = formatPhoneNumber(value);
    if (value != formatted) {
      phoneController.value = phoneController.value.copyWith(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }
    phoneNumber.value = formatted.replaceAll(' ', '');
    _updateButtonState();
  }

  void onVerificationCodeChanged(String value) {
    if (value.length <= 6) {
      verificationCode.value = value;
    } else {
      verificationCode.value = value.substring(0, 6);
      verificationCodeController.text = verificationCode.value;
      verificationCodeController.selection = TextSelection.fromPosition(
        TextPosition(offset: verificationCode.value.length),
      );
    }
    _updateButtonState();
  }

  void _updateButtonState() {
    isButtonEnabled.value =
        phoneNumber.value.length == 11 && verificationCode.value.length == 6;
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

  Future<void> sendVerificationCode() async {
    if (phoneNumber.value.length == 11) {
      startCountdown();
      // 添加发送验证码的网络请求逻辑
    } else {
      Get.snackbar('error'.tr, 'invalidPhoneNumber'.tr);
    }
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

  void clearPhoneNumber() {
    phoneController.clear();
  }

  String formatPhoneNumber(String input) {
    input = input.replaceAll(' ', '');
    if (input.length >= 11) {
      return '${input.substring(0, 3)} ${input.substring(3, 7)} ${input.substring(7, 11)}';
    } else if (input.length >= 7) {
      return '${input.substring(0, 3)} ${input.substring(3, 7)} ${input.substring(7)}';
    } else if (input.length >= 3) {
      return '${input.substring(0, 3)} ${input.substring(3)}';
    }
    return input;
  }
}
