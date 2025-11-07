import 'package:app_ecomerce/config/depends/dependency_injection.dart';
import 'package:app_ecomerce/features/products/domain/entities/product.dart';
import 'package:app_ecomerce/features/products/domain/usecases/get_products.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider del Caso de uso
final getProductsUseCaseProvider = Provider<GetProducts>(
  (ref) => sl<GetProducts>()
);

// Notifier que maneja el estado
class ProductNotifier extends AsyncNotifier<List<Product>> {
  @override
  Future<List<Product>> build() async {
    final getProducts = ref.read(getProductsUseCaseProvider);
    return await getProducts();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final getProducts = ref.read(getProductsUseCaseProvider);
      return await getProducts();
    });
  }
}

// Provider global del estado
final productNotifierProvider =
    AsyncNotifierProvider<ProductNotifier, List<Product>>(() => ProductNotifier());