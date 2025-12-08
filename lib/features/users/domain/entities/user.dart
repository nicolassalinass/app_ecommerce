class User {
  int? id;
  final String name;
  final String email;
  String? password;
  final String rol;
  final bool isActive;
  DateTime? createdAt;

  User({
    this.id,
    required this.name,
    required this.email,
    this.password,
    required this.rol,
    required this.isActive,
    this.createdAt,
  });
}