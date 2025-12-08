import 'package:app_ecomerce/features/auth/domain/entities/auth_me.dart';
import 'package:app_ecomerce/features/auth/domain/repositories/auth_repository.dart';

class GetAuthMe {
  final AuthRepository repository;

  GetAuthMe(this.repository);

  Future<AuthMe> call(String token) async {
    return await repository.authMe(token);
  }
}

