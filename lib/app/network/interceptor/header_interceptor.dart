import 'package:dio/dio.dart';

class HeaderInterceptor extends Interceptor {
  final String deviceId;
  final String appVersion;
  final String serviceToken;
  final String passToken;

  HeaderInterceptor({
    required this.deviceId,
    required this.appVersion,
    required this.serviceToken,
    required this.passToken,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['X-Request-ID'] = _getRequestId();
    options.headers['X-Mobile-Id'] = deviceId;
    options.headers['X-App-Version'] = appVersion;

    // 添加 Authorization 头部
    final requestBody = options.data is FormData ? _parseFormData(options.data) : options.data;
    final requestJsonStr = requestBody != null ? requestBody.toString() : '';
    options.headers['Authorization'] = _calcuAuth(requestJsonStr, _getSortedQuery(options) as RequestOptions);

    handler.next(options);
  }

  String _getRequestId() {
    return "App_Android_${DateTime.now().millisecondsSinceEpoch}_${_randomInt()}";
  }

  int _randomInt() {
    return (0 + (10000 - 0) * (DateTime.now().millisecondsSinceEpoch % 10000) / 10000).toInt();
  }

  String _calcuAuth(String requestJsonStr, RequestOptions options) {
    final timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    final nonce = _md5(timeStamp + _randomInt().toString());

    final String text = options.method == 'GET'
        ? 'nonce=$nonce&timestamp=$timeStamp'
        : 'data=$requestJsonStr&nonce=$nonce&timestamp=$timeStamp';

    final String key = passToken.isEmpty ? serviceToken : '$serviceToken$passToken';

    // 生成签名
    return 'HEXA1-HMAC-SHA256 nonce=$nonce, timestamp=$timeStamp, signature=${_signature(text, key)}';
  }

  String _signature(String text, String key) {
    // 使用 HMAC-SHA256 生成签名
    // 您需要提供实际的签名生成代码
    return 'generated_signature';
  }

  String _md5(String input) {
    // 使用 MD5 生成哈希
    // 您需要提供实际的 MD5 哈希生成代码
    return 'generated_md5_hash';
  }

  String _parseFormData(FormData formData) {
    final map = {};
    formData.fields.forEach((field) => map[field.key] = field.value);
    return map.toString();
  }

  // 添加获取排序的查询参数的方法
  String _getSortedQuery(RequestOptions options) {
    final url = options.uri;
    if (url.queryParameters.isEmpty) {
      return "";
    }
    final sortedMap = url.queryParameters..removeWhere((k, v) => v == null);
    final sortedQuery = sortedMap.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    return sortedQuery.map((e) => '${e.key}=${e.value}').join('&');
  }
}
