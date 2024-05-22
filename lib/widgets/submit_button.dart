import 'package:flutter/material.dart';
import 'package:wuhan/theme/app_colors.dart';

class SubmitButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool enable;
  final Color enabledColor; // 按钮启用时的背景颜色
  final Color disabledColor; // 按钮禁用时的背景颜色
  final double borderRadius;

  const SubmitButton({
    super.key,
    required this.text,
    this.enable = true, // 默认为启用状态
    this.enabledColor = AppColors.colorDefault, // 默认启用时的颜色
    this.disabledColor = AppColors.colorBtnUnable, // 默认禁用时的颜色
    this.borderRadius = 8.0, // Default border radius
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: enable ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: enabledColor,
          disabledBackgroundColor: disabledColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius), // 设置圆角
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
    );
  }
}
