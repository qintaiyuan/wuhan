import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wuhan/theme/app_colors.dart';

import '../../controllers/password_input_controller.dart';

class PasswordInputField extends StatelessWidget {
  final RxString passwordNumber;

  const PasswordInputField({super.key, required this.passwordNumber});

  @override
  Widget build(BuildContext context) {
    final PasswordInputController controller = Get.put<PasswordInputController>(
      PasswordInputController(),
      tag: '${UniqueKey().toString()}_password_input',
      permanent: false,
    );
    passwordNumber.bindStream(controller.passwordNumber.stream);
    return SizedBox(
      height: 50,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          _buildBoxDecoration(),
          _buildTextField(controller),
          // _buildSendCode(controller),
        ],
      ),
    );
  }

  Widget _buildTextField(PasswordInputController controller) {
    return Obx(() => TextField(
      obscureText: !controller.isPasswordVisible.value,
      keyboardType: TextInputType.number,
      autofocus: controller.isFocused.value,
      controller: controller.passwordController,
      focusNode: controller.focusNode,
      // 控制是否隐藏文本
      maxLength: 24,
      style: const TextStyle(
        color: AppColors.color800,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      decoration: _buildInputDecoration(controller),
      onChanged: controller.onPasswordChanged,
    ));
  }

  Widget _buildBoxDecoration() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.colorWhite,
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
  Widget _buildSuffixIcons(PasswordInputController controller) {
    return Obx(() => Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (controller.isFocused.value) ...[
          IconButton(
            icon: const Icon(
              Icons.clear_rounded,
              size: 20,
            ),
            color: AppColors.color500,
            onPressed: controller.clearPasswordNumber,
          ),
          IconButton(
            icon: Icon(
              controller.isPasswordVisible.value
                  ? Icons.visibility
                  : Icons.visibility_off,
              size: 20,
            ),
            color: AppColors.color500,
            onPressed: controller.togglePasswordVisibility,
          ),
        ],
      ],
    ));
  }

  InputDecoration _buildInputDecoration(PasswordInputController controller) {
    return InputDecoration(
      hintText: 'enterPasswordNumber'.tr,
      hintStyle: const TextStyle(
        color: AppColors.color300,
        fontSize: 15,
      ),
      counterText: '',
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.white),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.color800),
      ),
      suffixIcon: _buildSuffixIcons(controller),
    );
  }
}
