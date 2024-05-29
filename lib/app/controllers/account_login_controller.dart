import 'package:get/get.dart';

import '../data/repositories/passport_respository.dart';
import '../routes/navigation_service.dart';

class AccountLoginController extends GetxController {
  var phoneNumber = ''.obs;
  var isButtonEnabled = false.obs;
  var passWord = ''.obs;
  var agreeToTerms = false.obs;
  final PassportRespository _passportRepository = Get.find();

  @override
  void onInit() {
    super.onInit();
    ever(phoneNumber, (value) => {_updateButtonState()});
    ever(passWord, (value) => {_updateButtonState()});
  }

  void _updateButtonState() {
    isButtonEnabled.value =
        phoneNumber.value.length == 11 && passWord.value.length >= 8;
  }

  Future<void> login() async {
    if (!agreeToTerms.value) {
      Get.snackbar('error'.tr, 'agreeToTermsError'.tr);
      return;
    }
    try {
      // 发送登录请求
      var response = await _passportRepository.loginWithPassword(
          phoneNumber.value, passWord.value);
      if (response.isSuccess()) {
        Get.snackbar('message'.tr, 'loginSuccess'.tr);
        NavigationService.offAndToHomePage();
      } else {
        Get.snackbar('error'.tr, response.message.toString());
      }
    } catch (e) {
      Get.snackbar('error'.tr, 'netNotConnected'.tr);
    }
  }
}
