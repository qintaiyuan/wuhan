import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wuhan/app/controllers/bind_device_controller.dart';
import 'package:wuhan/app/ui/base/base_dialog.dart';
import 'package:wuhan/app/ui/dialogs/bind_device_add_dialog.dart';
import 'package:wuhan/app/ui/dialogs/bind_device_connecting_dialog.dart';
import 'package:wuhan/app/ui/dialogs/bind_device_failed_dialog.dart';
import 'package:wuhan/app/ui/dialogs/bind_device_find_more_dialog.dart';
import 'package:wuhan/app/ui/dialogs/bind_device_find_one_dialog.dart';
import 'package:wuhan/app/ui/dialogs/bind_device_guide_dialog.dart';

import '../../data/models/bind_device_state_model.dart';
import 'bind_device_success_dialog.dart';

class BindDeviceDialog extends BaseDialog {
  const BindDeviceDialog({super.key, super.canPop = false});

  @override
  Widget buildChild(BuildContext context) {
    final BindDeviceController controller = Get.put<BindDeviceController>(
      BindDeviceController(),
      tag: '${UniqueKey().toString()}_bind_device',
      permanent: false,
    );
    return SizedBox(
      height: 400,
      width: double.infinity,
      child: Obx(() {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: _getChildWidget(controller.currentScreen.value, controller),
        );
      }),
    );
  }

  Widget _getChildWidget(
      DeviceBindState state, BindDeviceController controller) {
    switch (state) {
      case DeviceBindState.SETUP_GUIDE:
        return BindDeviceGuideDialog(
            controller: controller, key: ValueKey(state));
      case DeviceBindState.ADD_DEVICE:
        return BindDeviceAddDialog(
            controller: controller, key: ValueKey(state));
      case DeviceBindState.DEVICE_FIND_ONE:
        return BindDeviceFindOneDialog(
            controller: controller, key: ValueKey(state));
      case DeviceBindState.DEVICE_FIND_MORE:
        return BindDeviceFindMoreDialog(
            controller: controller, key: ValueKey(state));
      case DeviceBindState.CONNECTING:
        return BindDeviceConnectingDialog(
            controller: controller, key: ValueKey(state));
      case DeviceBindState.CONNECT_SUCCESS:
        return BindDeviceSuccessDialog(
            controller: controller, key: ValueKey(state));
      case DeviceBindState.CONNECT_FAILED:
        return BindDeviceFailedDialog(
            controller: controller, key: ValueKey(state));
      default:
        return Container(key: ValueKey(state));
    }
  }
}
