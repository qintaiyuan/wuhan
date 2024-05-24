import 'package:get/get.dart';
import 'package:wuhan/services/app_info_service.dart';
import 'package:wuhan/services/data_service.dart';
import 'package:wuhan/app/network/services/network_service.dart';
import 'package:wuhan/services/user_service.dart';

class InitialBindings extends Bindings {
  @override
  Future<void> dependencies()  async{
    await Get.putAsync<DataService>(() async => await DataService().init());
    Get.lazyPut(() => UserService());
    Get.lazyPut(() => AppInfoService());
    await Get.putAsync<NetworkService>(() async => NetworkService());
  }
}