import 'package:app_ecomerce/features/auth/domain/entities/auth_me.dart';

class AuthMeResponse extends AuthMe{

  AuthMeResponse({
    required super.id,
    required super.name,
    required super.email,
    required super.rol,
    required super.isActive,
  });

  factory AuthMeResponse.fromJson(Map<String, dynamic> json) => AuthMeResponse(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    rol: json["rol"],
    isActive: json["is_active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "rol": rol,
    "is_active": isActive,
  };
}