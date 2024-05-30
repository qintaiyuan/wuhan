import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wuhan/app/controllers/settings_controller.dart';
import '../widgets/common_app_bar.dart';
import '../widgets/setting_item.dart';

class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        title: "我的设置",
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: ListView(
          children: [
            SettingsItem(
              icon: Icons.person,
              title: "账号",
              desc: controller.phoneNumber.value,
              onTap: () {
                // Handle account item tap
              },
            ),
            const SizedBox(height: 14),
            SettingsItem(
              icon: Icons.info,
              title: "关于Superhexa",
              shapeType: ShapeType.topRounded,
              onTap: () {
                controller.navigateTo('/about');
              },
            ),
            SettingsItem(
              icon: Icons.help,
              title: "帮助中心",
              shapeType: ShapeType.none,
              onTap: () {
                controller.navigateTo('/help');
              },
            ),
            SettingsItem(
              icon: Icons.feedback,
              title: "问题反馈",
              shapeType: ShapeType.bottomRounded,
              onTap: () {
                controller.navigateTo('/feedback');
              },
            ),
            const SizedBox(height: 14),
            SettingsItem(
              icon: Icons.exit_to_app,
              title: "退出登录",
              showType: ShowType.warningNoArrow,
              onTap: () {
                controller.logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
