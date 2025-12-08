class Register {
  final String name;
  final String email;
  String? password;

  Register({
    required this.name,
    required this.email,
    this.password,
  });
}