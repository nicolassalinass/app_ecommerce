import 'package:app_ecomerce/core/errors/exceptions.dart';
import 'package:app_ecomerce/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:app_ecomerce/features/auth/domain/entities/auth_me.dart';
import 'package:app_ecomerce/features/auth/domain/entities/login.dart';
import 'package:app_ecomerce/features/auth/domain/entities/register.dart';
import 'package:app_ecomerce/features/auth/domain/repositories/auth_repository.dart';

class LoginRepositoryImpl extends AuthRepository{
  final AuthRemoteDataSource remoteDataSource;

  LoginRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Login> login(String username, String password) async{
    try{
      return await remoteDataSource.login(username, password);
    }on ServerException catch (e){
      throw Exception(e.message);
    }
  }

  @override
  Future<AuthMe> authMe(String token) async{
    try{
      return await remoteDataSource.authMe(token);
    }on ServerException catch (e){
      throw Exception(e.message);
    }
  }


  @override
  Future<Register> register(String name, String email, String password) {
    try {
      final result = remoteDataSource.register(name, email, password);
      final registerN = result.then((value) {
        return Register(
          name: value.name,
          email: value.email,
          password: value.password,
        );
      });
      return registerN;
    } catch (e) {
      throw Exception('Error al registrar el usuario: $e');
    }
  }
}