import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wuhan/theme/app_style.dart';

import '../../../constants/constants.dart';
import '../../../theme/app_colors.dart';
import '../../controllers/bind_device_controller.dart';
import '../../routes/navigation_service.dart';
import '../widgets/submit_button.dart';

class BindDeviceAddDialog extends StatelessWidget {
  final BindDeviceController controller;

  const BindDeviceAddDialog({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 14),
        const Text(
          '添加设备',
          style: AppStyle.dialogTitleStyle,
        ),
        // SizedBox(height: 20),
        Lottie.asset(
          'assets/anims/device_search.json',
          width: double.infinity,
          height: 220,
        ),
        // SizedBox(height: 20),
        const Spacer(),
        Text.rich(
          textAlign: TextAlign.center,
          TextSpan(children: [
            const TextSpan(
              text: '没有查找到我的设备？',
              style: TextStyle(
                  fontSize: 12,
                  color: AppColors.color500,
                  fontWeight: FontWeight.w400),
            ),
            WidgetSpan(
              child: GestureDetector(
                onTap: () => NavigationService.launchURL(aPPExperience),
                child: const Text(
                  '查看原因',
                  style: TextStyle(
                      fontSize: 12,
                      color: AppColors.colorDefault,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ]),
        ),
        const SizedBox(height: 8),
        SubmitButton(
            text: '取消',
            textColor: AppColors.color800,
            enabledColor: AppColors.color100,
            onPressed: controller.dimissDialog)
      ],
    );
  }
}
