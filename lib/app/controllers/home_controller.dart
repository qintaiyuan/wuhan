import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wuhan/app/data/models/device_model.dart';
import 'package:wuhan/app/data/models/unlogin_event_model.dart';
import 'package:wuhan/app/routes/navigation_service.dart';

import '../../services/device_service.dart';
import '../../services/event_bus_service.dart';

class HomeController extends GetxController {
  final DeviceService _deviceService = Get.find<DeviceService>();
  Rx<DeviceInfo?> get currentDevice => _deviceService.currentDevice;

  @override
  void onInit() {
    super.onInit();
    // 订阅事件
    Get.find<EventBus>().on<UnLoginEvent>().listen((event) {
      NavigationService.offAndLoginPage();
    });
    _deviceService.fetchDevicesFromNetwork();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   // 在页面加载完成后立即调用检测方法
    //   showLoadingDialog();
    // });
  }

  void _clearResources() {

  }
}
