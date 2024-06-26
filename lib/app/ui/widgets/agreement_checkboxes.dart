import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wuhan/app/controllers/agreement_checkboxes_controller.dart';
import 'package:wuhan/theme/app_colors.dart';

import '../../../constants/constants.dart';
import '../../routes/navigation_service.dart';
import '../../controllers/login_controller.dart';

class AgreementCheckboxes extends StatelessWidget {
  final RxBool agreeToTerms;
  const AgreementCheckboxes({super.key, required this.agreeToTerms});

  @override
  Widget build(BuildContext context) {
    final AgreementCheckboxesController controller =
    Get.put<AgreementCheckboxesController>(
      AgreementCheckboxesController(),
      tag: '${UniqueKey().toString()}_agreement_checkbox',
      permanent: false,
    );
    agreeToTerms.bindStream(controller.agreeToTerms.stream);
    return Column(
      children: [
        Obx(() => Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 24,
                  width: 24,
                  child: Transform.scale(
                    scale: 0.7,
                    child: Checkbox(
                      value: controller.agreeToTerms.value,
                      onChanged: (value) {
                        controller.agreeToTerms.value = value!;
                      },
                      activeColor: AppColors.colorDefault,
                      checkColor: Colors.white,
                      side: MaterialStateBorderSide.resolveWith(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.selected)) {
                            return null;
                          } else {
                            return const BorderSide(
                              color: AppColors.color500,
                              width: 1.5,
                            );
                          }
                        },
                      ),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ),
                Expanded(
                  child: Text.rich(
                    textAlign: TextAlign.start,
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'termsAgreementPrefix'.tr,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.color500,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () =>
                                NavigationService.launchURL(aPPUserAgreement),
                            child: Text(
                              'termsAgreementUser'.tr,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.colorDefault,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        TextSpan(
                          text: 'termsAgreementAnd'.tr,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.color500,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () =>
                                NavigationService.launchURL(aPPExperience),
                            child: Text(
                              'termsAgreementPrivacy'.tr,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.colorDefault,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
