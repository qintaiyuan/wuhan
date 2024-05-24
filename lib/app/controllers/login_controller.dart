import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wuhan/app/data/models/user_model.dart';
import 'package:wuhan/services/navigation_service.dart';

import '../../services/user_service.dart';
import '../network/services/network_service.dart';

class LoginController extends GetxController {
  var phoneNumber = ''.obs;
  var verificationCode = ''.obs;
  var isButtonEnabled = false.obs;
  var agreeToTerms = false.obs;
  final NetworkService _networkService = Get.find();
  final UserService _userService = Get.find();
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
      return;
    }

    if (!isButtonEnabled.value) {
      Get.snackbar('error'.tr, 'invalidCredentials'.tr);
      return;
    }

    try {
      // 发送登录请求
      var response = await _networkService.post<UserAccount>(
        '/passport/v1/login',
        data: {
          "identityType": "1",
          "identifier": phoneNumber.value,
          "credential": verificationCode.value,
          "platform": "1"
        },
        fromJsonT: (json) => UserAccount.fromJson(json as Map<String, dynamic>),
      );

      if (response.code == 200) {
        Get.snackbar('message', "登录成功");
        _userService.setUser(response.data as UserAccount);
        NavigationService.offAndToHomePage();
      } else {
        Get.snackbar('error'.tr, response.message.toString());
        print(response.message);
      }
    } catch (e) {
      Get.snackbar('error'.tr, 'networkError'.tr);
      print('Network error: $e');
    }
  }
}
