import 'package:get/get.dart';

import '../constants.dart';
import '../services/data_service.dart';
import '../services/navigation_service.dart';
import '../services/user_service.dart';

class AgreementController extends GetxController {
  final DataService _dataService = Get.find<DataService>();
  final UserService _userService = Get.find();
  var agreeToTerms = false.obs;
  var joinUserExperience = false.obs;

  void checkState() {
    _dataService.putBool(userPrivicyAgreement, true);
    _closeDialog();
    if(_userService.getUser() == null) {
      NavigationService.offAndLoginPage();
    } else {
      NavigationService.offAndToHomePage();
    }
  }

  void _closeDialog() {
    Get.back();
  }
}
