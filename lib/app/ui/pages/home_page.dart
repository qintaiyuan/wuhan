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
        final currentController = controller.curDeviceController.value;
        if (currentDevice == null) {
          return const DeviceEmpty();
        } else {
          return RefreshIndicator(
              onRefresh: controller.refreshItems,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: 30,
                itemBuilder: (context, index) {
                  return Card(
                    child: Center(
                      child: Text('Item $index'),
                    ),
                  );
                },
              ),
              // child:  Column(
              //   children: [
              //     Text('Connected to: ${currentDevice.nickname}'),
              //     Text(
              //         'Connect state: ${currentController?.connectionState.value}'),
              //   ],
              // )
          );
          // Column(
          //   children: [
          //     Text('Connected to: ${currentDevice.nickname}'),
          //     Text('Connect state: ${currentController?.connectionState.value}'),
          //   ],
          // );
        }
      }),
    );
  }
}
