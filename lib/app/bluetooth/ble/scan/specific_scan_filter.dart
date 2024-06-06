import 'package:wuhan/extensions.dart';

abstract class ScanFilter {
  late List<int> manufacturerData;
  bool matches(List<int> manufacturerData) {
    for (int i = 0; i < this.manufacturerData.length; i++) {
      if (!manufacturerData.isMatch(this.manufacturerData)) {
        return false;
      }
    }
    return true;
  }
}

abstract class SpecificScanFilter implements ScanFilter {

  // SpecificScanFilter({required this.manufacturerData});

  @override
  bool matches(List<int> manufacturerData) {
      for (int i = 0; i < this.manufacturerData.length; i++) {
        if (!manufacturerData.isMatch(this.manufacturerData)) {
          return false;
        }
      }
      return true;
  }
}
