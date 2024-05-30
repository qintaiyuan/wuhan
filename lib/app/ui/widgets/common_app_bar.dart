import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wuhan/theme/app_colors.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showLeading;
  final String? title;
  final Widget? leading;
  final List<Widget>? actions;

  const CommonAppBar({
    super.key,
    this.showLeading = true,
    this.title,
    this.leading,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.colorPageBackground,
      leading: showLeading
          ? (leading ??
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Get.back();
                },
              ))
          : null,
      title: title != null
          ? Text(
              title!,
              style: const TextStyle(
                  color: AppColors.color800,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            )
          : null,
      // If title is null, provide an empty container to keep title centered
      centerTitle: true,
      // Ensure the title is centered
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
