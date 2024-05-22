import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wuhan/theme/app_colors.dart';
import '../controllers/login_controller.dart';

class VerificationCodeInputField extends StatelessWidget {
  final LoginController controller;

  const VerificationCodeInputField({required this.controller, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          TextField(
            keyboardType: TextInputType.number,
            controller: controller.verificationCodeController,
            maxLength: 6,
            style: const TextStyle(
              color: AppColors.color800,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
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
            ),
            onChanged: controller.onVerificationCodeChanged,
          ),
          Obx(() => TextButton(
            onPressed: controller.countdown.value == 0
                ? controller.sendVerificationCode
                : null,
            child: Text(
              controller.countdown.value == 0
                  ? 'sendVerificationCode'.tr
                  : '${controller.countdown.value}s',
            ),
          )),
        ],
      ),
    );
  }
}
