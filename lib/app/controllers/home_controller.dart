import 'package:get/get.dart';
import 'package:wuhan/app/data/models/device_model.dart';

import '../../services/device_service.dart';

class HomeController extends GetxController{
  final DeviceService _deviceService = Get.find<DeviceService>();
  Rx<DeviceInfo?> get currentDevice => _deviceService.currentDevice;
}