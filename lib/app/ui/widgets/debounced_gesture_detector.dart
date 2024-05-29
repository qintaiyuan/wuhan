import 'package:flutter/cupertino.dart';

class DebouncedGestureDetector extends StatelessWidget {
  final GestureTapCallback onTap;
  // final Duration delayDuration;
  final Widget child;

  const DebouncedGestureDetector({
    super.key,
    required this.onTap,
    // required this.delayDuration,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // 创建 Worker 实例
    return GestureDetector(
      onTap: onTap,
      child: child,
    );
  }
}