import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:wuhan/app/routes/navigation_service.dart';
import 'package:wuhan/app/ui/dialogs/bind_device_dialog.dart';
import 'package:wuhan/theme/app_colors.dart';

class DeviceEmpty extends StatelessWidget {
  const DeviceEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/iv_device_add_bg.png',
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          right: 16,
          top: 46,
          child: _buildAccountBtn(),
        ),
        Positioned(
            top: 106,
            left: 14,
            right: 14,
            child: _buildAddDeviceView()
        )
      ],
    );
  }

  Widget _buildAccountBtn() {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0), // 设置圆角半径
        color: AppColors.colorWhite30, // 设置背景色
      ),
      child: IconButton(
        icon: const Icon(Icons.person, size: 20),
        onPressed: () {
          NavigationService.toSettingsPage();
        },
        color: AppColors.color800, // 设置图标颜色
      ),
    );
  }

  Widget _buildAddDeviceView() {
    return InkWell(
      onTap: () =>{
        _showPermissionsDialog()
      },
      borderRadius: BorderRadius.circular(10.0), // 控制点击效果圆角
      child: Container(
        width: double.infinity,
        height: 168,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), // 设置圆角半径
          color: AppColors.colorWhite, // 设置背景色
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 上下居中对齐
          children: [
            _buildAddDeviceBtn(),
            const SizedBox(height: 10),
            const Text(
              '添加设备',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.color800),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAddDeviceBtn() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0), // 设置圆角半径
        color: AppColors.colorDefault, // 设置背景色
      ),
      child: IconButton(
        icon: const Icon(Icons.add),
        onPressed: () {
          // onPressed 回调
        },
        color: AppColors.colorWhite, // 设置图标颜色
      ),
    );
  }

  void _showPermissionsDialog() {
    Get.bottomSheet(
        const BindDeviceDialog(),
        backgroundColor: AppColors.colorPageBackground,
        isScrollControlled: true,
        // Ensures the height is adaptive
        useRootNavigator: false,
        enableDrag: false,
        isDismissible: false,
        // enterBottomSheetDuration: const Duration(milliseconds: 10)
    );
  }
}
