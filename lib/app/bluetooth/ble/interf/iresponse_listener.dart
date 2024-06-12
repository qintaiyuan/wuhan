import 'package:wuhan/app/bluetooth/ble/base/base_ble_response.dart';

class IResponseListener<R extends BaseBleResponse> {
  IResponseListener({
    required this.onResponseSuccess,
    required this.onResponseFailed,
  });
  /// 数据传输成功(收到设备的response)回调接口
  late final void Function(R res) onResponseSuccess;

  /// 数据传输失败(没有收到server的response或者超时了)回调接口
  late final void Function(int errCode, String errMsg) onResponseFailed;
}
