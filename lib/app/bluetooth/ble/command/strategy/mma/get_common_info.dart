import 'package:wuhan/app/bluetooth/ble/command/commandtype/mma_command_type.dart';
import 'package:wuhan/app/bluetooth/ble/command/commandtype/set_sub_command_code.dart';
import 'package:wuhan/app/bluetooth/ble/command/strategy/mma/base_mma_cmd_strategy.dart';

class GetCommonInfo extends BaseMmaCmdStrategy {
  final List<SetSubCommandCode> items;

  // 构造函数接受 List<SetSubCmdCode>
  GetCommonInfo(this.items) : super(MMACommandType.GetCommonInfo);

  // 构造函数接受单个 SetSubCmdCode 对象
  GetCommonInfo.single(SetSubCommandCode item) : this([item]);

  @override
  List<int> getContentData() {
    var configArray = <int>[];
    for (var item in items) {
      configArray.add(item.code);
    }
    return configArray;
  }
}