import 'package:app_ecomerce/features/users/domain/repository/user_repository.dart';

class DeleteUser {
  final UserRepository repository;

  DeleteUser(this.repository);

  Future<void> deleteUser(int userId, String token) async {
    return await repository.deleteUser(userId, token);
  }
}