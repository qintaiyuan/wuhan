///
/// 类描述:
/// 创建日期: 2024/6/4 on 18:30
/// 作者: qintaiyuan
///
library;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:wuhan/theme/app_colors.dart';
import '../../controllers/loading_controller.dart';

void showLoadingDialog() {
  final LoadingController loadingController = Get.find();

  if (!loadingController.isLoading.value) {
    loadingController.showLoading();
    Get.dialog(
       PopScope(
        canPop: false,
        child: Dialog(
          backgroundColor: AppColors.colorTransparent,
          shadowColor: AppColors.colorTransparent,
          child: Center(
            child: Lottie.asset('assets/anims/toastloading.json',
                width: 32,
                height: 32),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}

void hideLoadingDialog() {
  final LoadingController loadingController = Get.find();

  if (loadingController.isLoading.value) {
    loadingController.hideLoading();
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }
}
