import 'package:dio/dio.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import '../../../constants/constants.dart';
import '../../../services/data_service.dart';

class ReceivedCookiesInterceptor extends Interceptor {
  final DataService _dataService = Get.find<DataService>();
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    List<String>? setCookieHeaders = response.headers["Set-Cookie"];
    if (setCookieHeaders != null && setCookieHeaders.isNotEmpty) {
      _dataService.put(setCookieCache, setCookieHeaders);
      // Process cookies
      print('Received Cookies: $setCookieHeaders');
    }
    super.onResponse(response, handler);
  }
}
