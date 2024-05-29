import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wuhan/app/routes/navigation_service.dart';
import 'package:wuhan/theme/app_colors.dart';

import '../../controllers/login_controller.dart';
import '../widgets/agreement_checkboxes.dart';
import '../widgets/phone_input_field.dart';
import '../widgets/submit_button.dart';
import '../widgets/verification_code_input_field.dart';

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
            _buildTitle(),
            const SizedBox(height: 8),
            _buildTitleTip(),
            const SizedBox(height: 40),
            PhoneInputField(phoneNumber: controller.phoneNumber),
            const SizedBox(height: 12),
            VerificationCodeInputField(
              stream: controller.phoneNumber.stream,
              verificationCode: controller.verificationCode,
            ),
            _buildPasswordBtn(),
            const SizedBox(height: 15),
            Obx(() => SubmitButton(
                  text: 'login'.tr,
                  enable: controller.isButtonEnabled.value,
                  onPressed: controller.login,
                )),
            const SizedBox(height: 12),
            AgreementCheckboxes(agreeToTerms: controller.agreeToTerms),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'loginWithPhone'.tr,
      style: const TextStyle(
        fontSize: 24,
        height: 1.0,
        fontWeight: FontWeight.w600,
        color: AppColors.color800,
      ),
    );
  }

  Widget _buildTitleTip() {
    return Text(
      'unregisteredPhoneAutoRegister'.tr,
      style: const TextStyle(
        fontSize: 14,
        color: AppColors.color500,
        fontWeight: FontWeight.w400,
        height: 1.0,
      ),
    );
  }

  Widget _buildPasswordBtn() {
    return GestureDetector(
      onTap: () {
        NavigationService.toAccountLoginPage();
      },
      child: Container(
        alignment: Alignment.topRight,
        margin: const EdgeInsets.only(top: 15),
        child: Text(
          'accountLogin'.tr,
          style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 13,
              color: AppColors.color500),
        ),
      ),
    );
  }
}
