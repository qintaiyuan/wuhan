class ResponseData<T> {
  final T? data;
  final int? code;
  final String? message;

  ResponseData({this.data, this.code, this.message});

  factory ResponseData.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) {
    return ResponseData<T>(
      data: json['data'] != null ? fromJsonT(json['data']) : null,
      code: json['code'] as int?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson(Object Function(T? value) toJsonT) {
    return {
      'data': data != null ? toJsonT(data) : null,
      'code': code,
      'message': message,
    };
  }
}
