
import 'dart:convert';

import 'package:app_ecomerce/features/auth/data/model/auth_me_response.dart';
import 'package:app_ecomerce/features/auth/data/model/login_model.dart';
import 'package:app_ecomerce/features/auth/data/model/register_model.dart';
import 'package:http/http.dart' as http;

abstract class AuthRemoteDataSource{
  Future<LoginModel> login(String username, String password);
  Future<AuthMeResponse> authMe(String token);
  Future<RegisterModel> register(String name, String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource{
  final http.Client client;
  final String baseUrl;

  AuthRemoteDataSourceImpl({required this.client, required this.baseUrl});

  @override
  Future<LoginModel> login(String username, String password) async{
    final body = {
      'grant_type': 'password',
      'username': username,
      'password': password
    };

    final response = await client.post(
        Uri.parse("$baseUrl/auth/login"),
      headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: body
    );

    if(response.statusCode == 200){
      return LoginModel.fromJson(jsonDecode(response.body));

    }else{
      throw Exception("Error al iniciar sesion: ${response.statusCode}");
    }

  }

  @override
  Future<AuthMeResponse> authMe(String token) async{
    final response = await client.get(
      Uri.parse("$baseUrl/auth/me"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if(response.statusCode == 200){
      return AuthMeResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception("Error al obtener datos del usuario: ${response.statusCode}");

    }

  }

  @override
  Future<RegisterModel> register(String name, String email, String password) async{
    final url = Uri.parse("$baseUrl/auth/register");

    final newRegister = RegisterModel(
      name: name, 
      email: email, 
      password: password
    );
  
    final response = await client.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(newRegister.toJson()),
    );

    if(response.statusCode == 201){
      return RegisterModel.fromJson(jsonDecode(response.body));
    }else{
      throw Exception("Error al registrar usuario: ${response.statusCode}");
    }
  
  }

}