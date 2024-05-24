import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PhoneInputController extends GetxController {
  Function(String)? onPhoneNumberChangedCallback;
  TextEditingController phoneController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    phoneController.addListener(() {
      onPhoneNumberChanged(phoneController.text);
    });
  }

  void clearPhoneNumber() {
    phoneController.clear();
  }

  String _formatPhoneNumber(String input) {
    // 只保留数字，并限制最大有效位数为11
    String digits = input.replaceAll(RegExp(r'\D'), '');
    if (digits.length > 11) {
      digits = digits.substring(0, 11);
    }
    // 格式化手机号
    StringBuffer formattedNumber = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      if (i == 3 || i == 7) {
        formattedNumber.write(' ');
      }
      formattedNumber.write(digits[i]);
    }
    return formattedNumber.toString();
  }

  void onPhoneNumberChanged(String value) {
    // 获取当前光标位置
    int cursorPosition = phoneController.selection.baseOffset;
    // 格式化手机号之前的光标位置
    String beforeText = phoneController.text.substring(0, cursorPosition);
    int digitsBeforeCursor = beforeText.replaceAll(RegExp(r'\D'), '').length;
    // 格式化手机号
    String formatted = _formatPhoneNumber(value);
    // 获取格式化之后光标应该的位置
    int newCursorPosition = 0;
    int digitsCount = 0;
    for (int i = 0; i < formatted.length; i++) {
      if (RegExp(r'\d').hasMatch(formatted[i])) {
        digitsCount++;
      }
      if (digitsCount == digitsBeforeCursor) {
        newCursorPosition = i + 1;
        break;
      }
    }
    if (newCursorPosition > formatted.length || digitsBeforeCursor > 11) {
      newCursorPosition = formatted.length;
    }

    if (value != formatted) {
      phoneController.value = phoneController.value.copyWith(
        text: formatted,
        selection: TextSelection.collapsed(offset: newCursorPosition),
      );
    }

    if (onPhoneNumberChangedCallback != null) {
      onPhoneNumberChangedCallback!(formatted.replaceAll(' ', ''));
    }
  }

  @override
  void onClose() {
    phoneController.dispose();
    onPhoneNumberChangedCallback = null;
    super.onClose();
  }
}
