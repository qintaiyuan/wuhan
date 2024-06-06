import 'package:get/get.dart';

///
/// 类描述: 控制loading显示隐藏
/// 创建日期: 2024/6/4 on 18:29
/// 作者: qintaiyuan
///
class LoadingController extends GetxController {
  var isLoading = false.obs;

  void showLoading() {
    isLoading.value = true;
  }

  void hideLoading() {
    isLoading.value = false;
  }
}
