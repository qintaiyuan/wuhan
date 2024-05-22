import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wuhan/controllers/splash_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final SplashController controller = Get.find();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 在页面加载完成后立即调用检测方法
      controller.checkCurState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Image.asset(
        'assets/images/ic_splash.png',
        height: 100,
        width: 100,
      ),
    ));
  }
}
