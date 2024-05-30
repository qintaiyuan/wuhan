import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:wuhan/constants/constants.dart';

import '../app/data/models/user_model.dart';
import 'data_service.dart';

class UserService extends GetxService {
  final DataService _dataService = Get.find<DataService>();
  Rx<UserAccount?> user = Rx<UserAccount?>(null);

  @override
  Future<void> onInit() async {
    await _loadUserFromCache();
    super.onInit();
  }

  bool isSignedIn() {
    return user.value != null;
  }

  Future<void> _loadUserFromCache() async {
    try {
      _dataService.getMap(userInfoCache);
      user.value = UserAccount.fromJson(_dataService.getMap(userInfoCache));
    } catch (e) {
      if (kDebugMode) {
        print('Error loading user from cache: $e');
      }
    }
  }

  void setUser(UserAccount newUser) {
    user.value = newUser;
    _saveUserToCache(newUser);
  }

  void _saveUserToCache(UserAccount user) async {
    try {
      _dataService.putMap(userInfoCache, user.toJson());
    } catch (e) {
      if (kDebugMode) {
        print('Error saving user to cache: $e');
      }
    }
  }

  void clearUser() {
    // 清空用户信息
    user.value = null;
    _dataService.delate(userInfoCache);
  }

  UserAccount? getUser() {
    return user.value;
  }
}
