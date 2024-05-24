import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app/routes/app_routes.dart';

class NavigationService {
  static void offAndToHomePage() {
    Get.offAndToNamed(AppRoutes.HOME);
  }

  static void offAndLoginPage() {
    Get.offAndToNamed(AppRoutes.LOGIN);
  }

  // 其他页面跳转方法...
  static void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
