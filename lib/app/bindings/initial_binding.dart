import 'package:get/get.dart';
import 'package:wuhan/services/app_info_service.dart';
import 'package:wuhan/services/data_service.dart';
import 'package:wuhan/app/network/services/network_service.dart';
import 'package:wuhan/services/user_service.dart';

class InitialBindings extends Bindings {
  @override
  Future<void> dependencies()  async{
    await Get.putAsync<DataService>(() async => await DataService().init());
    // 使用 Get.putAsync 确保初始化完成后才继续执行
    await Get.putAsync<UserService>(() async {
      final userService = UserService();
      await userService.onInit();
      return userService;
    });
    Get.lazyPut(() => AppInfoService());
    await Get.putAsync<NetworkService>(() async => NetworkService());
  }
}