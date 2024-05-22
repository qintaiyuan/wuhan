import 'package:flutter/material.dart';
import 'package:wuhan/theme/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.blue, // 主色
        accentColor: Colors.orange, // 强调色
        brightness: Brightness.light, // 亮度
        backgroundColor: AppColors.colorPageBackground// 背景色
    ),
    // useMaterial3: true,
    // pageTransitionsTheme: const PageTransitionsTheme(
    //   builders: {
    //     TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    //     TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    //   },
    // ),
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.blue, // 主色
        accentColor: Colors.orange, // 强调色
        brightness: Brightness.light, // 亮度
        backgroundColor: Colors.black// 背景色
    ),
    // useMaterial3: true,
    // pageTransitionsTheme: const PageTransitionsTheme(
    //   builders: {
    //     TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    //     TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    //   },
    // ),
  );
}
