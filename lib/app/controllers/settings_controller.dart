import 'package:get/get.dart';
import 'package:wuhan/app/routes/navigation_service.dart';
import 'package:wuhan/extensions.dart';
import 'package:wuhan/services/user_service.dart';

class SettingsController extends GetxController {
  final UserService _userService = Get.find();

  var phoneNumber = ''.obs;
  @override
  void onInit() {
    super.onInit();
    phoneNumber.value = _userService.user.value?.phone.formatPhoneNumber() ?? '';
  }
  void logout() {
    _userService.clearUser();
    NavigationService.offAndLoginPage();
  }

  void navigateTo(String route) {
    // Handle navigation logic here
    Get.toNamed(route);
  }
}
