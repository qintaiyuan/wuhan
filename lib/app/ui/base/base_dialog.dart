import 'package:flutter/cupertino.dart';
import 'package:wuhan/theme/app_colors.dart';

abstract class BaseDialog extends StatelessWidget {
  final bool canPop;

  const BaseDialog({super.key, this.canPop = true});

  Widget buildChild(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Wrap(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 32.0),
              alignment: Alignment.topCenter,
              decoration: const BoxDecoration(
                color: AppColors.colorWhite,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
              ),
              child: buildChild(context),
            ),
          ],
        ),
      ),
    );
  }
}
