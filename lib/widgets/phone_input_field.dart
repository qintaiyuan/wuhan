import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wuhan/theme/app_colors.dart';
import '../controllers/login_controller.dart';

class PhoneInputField extends StatelessWidget {
  final LoginController controller;

  const PhoneInputField({required this.controller, Key? key}) : super(key: key);

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
          const Positioned(
            left: 14,
            child: Text(
              '+86 | ',
              style: TextStyle(
                color: AppColors.color800,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextField(
            keyboardType: TextInputType.number,
            controller: controller.phoneController,
            style: const TextStyle(
              color: AppColors.color800,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: 'enterPhoneNumber'.tr,
              hintStyle: const TextStyle(
                color: AppColors.color300,
                fontSize: 15,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 60),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.color800),
              ),
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.clear_rounded,
                  size: 20,
                ),
                color: AppColors.color500,
                onPressed: controller.clearPhoneNumber,
              ),
            ),
            onChanged: controller.onPhoneNumberChanged,
          ),
        ],
      ),
    );
  }
}
