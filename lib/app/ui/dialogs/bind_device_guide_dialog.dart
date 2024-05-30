import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:wuhan/app/controllers/bind_device_controller.dart';
import 'package:wuhan/theme/app_style.dart';

import '../widgets/button_group.dart';

class BindDeviceGuideDialog extends StatelessWidget {
  final BindDeviceController controller;

  const BindDeviceGuideDialog({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 14),
        const Text(
          '配置导向',
          style: AppStyle.dialogTitleStyle,
        ),
        const SizedBox(height: 18),
        const Text(
          '请佩戴眼镜，并长按镜腿左右触控区2秒',
          style: AppStyle.dialogDescStyle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 30),
        FutureBuilder(
          future: _loadLottieAnimation(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // 加载中的指示器
            } else {
              return Lottie.asset(
                snapshot.data != null
                    ? snapshot.data!
                    : 'assets/loading_animation.json',
                width: double.infinity,
                height: 220,
              );
            }
          },
        ),
        const Spacer(),
        ButtonGroup(
          cancelButtonText: '取消',
          confirmButtonText: '开始添加',
          onCancelPressed: controller.dimissDialog, // Get.back() 是取消按钮的默认操作
          onConfirmPressed: controller.searchDevice,
        ),
      ],
    );
  }

  Future<String> _loadLottieAnimation() async {
    // 模拟异步加载动画文件
    await Future.delayed(const Duration(milliseconds: 200));
    return 'assets/anims/config_guide.json'; // 加载完成后返回动画文件路径
  }
}
