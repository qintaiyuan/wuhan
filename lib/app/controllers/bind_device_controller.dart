import 'package:get/get.dart';

import '../data/models/bind_device_state_model.dart';

class BindDeviceController extends GetxController{
  var currentScreen = DeviceBindState.SETUP_GUIDE.obs;

  void _switchScreen(DeviceBindState screen) {
    currentScreen.value = screen;
  }

  void searchDevice() {
    _switchScreen(DeviceBindState.ADD_DEVICE);
  }

  void dimissDialog() {
    Get.back();
  }
}