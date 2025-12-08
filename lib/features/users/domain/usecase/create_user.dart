import 'package:app_ecomerce/features/users/domain/entities/user.dart';
import 'package:app_ecomerce/features/users/domain/repository/user_repository.dart';

class CreateUser {
  final UserRepository repository;
  CreateUser(this.repository);

  Future<User> creteUser(User user, String token) async {
    return await repository.creteUser(user, token);
  }
}