import 'dart:convert';
import 'package:app_ecomerce/features/users/domain/entities/user.dart';
import 'package:http/http.dart' as http;
import 'package:app_ecomerce/features/users/data/model/user_response.dart';

abstract class UserRemoteDataSource {
  Future<List<UserResponse>> getUsers(String token);
  Future<UserResponse> createUser(User user, String token);
  Future<UserResponse> updateUser(int userId, User user, String token);
  Future<void> deleteUser(int userId, String token);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource{
  final http.Client client;
  final String baseUrl;

  UserRemoteDataSourceImpl({required this.client, required this.baseUrl});

  @override
  Future<List<UserResponse>> getUsers(String token) async{
    final url = Uri.parse("$baseUrl/users/");

    final response = await client.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      }
    );

    if(response.statusCode == 200){
      final List data = jsonDecode(response.body);
      return data.map((e) => UserResponse.fromJson(e),).toList();
    }else{
      throw Exception("Error al obtener usuarios: ${response.statusCode}");
    }
  }

  @override
  Future<UserResponse> createUser(User user, String token) async{
    final url = Uri.parse("$baseUrl/users/");

    final users = UserResponse(
      name: user.name, 
      email: user.email, 
      password: user.password,
      rol: user.rol, 
      isActive: user.isActive, 
    );

    final reponse = await client.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(users.toJson()),
    );

    if(reponse.statusCode == 201){
      final data = jsonDecode(reponse.body);
      return UserResponse.fromJson(data);
    }else{
      throw Exception("Error al crear usuario: ${reponse.statusCode}");
    }
  }

  @override
  Future<UserResponse> updateUser(int userId, User user, String token) async{
    final url = Uri.parse("$baseUrl/users/$userId");

    final users = UserResponse(
      name: user.name, 
      email: user.email, 
      password: user.password,
      rol: user.rol, 
      isActive: user.isActive, 
    );

    final response = await client.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(users.toJson()),
    );

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      return UserResponse.fromJson(data);
    } else {
      throw Exception("Error al actualizar usuario: ${response.statusCode}");
    }
  }

  @override
  Future<void> deleteUser(int userId, String token) async{
    final url = Uri.parse("$baseUrl/users/$userId");

    final response = await client.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      }
    );
       
    if(response.statusCode == 204){
      return;
    } else {
      throw Exception("Error al eliminar usuario: ${response.statusCode}");
    }
    
  }

}