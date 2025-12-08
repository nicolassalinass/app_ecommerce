import 'package:app_ecomerce/features/users/domain/entities/user.dart';

class UserResponse extends User {
  UserResponse({
    super.id,
    required super.name,
    required super.email,
    super.password,
    required super.rol,
    required super.isActive,
    super.createdAt,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        id: (json["id"] as num).toInt(),
        name: json["name"],
        email: json["email"],
        rol: json["rol"],
        isActive: json["is_active"],
        createdAt: (json["created_at"] != null) ? DateTime.parse(json["created_at"]) : null,
  );

    Map<String, dynamic> toJson() => {
        "name": name,
        "password": password,
        "email": email,
        "rol": rol,
        "is_active": isActive,
    };
}