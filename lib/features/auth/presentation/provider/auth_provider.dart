import 'package:app_ecomerce/config/depends/provider_client_url.dart';
import 'package:app_ecomerce/features/auth/domain/entities/register.dart';
import 'package:app_ecomerce/features/auth/domain/usecases/register_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_ecomerce/features/auth/domain/entities/login.dart';
import 'package:app_ecomerce/features/auth/domain/entities/auth_me.dart';
import 'package:app_ecomerce/features/auth/domain/usecases/login_user.dart';
import 'package:app_ecomerce/features/auth/domain/usecases/get_auth_me.dart';
import 'package:app_ecomerce/features/auth/data/repositories/login_repository_impl.dart';
import 'package:app_ecomerce/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Estado de autenticación
class AuthState {
  final bool isLoading;
  final bool isAuthenticated;
  final Login? user;
  final AuthMe? userData;
  final String? error;

  AuthState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.user,
    this.userData,
    this.error,
  });

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    Login? user,
    AuthMe? userData,
    String? error,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: user ?? this.user,
      userData: userData ?? this.userData,
      error: error,
    );
  }
}

// Notifier para manejar la autenticación
class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    // Verificar estado de autenticación al inicializar
    _checkAuthStatus();
    return AuthState();
  }

  // Verificar si el usuario ya está autenticado
  Future<void> _checkAuthStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token != null && token.isNotEmpty) {
      final tokenType = prefs.getString('token_type') ?? 'Bearer';
      state = state.copyWith(
        isAuthenticated: true,
        user: Login(accessToken: token, tokenType: tokenType),
      );
    }
  }

  // Login
  Future<void> login(String username, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final loginUser = ref.read(loginUserProvider);
      final result = await loginUser.call(username, password);

      // Guardar token en SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', result.accessToken);
      await prefs.setString('token_type', result.tokenType);

      state = state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        user: result,
        error: null,
      );

      // Obtener datos del usuario después del login
      await getMe();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: false,
        error: e.toString(),
      );
    }
  }

  // Obtener datos del usuario autenticado
  Future<void> getMe() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      if (token == null || token.isEmpty) {
        throw Exception('No hay token de autenticación');
      }

      final getAuthMe = ref.read(getAuthMeProvider);
      final userData = await getAuthMe.call(token);

      state = state.copyWith(userData: userData);
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
      );
    }
  }

  // Logout
  Future<void> logout() async {
    state = state.copyWith(isLoading: true);

    try {
      // Realizar el logout y esperar al menos 1.5 segundos para mostrar el indicador
      await Future.wait([
        Future.delayed(Duration(milliseconds: 1500)),
        _performLogout(),
      ]);

      state = AuthState(
        isLoading: false,
        isAuthenticated: false,
        user: null,
        userData: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // Realizar las operaciones de logout
  Future<void> _performLogout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('token_type');
  }

  // Limpiar error
  void clearError() {
    state = state.copyWith(error: null);
  }
}


// Provider para el DataSource
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final client = ref.watch(httpClientProvider);
  final baseUrl = ref.watch(baseUrlProvider);

  return AuthRemoteDataSourceImpl(
    client: client,
    baseUrl: baseUrl,
  );
});

// Provider para el Repository
final authRepositoryProvider = Provider<LoginRepositoryImpl>((ref) {
  final remoteDataSource = ref.watch(authRemoteDataSourceProvider);

  return LoginRepositoryImpl(
    remoteDataSource: remoteDataSource,
  );
});

// Provider para el UseCase
final loginUserProvider = Provider<LoginUser>((ref) {
  final repository = ref.watch(authRepositoryProvider);

  return LoginUser(repository);
});

// Provider para GetAuthMe
final getAuthMeProvider = Provider<GetAuthMe>((ref) {
  final repository = ref.watch(authRepositoryProvider);

  return GetAuthMe(repository);
});

// Provider principal de autenticación
final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

final registerUserCase = Provider<RegisterUser>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return RegisterUser(repository);
},);
