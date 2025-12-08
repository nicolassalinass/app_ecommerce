import 'package:app_ecomerce/features/auth/domain/entities/auth_me.dart';
import 'package:app_ecomerce/features/auth/domain/entities/login.dart';
import 'package:app_ecomerce/features/auth/domain/entities/register.dart';

abstract class AuthRepository{
  Future<Login> login(String username, String password);
  Future<AuthMe> authMe(String token);
  Future<Register> register(String name, String email, String password);
}