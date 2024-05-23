import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wuhan/theme/app_colors.dart';
import '../controllers/login_controller.dart';
import '../widgets/agreement_checkboxes.dart';
import '../widgets/phone_input_field.dart';
import '../widgets/verification_code_input_field.dart';
import '../widgets/submit_button.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.colorPageBackground,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              'loginWithPhone'.tr,
              style: const TextStyle(
                fontSize: 24,
                height: 1.0,
                fontWeight: FontWeight.w600,
                color: AppColors.color800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'unregisteredPhoneAutoRegister'.tr,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.color500,
                fontWeight: FontWeight.w400,
                height: 1.0,
              ),
            ),
            const SizedBox(height: 40),
            PhoneInputField(
                onPhoneNumberChanged: (phone) =>
                    {controller.onPhoneNumberChanged(phone)}),
            const SizedBox(height: 12),
            Obx(() => VerificationCodeInputField(
                  phoneNum: controller.phoneNumber.value,
                  onVerificationCodeChanged: (code) => {
                    controller.onVerificationCodeChanged(code)
                  },
                )),
            const SizedBox(height: 50),
            Obx(() => SubmitButton(
                  text: 'login'.tr,
                  enable: controller.isButtonEnabled.value,
                  onPressed: controller.login,
                )),
            const SizedBox(height: 12),
            AgreementCheckboxes(controller: controller),
          ],
        ),
      ),
    );
  }
}
