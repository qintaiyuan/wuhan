enum State { SUCCESS, ERROR }

class ResponseData<T> {
  final State state;
  final T? data;
  final int? code;
  final String? message;

  ResponseData({required this.state, this.data, this.code, this.message});

  ResponseData._({required this.state, this.data, this.code, this.message});

  factory ResponseData.fromJson(
      Map<String, dynamic> json, T Function(Object? json) fromJsonT) {
    int? tempCode = json['code'] as int?;
    return ResponseData<T>(
      state: tempCode == 200 ? State.SUCCESS : State.ERROR,
      data: json['data'] != null ? fromJsonT(json['data']) : null,
      code: tempCode,
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

  factory ResponseData.error({int? code, String? message}) {
    return ResponseData._(state: State.ERROR, code: code, message: message);
  }

  bool isSuccess() {
    return state == State.SUCCESS;
  }

  bool isError() {
    return state == State.ERROR;
  }
}
