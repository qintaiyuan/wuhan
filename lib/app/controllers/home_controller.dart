import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wuhan/app/bluetooth/ble/interf/ible_service.dart';
import 'package:wuhan/app/bluetooth/ble/services/ble_service.dart';
import 'package:wuhan/app/data/models/device_model.dart';
import 'package:wuhan/app/data/models/unlogin_event_model.dart';
import 'package:wuhan/app/routes/navigation_service.dart';

import '../../services/device_service.dart';
import '../../services/event_bus_service.dart';
import '../bluetooth/ble/interf/idevice_controller.dart';

class HomeController extends GetxController {
  final DeviceService _deviceService = Get.find<DeviceService>();

  Rx<DeviceInfo?> get currentDevice => _deviceService.currentDevice;
  final BleService _bleService = Get.find<BleService>();

  Rxn<IdeviceController> get curDeviceController =>
      _bleService.curDeviceController;

  var items = List.generate(20, (index) => 'Item ${index + 1}').obs;

  Future<void> refreshItems() async {
    await Future.delayed(const Duration(seconds: 2));
    items.value = List.generate(20, (index) => 'Refreshed Item ${index + 1}');
  }

  @override
  void onInit() {
    super.onInit();
    // 订阅事件
    Get.find<EventBus>().on<UnLoginEvent>().listen((event) {
      NavigationService.offAndLoginPage();
    });
    // _deviceService.fetchDevicesFromNetwork();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   // 在页面加载完成后立即调用检测方法
    //   showLoadingDialog();
    // });
  }

  void _clearResources() {}
}
