import 'package:app_ecomerce/features/auth/domain/entities/login.dart';

class LoginModel extends Login{
  LoginModel({
    required super.accessToken,
    required super.tokenType
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
        accessToken: json["access_token"],
        tokenType: json["token_type"]
    );
  }

}