import 'package:get/get.dart';
import 'package:wuhan/bindings/login_binding.dart';
import 'package:wuhan/bindings/splash_binding.dart';
import 'package:wuhan/views/login_page.dart';
import 'package:wuhan/views/splash_page.dart';
import '../bindings/home_binding.dart';
import '../views/home_page.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => const HomePage(),
      binding: HomeBinding(),
      transition: Transition.noTransition, // 设置页面跳转动画
    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => const LoginPage(),
      binding: LoginBinding(),
      transition: Transition.noTransition, // 设置页面跳转动画
    )
  ];
}
