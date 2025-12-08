import 'package:app_ecomerce/features/users/domain/entities/user.dart';
import 'package:app_ecomerce/features/users/domain/repository/user_repository.dart';

class UpdateUser {
  final UserRepository repository;
  
  UpdateUser(this.repository);

  Future<User> updateUser(int userId, User user, String token) async{
    return await repository.updateUser(userId, user, token);
  }
}