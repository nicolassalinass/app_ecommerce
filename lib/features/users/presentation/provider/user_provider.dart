import 'package:app_ecomerce/config/depends/provider_client_url.dart';
import 'package:app_ecomerce/features/users/data/datasources/user_remote_data_source.dart';
import 'package:app_ecomerce/features/users/data/repositories/user_repository_impl.dart';
import 'package:app_ecomerce/features/users/domain/repository/user_repository.dart';
import 'package:app_ecomerce/features/users/domain/usecase/create_user.dart';
import 'package:app_ecomerce/features/users/domain/usecase/delete_user.dart';
import 'package:app_ecomerce/features/users/domain/usecase/get_users.dart';
import 'package:app_ecomerce/features/users/domain/usecase/update_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

export 'package:app_ecomerce/features/users/domain/entities/user.dart';

/// Remote Data Source Provider
final userRemoteDatasourceProvider = Provider<UserRemoteDataSource>((ref) {
  final client = ref.watch(httpClientProvider);
  final baseUrl = ref.watch(baseUrlProvider);

  return UserRemoteDataSourceImpl(client: client, baseUrl: baseUrl);
});

// Repository Provider
final userRepositoryProvider = Provider<UserRepository>((ref) {
  final remoteDataSource = ref.watch(userRemoteDatasourceProvider);
  return UserRepositoryImpl(remoteDataSource: remoteDataSource);
});

// Use Case Provider
final getUserUseCaseProvider = Provider<GetUsers>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return GetUsers(repository);
});

// Use Case para crear usuario
final crearteUserCaseProvider = Provider<CreateUser>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return CreateUser(repository);
});

// Use Case para actualizar usuario
final updateUserCaseProvider = Provider<UpdateUser>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return UpdateUser(repository);
});

// Use Case para eliminar usuario
final deleteUserCaseProvider = Provider<DeleteUser>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return DeleteUser(repository);
});
