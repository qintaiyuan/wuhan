import 'package:wuhan/app/bluetooth/ble/base/base_ble_response.dart';

class CommandResult<R extends BaseBleResponse> {
  final R? response;
  final bool isSuccess;
  final String? error;
  final int? errorCode;

  CommandResult.success(this.response)
      : isSuccess = true,
        error = null,
        errorCode = null;

  CommandResult.error(this.error, [this.errorCode])
      : isSuccess = false,
        response = null;
}
