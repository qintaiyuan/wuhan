import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wuhan/app/controllers/home_controller.dart';

import '../widgets/device_empty.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final currentDevice = controller.currentDevice.value;
        if (currentDevice == null) {
          return const DeviceEmpty();
          // return FullWidthContainerExample();
        } else {
          return Center(child: Text('Connected to: ${currentDevice.nickname}'));
        }
      }),
    );
  }
}
