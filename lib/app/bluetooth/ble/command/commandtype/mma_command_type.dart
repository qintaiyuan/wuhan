enum MMACommandType {
  GetBasicInfo(0x02),
  GetRunningInfo(0x09),
  GetShortcutCmdInfo(0xd1),
  SetShortcutCmdInfo(0xd2),
  StartShortcutCmdTrans(0xd3),
  TransShortcutCmdInfo(0xd4),
  GetUpdateFileInfoOffset(0xe1),
  IfCanUpdate(0xe2),
  EnterUpdateMode(0xe3),
  ExitUpdateMode(0xe4),
  SendFirmwareUpdateBlock(0xe5),
  GetDeviceRefreshFirmwareStatus(0xe6),
  SetDeviceReboot(0x03),
  SetCommonInfo(0xf2),
  GetCommonInfo(0xf3),
  ActiveNotifyMsg(0xf4), // 设备主动推送消息
  CertifyStep1(0xf8),
  CertifyStep2(0xf9),
  GetLogLength(0xfa),
  GetLogData(0xfb),
  GetDeviceList(0xff),
  GetCervialSpine(0xfd),
  GetDevicePoint(0xfe);

  final int code;

  const MMACommandType(this.code);

  static final Map<int, MMACommandType> _map = {
    for (var value in MMACommandType.values) value.code: value
  };

  static MMACommandType? fromCode(int code) {
    return _map[code];
  }
}
