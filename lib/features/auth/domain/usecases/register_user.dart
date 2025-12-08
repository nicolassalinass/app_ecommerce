import 'package:app_ecomerce/features/auth/domain/repositories/auth_repository.dart';

class RegisterUser {
  final AuthRepository repository;
  RegisterUser(this.repository);
  Future<void> register(String name, String email, String password) async {
    await repository.register(name, email, password);
  }
}