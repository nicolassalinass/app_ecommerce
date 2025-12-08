class AuthMe {
  final int id;
  final String name;
  final String email;
  final String rol;
  final bool isActive;
  DateTime? createdAt;

  AuthMe({
    required this.id,
    required this.name,
    required this.email,
    required this.rol,
    required this.isActive,
    this.createdAt,
  });


}