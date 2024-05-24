import 'dart:ffi';

class UserAccount {
  final int userId;
  final String userName;
  final String passToken;
  final String phone;

  UserAccount(
      {required this.userId,
      required this.userName,
      required this.passToken,
      required this.phone});

  factory UserAccount.fromJson(Map<String, dynamic> json) {
    return UserAccount(
      userId: json['userId'],
      userName: json['userName'],
      passToken: json['passToken'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'passToken': passToken,
      'phone': phone,
    };
  }
}
