import 'package:get/get.dart';
import '../../../constants/constants.dart';
import '../../../services/user_service.dart';
import '../../network/services/network_service.dart';
import '../../utils/hash_calculator.dart';
import '../models/response_model.dart';
import '../models/user_model.dart';

class PassportRespository {
  final NetworkService _networkService = Get.find();
  final UserService _userService = Get.find();

  Future<ResponseData<bool>> fetchVerificationCode(String phoneNum) async {
    var response = await _networkService.post(
      '/passport/v1/codes',
      data: {
        'phone': phoneNum,
        'type': "1",
      },
      fromJsonT: (json) => json as bool,
    );
    return response;
  }

  Future<ResponseData<UserAccount>> loginWithVerificationCode(
      String phoneNum, String verificationCode) async {
    var response = await _networkService.post<UserAccount>(
      '/passport/v1/login',
      data: {
        "identityType": "1",
        "identifier": phoneNum,
        "credential": verificationCode,
        "platform": "1"
      },
      fromJsonT: (json) => UserAccount.fromJson(json as Map<String, dynamic>),
    );
    if (response.isSuccess()) {
      _userService.setUser(response.data as UserAccount);
    }
    return response;
  }

  Future<ResponseData<UserAccount>> loginWithPassword(
      String phoneNum, String password) async {
    var response = await _networkService.post<UserAccount>(
      '/passport/v1/login',
      data: {
        "identityType": "2",
        "identifier": phoneNum,
        "credential":
            HashCalculator().getHashUsingHmacSHA256(serviceToken, password),
        "platform": "1"
      },
      fromJsonT: (json) => UserAccount.fromJson(json as Map<String, dynamic>),
    );
    if (response.isSuccess()) {
      _userService.setUser(response.data as UserAccount);
    }
    return response;
  }
}
