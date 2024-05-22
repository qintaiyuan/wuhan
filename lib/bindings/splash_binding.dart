import 'package:get/get.dart';
import 'package:wuhan/controllers/splash_controller.dart';

import '../controllers/agreement_controller.dart';

class SplashBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(SplashController());
    Get.put(AgreementController());
  }

}