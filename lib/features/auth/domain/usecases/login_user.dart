
import 'package:app_ecomerce/features/auth/domain/entities/auth_me.dart';
import 'package:app_ecomerce/features/auth/domain/entities/login.dart';
import 'package:app_ecomerce/features/auth/domain/repositories/auth_repository.dart';

class LoginUser{
  final AuthRepository authRepository;

  LoginUser(this.authRepository);

  Future<Login> call(String username, String password) {
    return authRepository.login(username, password);
  }

  Future<AuthMe> authMe(String token) {
    return authRepository.authMe(token);
  }
}
