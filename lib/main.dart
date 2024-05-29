import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wuhan/services/app_initializer_service.dart';
import 'package:wuhan/theme/app_theme.dart';
import 'package:wuhan/transliate/app_translations.dart';

import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';

void main() async {
  // 确保 Flutter 框架正确初始化的实用方法，
  // 通常在需要执行依赖于 Flutter 的异步操作或插件初始化之前调用。
  // 它是确保应用程序在启动时能正确配置和初始化各种资源和服务的重要步骤。
  WidgetsFlutterBinding.ensureInitialized();
  // 初始化
  await Get.putAsync<AppInitializer>(
      () async => await AppInitializer().initialize());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 设置状态栏文字颜色为白色
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent, // 状态栏背景颜色
      statusBarIconBrightness: Brightness.dark, // 状态栏文字颜色为黑色
    ));
    return GetMaterialApp(
      title: 'Anchor',
      themeMode: ThemeMode.system,
      // 自动跟随系统主题切换
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
      translations: AppTranslations(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      defaultTransition: Transition.rightToLeftWithFade, // 设置默认的页面跳转动画
      // initialBinding: InitialBindings(), // 不能兼容异步注入
      initialRoute: AppRoutes.SPLASH,
      getPages: AppPages.pages,
      // 使用绑定类
      // home: const SplashPage(),
    );
  }
}
