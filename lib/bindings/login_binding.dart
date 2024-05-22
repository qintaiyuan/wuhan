import 'package:get/get.dart';
import 'package:wuhan/controllers/login_controller.dart';

class LoginBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}