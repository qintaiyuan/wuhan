import 'package:flutter/material.dart';
import 'package:wuhan/theme/app_colors.dart';

enum ShapeType {
  rounded,
  topRounded,
  bottomRounded,
  none,
}

enum ShowType {
  warningNoArrow,
  warningWithArrow,
  normalNoArrow,
  normalWithArrow
}

class SettingsItem extends StatelessWidget {
  final IconData? icon;
  final String title;
  final String? desc;
  final bool showDot;
  final VoidCallback onTap;
  final ShapeType shapeType;
  final ShowType showType;

  const SettingsItem(
      {super.key,
      this.icon,
      required this.title,
      required this.onTap,
      this.showDot = false,
      this.shapeType = ShapeType.rounded,
      this.showType = ShowType.normalWithArrow,
      this.desc});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: _getBorderRadius(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: _getBorderRadius(),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
        child: Row(
          children: [
            icon != null
                ? Icon(icon, color: _getShowColor(), size: 18)
                : const SizedBox(width: 0),
            icon != null
                ? const SizedBox(width: 10)
                : const SizedBox(width: 0), // 去除间距
            Stack(
              children: [
                Text(title,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: _getShowColor(),
                        height: 1.0)),
                showDot
                    ? const Positioned(
                        right: 0,
                        top: 0,
                        child: Icon(Icons.circle,
                            size: 5, color: AppColors.colorWarning))
                    : const SizedBox(
                        width: 0,
                      ),
              ],
            ),
            Expanded(
              child: desc != null
                  ? Text(
                      desc!,
                      style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.color500,
                          fontWeight: FontWeight.w500,
                          height: 1.0),
                      textAlign: TextAlign.end,
                    )
                  : const SizedBox(width: 0),
            ),
            const SizedBox(width: 8),
            _buildTrailing(),
          ],
        ),
      ),
    );
  }

  Color _getShowColor() {
    switch (showType) {
      case ShowType.normalNoArrow:
      case ShowType.normalWithArrow:
        return AppColors.color800;
      default:
        return AppColors.colorWarning;
    }
  }

  Widget _buildTrailing() {
    switch (showType) {
      case ShowType.normalWithArrow:
        return const Icon(Icons.chevron_right,
            color: AppColors.color500, size: 14);
      case ShowType.warningWithArrow:
        return const Icon(Icons.chevron_right,
            color: AppColors.colorWarning, size: 14);
      default:
        return const SizedBox(width: 0.0);
    }
  }

  BorderRadius _getBorderRadius() {
    switch (shapeType) {
      case ShapeType.rounded:
        return BorderRadius.circular(8);
      case ShapeType.topRounded:
        return const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        );
      case ShapeType.bottomRounded:
        return const BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        );
      case ShapeType.none:
      default:
        return BorderRadius.zero;
    }
  }

// _getShowColor() {}
}
