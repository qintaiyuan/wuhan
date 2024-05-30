import 'package:get/get.dart';
import 'package:wuhan/app/controllers/settings_controller.dart';

class SettingsBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(SettingsController());
  }

}