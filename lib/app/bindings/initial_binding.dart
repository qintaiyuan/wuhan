import 'package:get/get.dart';
import 'package:wuhan/services/data_service.dart';
import 'package:wuhan/services/network_service.dart';
import 'package:wuhan/services/user_service.dart';

class InitialBindings extends Bindings {
  @override
  Future<void> dependencies()  async{
    await Get.putAsync<DataService>(() async => await DataService().init());
    await Get.putAsync<NetworkService>(() async => NetworkService());
    Get.lazyPut(() => UserService());
  }
}