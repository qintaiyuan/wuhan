import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wuhan/theme/app_colors.dart';

import '../controllers/verification_code_input_controller.dart';

class VerificationCodeInputField
    extends GetView<VerificationCodeInputController> {
  final Function(String) onVerificationCodeChanged;
  final String phoneNum;

  const VerificationCodeInputField(
      {super.key,
      required this.onVerificationCodeChanged,
      required this.phoneNum});

  @override
  Widget build(BuildContext context) {
    Get.put(VerificationCodeInputController());
    controller.onVerificationCodeChangedCallback = onVerificationCodeChanged;
    return SizedBox(
      height: 50,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          _buildBoxDecoration(),
          _buildTextField(),
          _buildSendCode(),
        ],
      ),
    );
  }

  Widget _buildBoxDecoration() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }

  Widget _buildSendCode() {
    return Obx(() => TextButton(
          onPressed: (controller.countdown.value == 0 && phoneNum.length >= 11)
              ? controller.sendVerificationCode
              : null,
          child: Text(
            controller.countdown.value == 0
                ? 'sendVerificationCode'.tr
                : '${controller.countdown.value}s',
          ),
        ));
  }

  Widget _buildTextField() {
    return TextField(
      keyboardType: TextInputType.number,
      controller: controller.verificationCodeController,
      maxLength: 6,
      style: const TextStyle(
        color: AppColors.color800,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      decoration: _buildInputDecoration(),
      onChanged: controller.onVerificationCodeChanged,
    );
  }

  InputDecoration _buildInputDecoration() {
    return InputDecoration(
      hintText: 'enterVerificationCode'.tr,
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
    );
  }
}
