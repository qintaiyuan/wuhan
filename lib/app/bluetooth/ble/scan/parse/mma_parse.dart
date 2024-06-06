import 'package:wuhan/extensions.dart';

class MmaParse {
  bool getDeviceBondState(bool isPairing, List<int> mainData) {
    int pairingIsBondIndex = 6; // 这是配对状态的索引
    int unPairingBondIndex = 7; // 这是未配对状态的索引

    if (isPairing) {
      return mainData[pairingIsBondIndex].isOne(0);
    } else {
      return mainData[unPairingBondIndex].isOne(0);
    }
  }

  String getDeviceModel(bool isPairing, List<int> mainData) {
    int o38fMajorIdIndex = 4; // 这是配对状态的主 ID 索引
    int oa67MajorIdIndex = 5; // 这是未配对状态的主 ID 索引
    int o38fMinorIdIndex = 5; // 这是配对状态的次 ID 索引
    int oa67MinorIdIndex = 6; // 这是未配对状态的次 ID 索引
    int majorShlLenght = 8;   // 主 ID 需要左移的位数

    int majorId = isPairing ? mainData[o38fMajorIdIndex] : mainData[oa67MajorIdIndex];
    int minorId = isPairing ? mainData[o38fMinorIdIndex] : mainData[oa67MinorIdIndex];

    return ((majorId << majorShlLenght) + minorId).toRadixString(16);
  }

  String getDeviceMac(List<int> mainData) {
    int macStartIndex = 13; // 这是MAC地址的开始索引
    int macEndIndex = 19;  // 这是MAC地址的结束索引

    return mainData.sublist(macStartIndex, macEndIndex).toMacAddress();
  }
}