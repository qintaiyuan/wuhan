import 'package:flutter/material.dart';
import 'package:wuhan/theme/app_colors.dart';

class DeviceEmpty extends StatelessWidget {
  const DeviceEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Image.asset('assets/images/iv_device_add_bg.png'),
        Positioned(
          right: 16,
          top: 46,
          child: _buildAccountBtn(),
        ),
        Positioned(top: 106, child: _buildAddDeviceView())
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
        icon: const Icon(Icons.account_circle, size: 20),
        onPressed: () {
          // onPressed 回调
        },
        color: AppColors.color800, // 设置图标颜色
      ),
    );
  }

  Widget _buildAddDeviceView() {
    return Container(
      width: double.infinity,
      height: 168,
      margin: const EdgeInsets.symmetric(horizontal: 14),
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
}
