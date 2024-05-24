import 'package:device_info/device_info.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';

class AppInfoService extends GetxService{
  var appVersion = 'Unknown'.obs;
  var deviceId = 'Unknown'.obs;

  @override
  void onInit() {
    super.onInit();
    _initAppVersion();
    _initDeviceId();
  }

  Future<void> _initAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion.value = packageInfo.version;
  }

  Future<void> _initDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (GetPlatform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId.value = androidInfo.androidId;
    } else if (GetPlatform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceId.value = iosInfo.identifierForVendor;
    }
  }
}
