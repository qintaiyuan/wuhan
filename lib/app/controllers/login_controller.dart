import 'package:get/get.dart';
import 'package:wuhan/app/routes/navigation_service.dart';

import '../data/repositories/passport_respository.dart';

class LoginController extends GetxController {
  var phoneNumber = ''.obs;
  var verificationCode = ''.obs;
  var isButtonEnabled = false.obs;
  var agreeToTerms = false.obs;
  final PassportRespository _passportRepository = Get.find();

  @override
  void onInit() {
    super.onInit();
    ever(verificationCode, (value) => {_updateButtonState()});
    ever(phoneNumber, (value) => _updateButtonState());
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
      var response = await _passportRepository.loginWithVerificationCode(
          phoneNumber.value, verificationCode.value);
      if (response.isSuccess()) {
        Get.snackbar('message'.tr, 'loginSuccess'.tr);
        NavigationService.offAndToHomePage();
      } else {
        Get.snackbar('error'.tr, response.message.toString());
      }
    } catch (e) {
      Get.snackbar('error'.tr, 'netNotConnected'.tr);
      print('Network error: $e');
    }
  }
}
