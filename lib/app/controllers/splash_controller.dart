import 'package:get/get.dart';
import 'package:wuhan/app/routes/navigation_service.dart';
import 'package:wuhan/theme/app_colors.dart';

import '../../constants/constants.dart';
import '../../services/data_service.dart';
import '../../services/user_service.dart';
import '../ui/dialogs/agreement_dialog.dart';

class SplashController extends GetxController {
  final DataService _dataService = Get.find<DataService>();
  final UserService _userService = Get.find();
  void checkCurState() {
    bool hasAgree = _dataService.getBool(userPrivicyAgreement);
    if(!hasAgree) {
      _showPermissionsDialog();
    } else if(_userService.getUser() == null) {
      NavigationService.offAndLoginPage();
    } else {
      NavigationService.offAndToHomePage();
    }
  }
  void _showPermissionsDialog() {
    Get.bottomSheet(
      const AgreementBottomSheet(),
      backgroundColor: AppColors.colorPageBackground,
      isScrollControlled: true,
      // Ensures the height is adaptive
      useRootNavigator: false,
      enableDrag: false,
      isDismissible: false,
      enterBottomSheetDuration: const Duration(milliseconds: 10)
    );
  }
}
