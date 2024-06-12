import 'package:wuhan/app/bluetooth/ble/command/commandtype/mma_command_type.dart';
import 'package:wuhan/app/bluetooth/ble/command/strategy/icommand_strategy.dart';

import '../../../constants/ble_contants.dart';

class BaseMmaCmdStrategy extends ICommandStrategy {
  final MMACommandType commandType;

  BaseMmaCmdStrategy(this.commandType);

  @override
  List<int> getData(int seq) {
    final data = [seq, ...getContentData()];
    return [...prefix, 0xc4, commandType.code, data.length, ...data, ...suffix];
  }

  @override
  List<int> getOpCode() => [commandType.code];
}
