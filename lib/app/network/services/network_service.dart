import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:wuhan/app/data/models/unlogin_event_model.dart';

import '../../../constants/constants.dart';
import '../../../services/connectivity_service.dart';
import '../../../services/event_bus_service.dart';
import '../../data/models/response_model.dart';
import '../interceptor/add_cookies_interceptor.dart';
import '../interceptor/header_interceptor.dart';
import '../interceptor/received_cookies_interceptor.dart';

class NetworkService extends GetxService {
  late Dio _dio;
  final ConnectivityService _connectivityService =
      Get.find<ConnectivityService>();

  @override
  void onInit() {
    super.onInit();
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl, // 替换为实际的 base URL
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );

    _dio = Dio(options);
    _dio.interceptors.add(AddCookiesInterceptor());
    _dio.interceptors.add(ReceivedCookiesInterceptor());
    _dio.interceptors.add(HeaderInterceptor());
    _dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  Future<ResponseData<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    required T Function(Object? json) fromJsonT,
  }) async {
    return _request(
      () => _dio.get(path, queryParameters: queryParameters),
      fromJsonT,
    );
  }

  Future<ResponseData<T>> post<T>(
    String path, {
    Map<String, dynamic>? data,
    required T Function(Object? json) fromJsonT,
  }) async {
    return _request(
      () => _dio.post(path, data: data),
      fromJsonT,
    );
  }

  Future<ResponseData<T>> _request<T>(
      requestFunction, T Function(Object? json) fromJsonT) async {
    if (!_connectivityService.isConnected.value) {
      // Get.snackbar('error'.tr, 'netNotConnected'.tr);
      return ResponseData.error(message: 'netNotConnected'.tr);
    }

    try {
      final response = await requestFunction();
      int? code = response.data['code'] as int?;
      String? message = response.data['message'] as String?;
      if (code == 201) {
        Get.find<EventBus>().fire(UnLoginEvent());
        return ResponseData.error(code: code, message: message);
      } else {
        return ResponseData<T>.fromJson(response.data, fromJsonT);
      }
    } catch (e) {
      return ResponseData.error(code: 0, message: e.toString());
    }
  }
}
