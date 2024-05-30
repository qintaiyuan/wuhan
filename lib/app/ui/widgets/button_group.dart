import 'package:flutter/material.dart';
import 'package:wuhan/app/ui/widgets/submit_button.dart';
import 'package:wuhan/theme/app_colors.dart';

class ButtonGroup extends StatelessWidget {
  final String cancelButtonText;
  final String confirmButtonText;
  final Function() onCancelPressed;
  final Function() onConfirmPressed;

  const ButtonGroup({
    super.key,
    required this.cancelButtonText,
    required this.confirmButtonText,
    required this.onCancelPressed,
    required this.onConfirmPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
            child: SubmitButton(
                text: cancelButtonText,
                textColor: AppColors.color800,
                enabledColor: AppColors.color100,
                onPressed: onCancelPressed)),
        const SizedBox(width: 12),
        Expanded(
            child: SubmitButton(
                text: confirmButtonText, onPressed: onConfirmPressed)),
      ],
    );
  }
}
