import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:wuhan/constants/Constants.dart';

import '../../../services/data_service.dart';
import '../../../services/user_service.dart';

class AddCookiesInterceptor extends Interceptor {
  final DataService _dataService = Get.find<DataService>();
  final UserService _userService = Get.find();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // var builder = options.headers;
    final List<String> list = [];
    // Check if user is signed in and add cookies to the request headers
    if (_userService.isSignedIn()) {
      var cookies = _dataService.get(setCookieCache);
      if (cookies != null) {
        list.addAll(cookies);
      }
    }
    list.add("locale=zh_CN");
    var finalCookies = list.join('; ');
    options.headers['Cookie'] = finalCookies;
    print('Added Cookies: $finalCookies');
    super.onRequest(options, handler);
  }
}
