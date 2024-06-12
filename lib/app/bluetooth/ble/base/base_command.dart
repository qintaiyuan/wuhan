import 'package:wuhan/app/bluetooth/ble/interf/iresponse_listener.dart';

import '../../../utils/ble_command_utils.dart';
import 'base_ble_response.dart';

abstract class BaseCommand {
  final int seq = BleCommandUtils.getBleCmdSeq(); // 命令序列
  final int timeout = 10; // 命令超时时间
  IResponseListener<BaseBleResponse>? iResponseListener;

  // 获取命令类型
  List<int> getOpCode();

  // 发送给设备端的数据
  List<int> getData();
}
