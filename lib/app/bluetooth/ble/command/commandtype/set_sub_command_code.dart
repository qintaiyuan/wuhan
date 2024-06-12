enum SetSubCommandCode {
  DiyGesture(0x0002), // 自定义按键
  MultiDeviceConnect(0x0004), // 多点连接
  DeviceName(0x0008), // 设备名称
  SnRight(0x0027), // SN号(右腿)
  SnLeft(0x011A), // SN号(左腿)
  SyncUTC(0x0028), // 同步手机UTC时间到设备
  SetBind(0x0100), // 设置绑定、解绑
  SupportItems(0x0101), // 设备支持项
  VolumeAdjust(0x0103), // 音量自动调节
  VolumeProtection(0x0104), // 音量自动调节
  FastDial(0x0105), // 快捷拨号（紧急联系人）
  AudioTip(0x0106), // 提示音
  DeviceConnectionSet(0x0107), // 连接、断开、取消配对特定经典蓝牙
  DisconnectBle(0x0108), // 断开蓝牙（1：ble, 2: 经典蓝牙， 3：ble+经典蓝牙）
  CervicalSwitch(0x0109), // 颈椎检测开关（FQC以及APP）
  CervicalDataSwitch(0x010A), // 动态推送颈椎数据欧拉角的开关
  CervicalInfo(0x010B), // 颈椎数据
  WearSwitch(0x010C), // 佩戴指令采集开关
  WearInfo(0x010D), // 佩戴数据
  SensorCheck(0x0110), // 颈椎检 开始传感器校准
  AdjustSensor(0x0111), // 颈椎检 查询传感器校准状态
  DelCervicalHistroyData(0x0112), // 删除颈椎监控历史数据
  FindGlasses(0x0114), // 查找眼镜
  CervicalHealthNotice(0x0116), // 颈椎健康提醒开关（5、10、30、关闭）
  BatteryInfo(0x0117), // 电量，充电显示（FQC）
  GestureReport(0x0119), // 手势上报
  AutoStandby(0x011D), // 自动待机
  GameMode(0x0123), // 游戏模式开关（低延迟模式开关）
  SetLedState(0x0121), // Led调节
  OtaResult(0x0124), // 查询ota结果
  DeviceChannel(0x0125), // 设备channel
  GetRightDiffData(0x0127), // 获取diff值（FQC）
  SetSleepModel(0x0128), // 睡眠设置（FQC）
  GetLeftDiffData(0x0129), // 获取diff值（FQC）
  WearDetection(0x012A), // "查询/设置佩戴检测灵敏度的值
  WearDetectionCalibrate(0x012B), // 佩戴检测校准
  StartCTKDConnect(0x012c), // 开始建立CTKD连接
  CheckCTKDState(0x012d); // 检测CTKD连接状态

  final int code;

  const SetSubCommandCode(this.code);

  static final Map<int, SetSubCommandCode> _map = {
    for (var value in SetSubCommandCode.values) value.code: value
  };

  static SetSubCommandCode? fromCode(int code) {
    return _map[code];
  }
}
