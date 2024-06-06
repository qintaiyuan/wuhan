import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:wuhan/app/data/models/device_model.dart';

import '../../../constants/Constants.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_style.dart';
import '../../controllers/bind_device_controller.dart';
import '../../routes/navigation_service.dart';
import '../widgets/submit_button.dart';

class BindDeviceFindMoreDialog extends StatelessWidget {
  final BindDeviceController controller;

  const BindDeviceFindMoreDialog({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 14),
        const Text(
          '添加设备',
          style: AppStyle.dialogTitleStyle,
        ),
        // SizedBox(height: 20),
        Expanded(
          child: Obx(() => ListView.builder(
                itemCount: controller.devicesList.length,
                itemBuilder: (context, index) {
                  final item = controller.devicesList[index];
                  return _buildListItem(item);
                },
              )),
        ),
        const Spacer(),
        Text.rich(
          textAlign: TextAlign.center,
          TextSpan(children: [
            const TextSpan(
              text: '没有查找到我的设备？',
              style: TextStyle(
                  fontSize: 12,
                  color: AppColors.color500,
                  fontWeight: FontWeight.w400),
            ),
            WidgetSpan(
              child: GestureDetector(
                onTap: () => NavigationService.launchURL(aPPExperience),
                child: const Text(
                  '查看原因',
                  style: TextStyle(
                      fontSize: 12,
                      color: AppColors.colorDefault,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ]),
        ),
        const SizedBox(height: 8),
        SubmitButton(
            text: '取消',
            textColor: AppColors.color800,
            enabledColor: AppColors.color100,
            onPressed: controller.dimissDialog)
      ],
    );
  }

  Widget _buildListItem(DeviceInfo deviceInfo) {
    return Container(
      height: 60,
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/icon_anchor_glass.webp',
            width: 60,
            height: 60,
          ),
          const SizedBox(width: 8),
          Expanded(
              child: Text(
            deviceInfo.nickname,
            style: const TextStyle(
                fontSize: 15,
                color: AppColors.color800,
                fontWeight: FontWeight.w500),
          )),
          _buildConntectBtn(deviceInfo)
        ],
      ),
    );
  }

  Widget _buildConntectBtn(DeviceInfo deviceInfo) {
    return SizedBox(
      width: 62,
      height: 32,
      child: ElevatedButton(
        onPressed: () => {controller.connectDevice(deviceInfo)},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.colorDefault10,
          padding: const EdgeInsets.all(0),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0), // 设置圆角
          ),
        ),
        child: const Text(
          '连接',
          textAlign: TextAlign.center,
          style: TextStyle(
              height: 1.0,
              color: AppColors.colorDefault,
              fontSize: 13,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
