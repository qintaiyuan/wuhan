import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:wuhan/constants/constants.dart';

import '../../../services/data_service.dart';
import '../../../services/user_service.dart';

class AddCookiesInterceptor extends Interceptor {
  final DataService _dataService = Get.find<DataService>();
  final UserService _userService = Get.find();
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    var builder = options.headers;

    // Check if user is signed in and add cookies to the request headers
    if (_userService.isSignedIn()) {
      var cookies = _dataService.get(setCookieCache);
      if (cookies != null) {
        for (var cookie in cookies) {
          builder["Cookie"] = cookie;
        }
      }
    }
    // Add locale to the request headers
    builder["Cookie"] = "locale=zh_CN";
    super.onRequest(options, handler);
  }
}
