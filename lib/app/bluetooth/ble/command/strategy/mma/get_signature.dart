import 'package:wuhan/app/bluetooth/ble/command/commandtype/mma_command_type.dart';
import 'package:wuhan/app/bluetooth/ble/command/strategy/mma/base_mma_cmd_strategy.dart';

class GetSignature extends BaseMmaCmdStrategy{
  final int randomNum;
  GetSignature({required this.randomNum}): super(MMACommandType.CertifyStep1);
  final versionValue = 0x10;
  @override
  List<int> getContentData() {
    return [versionValue, randomNum];
  }
}