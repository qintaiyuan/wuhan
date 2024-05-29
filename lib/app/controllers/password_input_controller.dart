import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PasswordInputController extends GetxController {
  var passwordNumber = ''.obs;
  var focusNode = FocusNode();
  var isFocused = false.obs;
  var isPasswordVisible = false.obs; // 添加是否显示密码的变量
  TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    passwordController.addListener(() {
      onPasswordChanged(passwordController.text);
    });
    focusNode.addListener(() {
      isFocused.value = focusNode.hasFocus;
    });
  }

  void clearPasswordNumber() {
    passwordController.clear();
  }

  void onPasswordChanged(String value) {
    String formatted = value.length > 24 ? value.substring(0, 24) : value;
    if (value != formatted) {
      passwordController.text = value.substring(0, 24);
      passwordController.selection = TextSelection.fromPosition(
        TextPosition(offset: formatted.length),
      );
    }
    passwordNumber.value = formatted;
  }

  void togglePasswordVisibility() {
    bool wasFocused = focusNode.hasFocus;
    isPasswordVisible.value = !isPasswordVisible.value;
    if (wasFocused) {
      focusNode.requestFocus();
    }
  }
}
