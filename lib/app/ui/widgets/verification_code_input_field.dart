import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wuhan/theme/app_colors.dart';

import '../../controllers/verification_code_input_controller.dart';

class VerificationCodeInputField extends StatelessWidget {
  final Stream<String> stream;
  final RxString verificationCode;

  const VerificationCodeInputField(
      {super.key, required this.stream, required this.verificationCode});

  @override
  Widget build(BuildContext context) {
    final VerificationCodeInputController controller =
        Get.put<VerificationCodeInputController>(
      VerificationCodeInputController(),
      tag: '${UniqueKey().toString()}_verification_code',
      permanent: false,
    );
    verificationCode.bindStream(controller.verificationCode.stream);
    controller.phoneNum.bindStream(stream);
    return SizedBox(
      height: 50,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          _buildBoxDecoration(),
          _buildTextField(controller),
          _buildSendCode(controller),
        ],
      ),
    );
  }

  Widget _buildBoxDecoration() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.colorWhite,
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }

  Widget _buildSendCode(VerificationCodeInputController controller) {
    return Obx(() => TextButton(
          onPressed: (controller.countdown.value == 0 &&
                  controller.phoneNum.value.length >= 11)
              ? controller.sendVerificationCode
              : null,
          child: Text(
            controller.countdown.value == 0
                ? 'sendVerificationCode'.tr
                : '${controller.countdown.value}s',
          ),
        ));
  }

  Widget _buildTextField(VerificationCodeInputController controller) {
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
