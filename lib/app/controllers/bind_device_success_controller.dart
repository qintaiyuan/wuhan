import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BindDeviceSuccessController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController1;
  late Animation<int> animation1;
  var currentFrame = 0.obs;
  final List<String> frameImages3 = [
    'assets/frame/device/fc_3000.webp',
    'assets/frame/device/fc_3001.webp',
    // 'assets/frame/device/fc_3002.webp',
    'assets/frame/device/fc_3003.webp',
    'assets/frame/device/fc_3004.webp',
    // 'assets/frame/device/fc_3005.webp',
    'assets/frame/device/fc_3006.webp',
    'assets/frame/device/fc_3007.webp',
    // 'assets/frame/device/fc_3008.webp',
    'assets/frame/device/fc_3009.webp',
    'assets/frame/device/fc_3010.webp',
    // 'assets/frame/device/fc_3011.webp',
    'assets/frame/device/fc_3012.webp',
    'assets/frame/device/fc_3013.webp',
    // 'assets/frame/device/fc_3014.webp',
    'assets/frame/device/fc_3015.webp',
    'assets/frame/device/fc_3016.webp',
    // 'assets/frame/device/fc_3017.webp',
    'assets/frame/device/fc_3018.webp',
    'assets/frame/device/fc_3019.webp',
    // 'assets/frame/device/fc_3020.webp',
    'assets/frame/device/fc_3021.webp',
    'assets/frame/device/fc_3022.webp',
    // 'assets/frame/device/fc_3023.webp',
    'assets/frame/device/fc_3024.webp',
    'assets/frame/device/fc_3024.webp',
    // 'assets/frame/device/fc_3026.webp',
    'assets/frame/device/fc_3027.webp',
    'assets/frame/device/fc_3028.webp',
    // 'assets/frame/device/fc_3029.webp',
    'assets/frame/device/fc_3030.webp',
  ];

  @override
  void onInit() {
    super.onInit();
    animationController1 = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    animation1 = IntTween(begin: 0, end: frameImages3.length - 1)
        .animate(animationController1)
      ..addListener(() {
        currentFrame.value = animation1.value;
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // animationController1.reset();
        }
      });
    _preloadImages();
  }

  Future<void> _preloadImages() async {
    for (String imagePath in frameImages3) {
      await precacheImage(AssetImage(imagePath), Get.context!);
    }
    animationController1.forward();
  }

  @override
  void onClose() {
    animationController1.dispose();
    super.onClose();
  }
}
