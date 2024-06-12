import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wuhan/app/data/models/binding_state.dart';

import 'bind_device_controller.dart';

class BindDeviceConnectingController extends GetxController
    with GetTickerProviderStateMixin {
  final BindDeviceController bindDeviceController;
  late AnimationController animationController1;
  late AnimationController animationController2;
  late Animation<int> animation1;
  late Animation<int> animation2;
  var currentFrame1 = 0.obs;
  var currentFrame2 = 0.obs;
  var isPlayingFirstAnimation = true.obs;
  final List<String> frameImages1 = [
    'assets/frame/device/fc_1000.webp',
    'assets/frame/device/fc_1001.webp',
    'assets/frame/device/fc_1002.webp',
    'assets/frame/device/fc_1003.webp',
    'assets/frame/device/fc_1004.webp',
    'assets/frame/device/fc_1005.webp',
    'assets/frame/device/fc_1006.webp',
    'assets/frame/device/fc_1007.webp',
    'assets/frame/device/fc_1008.webp',
    'assets/frame/device/fc_1008.webp',
    'assets/frame/device/fc_1010.webp',
    'assets/frame/device/fc_1011.webp',
    'assets/frame/device/fc_1012.webp',
    'assets/frame/device/fc_1013.webp',
    'assets/frame/device/fc_1014.webp',
    'assets/frame/device/fc_1015.webp',
  ];
  final List<String> frameImages2 = [
    'assets/frame/device/fc_2000.webp',
    'assets/frame/device/fc_2001.webp',
    'assets/frame/device/fc_2002.webp',
    'assets/frame/device/fc_2003.webp',
    'assets/frame/device/fc_2004.webp',
    'assets/frame/device/fc_2005.webp',
    'assets/frame/device/fc_2006.webp',
    'assets/frame/device/fc_2007.webp',
    'assets/frame/device/fc_2008.webp',
    'assets/frame/device/fc_2009.webp',
    'assets/frame/device/fc_2010.webp',
    'assets/frame/device/fc_2011.webp',
    'assets/frame/device/fc_2012.webp',
    'assets/frame/device/fc_2013.webp',
    'assets/frame/device/fc_2014.webp',
    'assets/frame/device/fc_2015.webp',
    'assets/frame/device/fc_2016.webp',
    'assets/frame/device/fc_2017.webp',
    'assets/frame/device/fc_2018.webp',
    'assets/frame/device/fc_2019.webp',
    'assets/frame/device/fc_2020.webp',
    'assets/frame/device/fc_2021.webp',
    'assets/frame/device/fc_2022.webp',
    'assets/frame/device/fc_2023.webp',
    'assets/frame/device/fc_2024.webp',
    'assets/frame/device/fc_2025.webp',
    'assets/frame/device/fc_2026.webp',
    'assets/frame/device/fc_2027.webp',
    'assets/frame/device/fc_2028.webp',
    'assets/frame/device/fc_2029.webp',
    'assets/frame/device/fc_2030.webp',
    'assets/frame/device/fc_2031.webp',
    'assets/frame/device/fc_2032.webp',
    'assets/frame/device/fc_2033.webp',
    'assets/frame/device/fc_2034.webp',
    'assets/frame/device/fc_2035.webp',
    'assets/frame/device/fc_2036.webp',
    'assets/frame/device/fc_2037.webp',
    'assets/frame/device/fc_2038.webp',
    'assets/frame/device/fc_2039.webp',
    'assets/frame/device/fc_2041.webp',
    'assets/frame/device/fc_2042.webp',
    'assets/frame/device/fc_2043.webp',
    'assets/frame/device/fc_2044.webp',
  ];

  BindDeviceConnectingController({required this.bindDeviceController});

  @override
  void onInit() {
    super.onInit();
    animationController1 = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    animationController2 = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    animation1 = IntTween(begin: 0, end: frameImages1.length - 1)
        .animate(animationController1)
      ..addListener(() {
        currentFrame1.value = animation1.value;
      })
      ..addStatusListener((status) async {
        if (status == AnimationStatus.completed) {
          isPlayingFirstAnimation.value = false;
          _disposeAnim1();
          currentFrame1.value = frameImages1.length - 1;
          animationController2.forward();
        }
      });

    animation2 = IntTween(begin: 0, end: frameImages2.length - 1)
        .animate(animationController2)
      ..addListener(() {
        currentFrame2.value = animation2.value;
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          switch (bindDeviceController.bindState.value) {
            case BindingState.CONNECTING:
              animationController2.reset(); // 重置动画值
              animationController2.forward(); // 重新启动动画
              break;
            case BindingState.SUCCESS:
              bindDeviceController.switchSuccessPage();
              break;
            case BindingState.FAILED:
              bindDeviceController.switchFailedPage();
              break;
          }
        }
      });
    _preloadImages1();
    _preloadImages2();
  }

  Future<void> _preloadImages1() async {
    for (String imagePath in frameImages1) {
      await precacheImage(AssetImage(imagePath), Get.context!);
    }
    animationController1.forward();
  }

  Future<void> _preloadImages2() async {
    for (String imagePath in frameImages2) {
      await precacheImage(AssetImage(imagePath), Get.context!);
    }
  }

  void _disposeAnim1() {
    try {
      animationController1.dispose();
    } catch (e) {}
  }

  void _disposeAnim2() {
    try {
      animationController2.dispose();
    } catch (e) {}
  }

  @override
  void onClose() {
    _disposeAnim1();
    _disposeAnim2();
    super.onClose();
  }
}
