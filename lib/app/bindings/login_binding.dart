import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import '../data/repositories/passport_respository.dart';

class LoginBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => PassportRespository());
    Get.put(LoginController());
  }
}