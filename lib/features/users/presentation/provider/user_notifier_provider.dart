import 'package:app_ecomerce/features/users/domain/entities/user.dart';
import 'package:app_ecomerce/features/users/presentation/provider/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Notifier que maneja el estado de usuarios
class UserNotifier extends AsyncNotifier<List<User>> {
  @override
  Future<List<User>> build() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token') ?? '';
      
      if (token.isEmpty) {
        throw Exception('No se encontró un token válido. Por favor inicia sesión.');
      }
      
      final getUser = ref.read(getUserUseCaseProvider);
      return await getUser.getUsers(token);
    } catch (e) {
      throw Exception('Error al cargar usuarios: $e');
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token') ?? '';
      
      if (token.isEmpty) {
        throw Exception('No se encontró un token válido. Por favor inicia sesión.');
      }
      
      final getUser = ref.read(getUserUseCaseProvider);
      return await getUser.getUsers(token);
    });
  }
}

// Provider global del estado de usuarios
final userNotifierProvider = AsyncNotifierProvider<UserNotifier, List<User>>(
  () => UserNotifier(),
);
