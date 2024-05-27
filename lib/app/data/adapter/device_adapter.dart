import 'package:hive/hive.dart';
import 'package:wuhan/app/data/models/device_model.dart';

class DeviceAdapter extends TypeAdapter<DeviceInfo> {
  @override
  final typeId = 0;  // 每个适配器都需要一个唯一的类型ID

  @override
  DeviceInfo read(BinaryReader reader) {
    final deviceId = reader.readInt32();
    final model = reader.readString();
    final nickname = reader.readString();
    final mac = reader.readString();
    final leftSn = reader.readString();
    final rightSn = reader.readString();
    return DeviceInfo(
        deviceId: deviceId,
        model: model,
        nickname: nickname,
        mac: mac,
        leftSn: leftSn,
        rightSn: rightSn
    );
  }

  @override
  void write(BinaryWriter writer, DeviceInfo obj) {
    writer.writeInt32(obj.deviceId);
    writer.writeString(obj.model);
    writer.writeString(obj.nickname);
    writer.writeString(obj.mac);
    writer.writeString(obj.leftSn);
    writer.writeString(obj.rightSn);
  }
}
