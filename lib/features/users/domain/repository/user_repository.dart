import 'package:app_ecomerce/features/users/domain/entities/user.dart';

abstract class UserRepository {
  Future<List<User>> getUsers(String token);
  Future<User> creteUser(User user, String token);
  Future<User> updateUser(int userId, User user, String token);
  Future<void> deleteUser(int userId, String token);
}