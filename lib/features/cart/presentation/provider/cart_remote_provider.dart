import 'package:app_ecomerce/config/depends/provider_client_url.dart';
import 'package:app_ecomerce/features/cart/data/datasource/cart_remote_data_source.dart';
import 'package:app_ecomerce/features/cart/data/repositories/repository_impl.dart';
import 'package:app_ecomerce/features/cart/domain/entities/cart.dart';
import 'package:app_ecomerce/features/cart/domain/repository/repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Provider del data source
final cartRemoteDataSourceProvider = Provider<CartRemoteDataSource>((ref) {
  final client = ref.watch(httpClientProvider);
  final baseUrl = ref.watch(baseUrlProvider);
  return CartRemoteDataSourceImpl(client: client, baseUrl: baseUrl);
});

// Provider del repositorio
final cartRepositoryProvider = Provider<CartRepository>((ref) {
  final remoteDataSource = ref.watch(cartRemoteDataSourceProvider);
  return RepositoryImpl(remoteDataSource);
});

// Notifier que maneja el estado del carrito
class CartNotifier extends AsyncNotifier<Cart?> {
  @override
  Future<Cart?> build() async {
    return await _fetchCart();
  }

  Future<Cart?> _fetchCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token') ?? '';
      
      final repository = ref.read(cartRepositoryProvider);
      return await repository.getCart(token);
    } catch (e) {
      // Si no hay carrito o hay error, retorna null
      return null;
    }
  }

  Future<void> addToCart(int productId, int quantity) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token') ?? '';
      
      final repository = ref.read(cartRepositoryProvider);
      return await repository.addToCart(productId, quantity, token);
    });
  }

  Future<void> incrementQuantity(int itemId, int currentQuantity) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token') ?? '';
      final repository = ref.read(cartRepositoryProvider);
      
      // updateQuantity devuelve solo el Item actualizado, no el Cart completo
      await repository.updateQuantity(itemId, currentQuantity + 1, token);
      
      // Ahora obtenemos el carrito completo actualizado
      return await repository.getCart(token);
    });
  }

  Future<void> decrementQuantity(int itemId, int currentQuantity) async {
    if (currentQuantity <= 1) return;

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token') ?? '';
      final repository = ref.read(cartRepositoryProvider);
      
      // updateQuantity devuelve solo el Item actualizado, no el Cart completo
      await repository.updateQuantity(itemId, currentQuantity - 1, token);
      
      // Ahora obtenemos el carrito completo actualizado
      return await repository.getCart(token);
    });
  }

  Future<void> removeFromCart(int productId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token') ?? '';
      
      final repository = ref.read(cartRepositoryProvider);
      await repository.removeFromCart(productId, token);
      return await _fetchCart();
    });
  }

  Future<void> clearCart() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token') ?? '';
      
      final repository = ref.read(cartRepositoryProvider);
      await repository.clearCart(token);
      return null;
    });
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchCart());
  }

  // Calcular total del carrito
  double get total {
    if (state.value == null) return 0.0;
    return state.value!.items.fold(
      0.0,
      (sum, item) => sum + (item.product.precio * item.quantity),
    );
  }

  // Cantidad total de items
  int get itemCount {
    if (state.value == null) return 0;
    return state.value!.items.fold(
      0,
      (sum, item) => sum + item.quantity,
    );
  }

  Future<void> incrementItem(Item item) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token') ?? '';

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(cartRepositoryProvider);
      await repository.updateQuantity(item.id!, item.quantity + 1, token);
      return await repository.getCart(token);
    });
  }

  Future<void> decrementItem(Item item) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token') ?? '';

    if (item.quantity <= 1) {
      // Si se quiere decrementar por debajo de 1 → eliminar
      await removeFromCart(item.id!);
      return;
    }

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(cartRepositoryProvider);
      await repository.updateQuantity(item.id!, item.quantity - 1, token);
      return await repository.getCart(token);
    });
  }

}

// Provider global del carrito
final cartRemoteNotifierProvider =
    AsyncNotifierProvider<CartNotifier, Cart?>(() => CartNotifier());
