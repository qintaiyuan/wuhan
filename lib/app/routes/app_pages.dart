import 'package:get/get.dart';
import 'package:wuhan/app/bindings/account_login_binding.dart';
import '../bindings/home_binding.dart';
import '../bindings/login_binding.dart';
import '../bindings/splash_binding.dart';
import '../ui/pages/account_login_page.dart';
import '../ui/pages/home_page.dart';
import '../ui/pages/login_page.dart';
import '../ui/pages/splash_page.dart';
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
    ),
    GetPage(
      name: AppRoutes.ACCOUNT_LOGIN,
      page: () => const AccountLogin(),
      binding: AccountLoginBinding(),
    )
  ];
}
