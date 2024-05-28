import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wuhan/app/data/repositories/passport_respository.dart';

import '../network/services/network_service.dart';

class VerificationCodeInputController extends GetxController {
  Function(String)? onVerificationCodeChangedCallback;
  var countdown = 0.obs;
  var phoneNum = "".obs;
  var isEnable = false.obs;
  TextEditingController verificationCodeController = TextEditingController();
  final PassportRespository _passportRepository = Get.find();

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
  }

  Future<void> sendVerificationCode() async {
    try {
      var response =
          await _passportRepository.fetchVerificationCode(phoneNum.value);
      if (response.isSuccess()) {
        Get.snackbar('message'.tr, 'sendSuccess'.tr);
        startCountdown();
      } else {
        Get.snackbar('error'.tr, response.message?? 'netNotConnected'.tr);
      }
    } catch (e) {
      Get.snackbar('error'.tr, 'netNotConnected'.tr);
    }
  }
}
