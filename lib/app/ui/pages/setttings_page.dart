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
      appBar: CommonAppBar(
        title: 'mySettings'.tr,
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: ListView(
          children: [
            SettingsItem(
              icon: Icons.person,
              title: 'account'.tr,
              desc: controller.phoneNumber.value,
              onTap: () {
                // Handle account item tap
              },
            ),
            const SizedBox(height: 14),
            SettingsItem(
              icon: Icons.info,
              title: 'about'.tr,
              shapeType: ShapeType.topRounded,
              onTap: () {
                controller.navigateTo('/about');
              },
            ),
            SettingsItem(
              icon: Icons.help,
              title: 'help'.tr,
              shapeType: ShapeType.none,
              onTap: () {
                controller.navigateTo('/help');
              },
            ),
            SettingsItem(
              icon: Icons.feedback,
              title: 'feedback'.tr,
              shapeType: ShapeType.bottomRounded,
              onTap: () {
                controller.navigateTo('/feedback');
              },
            ),
            const SizedBox(height: 14),
            SettingsItem(
              icon: Icons.exit_to_app,
              title: 'logout'.tr,
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
