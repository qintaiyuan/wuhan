import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../app/data/models/response_model.dart';
import '../app/network/interceptor/header_interceptor.dart';
class NetworkService extends GetxService {
  late Dio _dio;

  @override
  void onInit() {
    super.onInit();

    BaseOptions options = BaseOptions(
      baseUrl: 'https://api.superhexa.com', // 替换为实际的 base URL
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );

    _dio = Dio(options);
    _dio.interceptors.add(HeaderInterceptor(
      deviceId: 'your_device_id',
      appVersion: '1.0.0',
      serviceToken: 'f7b364516e739c2ac60f1114e88f6afc',
      passToken: 'your_pass_token',
    ));
    // _dio.interceptors.add(CookieManager(CookieJar()));
    _dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  Future<ResponseData<T>> get<T>(
      String path, {
        Map<String, dynamic>? queryParameters,
        required T Function(Object? json) fromJsonT,
      }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return ResponseData<T>.fromJson(response.data, fromJsonT);
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<ResponseData<T>> post<T>(
      String path, {
        Map<String, dynamic>? data,
        required T Function(Object? json) fromJsonT,
      }) async {
    try {
      final response = await _dio.post(path, data: data);
      return ResponseData<T>.fromJson(response.data, fromJsonT);
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  void _handleError(dynamic error) {
    // 统一处理错误
    if (error is DioError) {
      Get.snackbar('Error', error.message);
    }
  }
}
