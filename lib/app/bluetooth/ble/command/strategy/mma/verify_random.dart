import '../../commandtype/mma_command_type.dart';
import 'base_mma_cmd_strategy.dart';

class VerifyRandom extends BaseMmaCmdStrategy{
  final List<int> signdArray;
  VerifyRandom({required this.signdArray}): super(MMACommandType.CertifyStep2);
  final signedArraySize = 0x40;
  @override
  List<int> getContentData() {
    return [signedArraySize, ...signdArray];
  }
}