import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wuhan/app/controllers/bind_device_connecting_controller.dart';

import '../../../theme/app_style.dart';
import '../../controllers/bind_device_controller.dart';
import '../../data/models/bind_device_state_model.dart';
import '../widgets/button_group.dart';
import '../widgets/submit_button.dart';

class BindDeviceConnectingDialog extends StatelessWidget {
  final BindDeviceController controller;

  const BindDeviceConnectingDialog({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final BindDeviceConnectingController connectingController =
        Get.put<BindDeviceConnectingController>(
      BindDeviceConnectingController(bindDeviceController: controller),
      tag: '${UniqueKey().toString()}_bind_device_connecting',
      permanent: false,
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 14),
        const Text(
          '正在连接',
          style: AppStyle.dialogTitleStyle,
        ),
        Expanded(
          child: Obx(() {
            if (connectingController.isPlayingFirstAnimation.isTrue) {
              return Image.asset(
                connectingController
                    .frameImages1[connectingController.currentFrame1.value],
              );
            } else {
              return Image.asset(
                connectingController
                    .frameImages2[connectingController.currentFrame2.value],
              );
            }
          }),
        ),
        Container(height: 50)
      ],
    );
  }
}
