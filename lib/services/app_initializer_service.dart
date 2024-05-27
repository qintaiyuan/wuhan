import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wuhan/constants/constants.dart';

import '../app/bindings/initial_binding.dart';
import '../app/data/adapter/device_adapter.dart';

class AppInitializer extends GetxService {
  // 初始化函数
  Future<AppInitializer> initialize() async {
    await _initHive();
    await _initBindings();
    if (kDebugMode) {
      print("App initialized");
    }
    return this;
  }

  // 初始化hive
  Future<void> _initHive() async {
    // 初始化Hive
    await Hive.initFlutter();
    // 注册 DeviceAdapter
    Hive.registerAdapter(DeviceAdapter());
  }

  //
  Future<void> _initBindings() async {
    await InitialBindings().dependencies(); // 确保初始化依赖注入完成
  }
}
