import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:wuhan/extensions.dart';

import '../../../services/app_info_service.dart';
import '../credential_calculator.dart';

class HeaderInterceptor extends Interceptor {
  final AppInfoService _appInfoService = Get.find();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final String requestJsonStr =
        options.data != null ? jsonEncode(options.data) : '';
    final CredentialCalculator credentialCalculator = CredentialCalculator(
      postParameter: requestJsonStr,
      type: options.method == 'GET' ? HttpType.Get : HttpType.Post,
    );

    options.headers.addAll({
      'Content-Type': options.contentType ?? 'application/json',
      'X-Request-ID': _getRequestId(),
      'X-Mobile-Id': _appInfoService.deviceId.value,
      'Accept-Language': 'zh_CN',
      'X-App-Version': _appInfoService.appVersion.value,
      'Authorization': credentialCalculator.getAuthInfo(),
    });

    if (options.method == 'GET') {
      final sortedQuery = getSortedQuery(options.uri);
      options.queryParameters = Map.fromEntries(
        Uri.splitQueryString(sortedQuery).entries,
      );
    }

    super.onRequest(options, handler);
  }

  String _getRequestId() {
    return 'App_Android_${DateTime.now().millisecondsSinceEpoch}_${DateTime.now().millisecondsSinceEpoch % 10000}';
  }

  String getSortedQuery(Uri url) {
    if (url.queryParameters.isEmpty) {
      return '';
    }
    final map = Map<String, String>.from(url.queryParameters);
    return map.toSortedQueryString();
  }
}
