import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wuhan/app/routes/navigation_service.dart';
import 'package:wuhan/theme/app_colors.dart';
import '../../constants/constants.dart';
import '../controllers/agreement_controller.dart';
import '../ui/widgets/submit_button.dart';

class AgreementBottomSheet extends GetView<AgreementController> {
  const AgreementBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<AgreementController>();
    return PopScope(
      canPop: false,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Wrap(
          children: [
            Container(
              padding: const EdgeInsets.all(24.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitleAndDescription(),
                  const SizedBox(height: 28),
                  _buildPermissionListTile(
                    icon: Icons.notifications,
                    title: 'notificationPermissionTitle'.tr,
                    description: 'notificationPermissionDescription'.tr,
                  ),
                  const SizedBox(height: 24),
                  _buildPermissionListTile(
                    icon: Icons.bluetooth,
                    title: 'bluetoothPermissionTitle'.tr,
                    description: 'bluetoothPermissionDescription'.tr,
                  ),
                  const SizedBox(height: 40),
                  _buildAgreementCheckboxes(),
                  const SizedBox(height: 20),
                  _buildActionButtons(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleAndDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'title'.tr,
          style: const TextStyle(
              fontSize: 18,
              height: 1.0,
              fontWeight: FontWeight.w600,
              color: AppColors.color800),
        ),
        const SizedBox(height: 8),
        Text(
          'description'.tr,
          style: const TextStyle(
              fontSize: 13,
              height: 1.615,
              fontWeight: FontWeight.w400,
              color: AppColors.color500),
        ),
      ],
    );
  }

  Widget _buildCustomListTile({
    required Widget leading,
    required Widget title,
    required Widget subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 15.0),
          child: leading,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title,
              // SizedBox(height: 4.0),
              subtitle,
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPermissionListTile(
      {required IconData icon,
      required String title,
      required String description}) {
    return _buildCustomListTile(
      leading: Icon(icon, size: 15, color: AppColors.color800),
      title: Text(
        title,
        style: const TextStyle(
            fontSize: 15,
            height: 1.0,
            fontWeight: FontWeight.w500,
            color: AppColors.color800),
      ),
      subtitle: Text(
        description,
        style: const TextStyle(
            fontSize: 13,
            height: 1.6,
            fontWeight: FontWeight.w400,
            color: AppColors.color500),
      ),
    );
  }

  Widget _buildAgreementCheckboxes() {
    return Column(
      children: [
        Obx(() => Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 24, // 设置checkbox的高度
                  width: 24, // 设置checkbox的宽度
                  child: Transform.scale(
                    scale: 0.7, // 调整checkbox大小
                    child: Checkbox(
                      value: controller.agreeToTerms.value,
                      onChanged: (value) {
                        controller.agreeToTerms.value = value!;
                      },
                      activeColor: AppColors.colorDefault,
                      // 选中时的背景颜色
                      checkColor: Colors.white,
                      // 选中时勾选的颜色
                      side: MaterialStateBorderSide.resolveWith(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.selected)) {
                          return null;
                        } else {
                          return const BorderSide(
                            color: AppColors.color500,
                            width: 1.5, // 边框宽度
                          );
                        }
                      }),
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
                              fontWeight: FontWeight.w400),
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
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        TextSpan(
                          text: 'termsAgreementAnd'.tr,
                          style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.color500,
                              fontWeight: FontWeight.w400),
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
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
        Obx(() => Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 24, // 设置checkbox的高度
                  width: 24, // 设置checkbox的宽度
                  child: Transform.scale(
                    scale: 0.7, // 调整checkbox大小
                    child: Checkbox(
                      value: controller.joinUserExperience.value,
                      onChanged: (value) {
                        controller.joinUserExperience.value = value!;
                      },
                      activeColor: AppColors.colorDefault,
                      // 选中时的背景颜色
                      checkColor: Colors.white,
                      // 选中时勾选的颜色
                      side: MaterialStateBorderSide.resolveWith(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.selected)) {
                          return null;
                        } else {
                          return const BorderSide(
                            color: AppColors.color500,
                            width: 1.5, // 边框宽度
                          );
                        }
                      }),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ),
                Expanded(
                  child: Text.rich(
                    textAlign: TextAlign.start,
                    TextSpan(children: [
                      TextSpan(
                        text: 'userExperiencePlanJoin'.tr,
                        style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.color500,
                            fontWeight: FontWeight.w400),
                      ),
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: () =>
                              NavigationService.launchURL(aPPExperience),
                          child: Text(
                            'userExperiencePlan'.tr,
                            style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.colorDefault,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            )),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        Obx(() => SubmitButton(
            text: 'agreeAndContinue'.tr,
            enable: controller.agreeToTerms.value,
            onPressed: () => {controller.checkState()})),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () => {SystemNavigator.pop()},
          child: Text(
            'thinkAgain'.tr,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.color600),
          ),
        ),
      ],
    );
  }
}
