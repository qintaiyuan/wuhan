import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wuhan/app/controllers/bind_device_success_controller.dart';

import '../../../theme/app_style.dart';
import '../../controllers/bind_device_controller.dart';
import '../widgets/submit_button.dart';

class BindDeviceSuccessDialog extends StatelessWidget {
  final BindDeviceController controller;

  const BindDeviceSuccessDialog({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final BindDeviceSuccessController controller =
        Get.put<BindDeviceSuccessController>(
      BindDeviceSuccessController(),
      tag: '${UniqueKey().toString()}_bind_device_success',
      permanent: false,
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 14),
        const Text(
          '连接成功',
          style: AppStyle.dialogTitleStyle,
        ),
        // SizedBox(height: 20),
        Expanded(
          child: Obx(() {
            return Image.asset(
              controller.frameImages3[controller.currentFrame.value],
            );
          }),
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: SubmitButton(text: '完成', onPressed: () => {}),
        )
      ],
    );
  }
}
