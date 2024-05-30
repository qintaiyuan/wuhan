import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wuhan/app/controllers/bind_device_controller.dart';
import 'package:wuhan/app/ui/base/base_dialog.dart';
import 'package:wuhan/app/ui/dialogs/bind_device_add_dialog.dart';
import 'package:wuhan/app/ui/dialogs/bind_device_guide_dialog.dart';

import '../../data/models/bind_device_state_model.dart';

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
        switch (controller.currentScreen.value) {
          case DeviceBindState.SETUP_GUIDE:             //引导页面
            return BindDeviceGuideDialog(controller: controller);
          case DeviceBindState.ADD_DEVICE:
            return BindDeviceAddDialog(controller: controller);
          // case DeviceBindState.CONNECT_SUCCESS:
          //   return _buildConnectSuccess(controller);
          // case DeviceBindState.CONNECT_FAILED:
          //   return _buildConnectFailed(controller);
          // case DeviceBindState.CONNECTING:
          //   return _buildConnecting(controller);
          // case DeviceBindState.DEVICE_SEARCH_LIST:
          //   return _buildDeviceSearchList(controller);
          // case DeviceBindState.FOUND_DEVICE:
          //   return _buildFoundDevice(controller);
          // case DeviceBindState.SETUP_GUIDE:
          //   return _buildSetupGuide(controller);
          default:
            return Container();
        }
      }),
      // child: Text("aaaaa"),
    );
  }
}
