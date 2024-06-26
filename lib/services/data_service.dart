import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../constants/constants.dart';

class DataService extends GetxService{
  late Box dataBox;
  Future<DataService> init() async {
    // 打开一个名为myBox的Box（类似于数据库中的表）
    await Hive.openBox(cacheFlageBox);
    dataBox = Hive.box(cacheFlageBox);
    if (kDebugMode) {
      print('dataService init');
    }
    return this;
  }

  void putBool(String key, bool value){
    dataBox.put(key, value);
  }

  bool getBool(String key, [bool? defaultValue = false]) {
    return dataBox.get(key, defaultValue: defaultValue);
  }

  String getString(String key) {
    return dataBox.get(key);
  }

  void putString(String key, String value) {
    dataBox.put(key, value);
  }

  Map<String, dynamic> getMap(String key) {
    final data = dataBox.get(key);
    if (data is Map) {
      return Map<String, dynamic>.from(data);
    }
    throw Exception('Data for key $key is not a Map<String, dynamic>');
  }

  void putMap(String key , Map<String, dynamic> value) {
    dataBox.put(key, value);
  }

  void put(String key, dynamic value) {
    dataBox.put(key, value);
  }

  void delate(String key) {
    dataBox.delete(key);
  }

  dynamic get(String key) {
    return dataBox.get(key);
  }
}