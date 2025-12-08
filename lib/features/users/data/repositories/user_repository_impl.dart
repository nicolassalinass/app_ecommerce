import 'package:app_ecomerce/features/users/data/datasources/user_remote_data_source.dart';
import 'package:app_ecomerce/features/users/domain/entities/user.dart';
import 'package:app_ecomerce/features/users/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository{
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<User>> getUsers(String token) async {
    try {
      final data = await remoteDataSource.getUsers(token);
      final user = data.map((e) => User(id: e.id, name: e.name, email: e.email, rol: e.rol, isActive: e.isActive, createdAt: e.createdAt),).toList();
      return user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<User> creteUser(User user, String token) async {
    try {
      final data = await remoteDataSource.createUser(user, token);
      final newUser = User(name: data.name, email: data.email, password: data.password,rol: data.rol, isActive: data.isActive);
      return newUser;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<User> updateUser(int userId, User user, String token) async {
    try {
      final data = await remoteDataSource.updateUser(userId, user, token);
      final updatedUser = User(id: data.id, name: data.name, email: data.email, rol: data.rol, isActive: data.isActive, createdAt: data.createdAt);
      return updatedUser;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> deleteUser(int userId, String token) async{
    try {
      return await remoteDataSource.deleteUser(userId, token);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}