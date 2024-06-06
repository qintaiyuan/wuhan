import 'package:flutter/cupertino.dart';

import '../../../theme/app_style.dart';
import '../../controllers/bind_device_controller.dart';
import '../widgets/button_group.dart';

class BindDeviceFailedDialog extends StatelessWidget {
  final BindDeviceController controller;

  const BindDeviceFailedDialog({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 14),
        const Text(
          '连接失败',
          style: AppStyle.dialogTitleStyle,
        ),
        Expanded(child: Image.asset('assets/frame/device/fc_2044.webp')),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: ButtonGroup(
            cancelButtonText: '取消',
            confirmButtonText: '重试',
            onCancelPressed: controller.dimissDialog, // Get.back() 是取消按钮的默认操作
            onConfirmPressed: controller.switchGuidePage,
          ),
        )
      ],
    );
  }
}
