import 'package:wuhan/app/bluetooth/ble/command/commandtype/mma_command_type.dart';
import 'package:wuhan/app/bluetooth/ble/command/strategy/mma/base_mma_cmd_strategy.dart';

class GetBasicInfo extends BaseMmaCmdStrategy {
  GetBasicInfo() : super(MMACommandType.GetBasicInfo);
  final int _contentByte = 0xff;

  @override
  List<int> getContentData() {
    return [_contentByte, _contentByte, _contentByte, _contentByte];
  }
}
