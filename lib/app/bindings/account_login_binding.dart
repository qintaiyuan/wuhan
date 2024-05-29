import 'package:get/get.dart';
import '../controllers/account_login_controller.dart';
import '../data/repositories/passport_respository.dart';

class AccountLoginBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => PassportRespository());
    Get.put(AccountLoginController());
  }

}