import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:wuhan/theme/app_style.dart';

import '../../../constants/constants.dart';
import '../../../theme/app_colors.dart';
import '../../controllers/bind_device_controller.dart';
import '../../routes/navigation_service.dart';
import '../widgets/button_group.dart';
import '../widgets/submit_button.dart';

class BindDeviceFindOneDialog extends StatelessWidget {
  final BindDeviceController controller;

  const BindDeviceFindOneDialog({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    var deviceInfo = controller.devicesList.first;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/icon_normal_anchor_glass.webp', height: 252),
        // const Spacer(),
        Text(
            deviceInfo.nickname,
            maxLines: 1,
            overflow: TextOverflow.ellipsis, // 溢出时使用省略号
            style: AppStyle.dialogDeviceNameStyle
        ),
        const SizedBox(height: 8),
        Text.rich(
          textAlign: TextAlign.center,
          TextSpan(children: [
            const TextSpan(
              text: '不是我的设备 ',
              style: TextStyle(
                  fontSize: 12,
                  color: AppColors.color500,
                  fontWeight: FontWeight.w400),
            ),
            WidgetSpan(
              child: GestureDetector(
                onTap: controller.seeMoreDevice,
                child: const Text(
                  '查看更多',
                  style: TextStyle(
                      fontSize: 12,
                      color: AppColors.colorDefault,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ]),
        ),
        // const SizedBox(height: 20),
        const Spacer(),
        ButtonGroup(
          cancelButtonText: '取消',
          confirmButtonText: '连接',
          onCancelPressed: controller.dimissDialog, // Get.back() 是取消按钮的默认操作
          onConfirmPressed: () => {
            controller.bindDevice(deviceInfo)
          },
        ),
      ],
    );
  }
}
