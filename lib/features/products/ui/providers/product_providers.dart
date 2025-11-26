import 'dart:async';

import 'package:app_ecomerce/config/depends/dependency_injection.dart';
import 'package:app_ecomerce/features/products/domain/entities/product.dart';
import 'package:app_ecomerce/features/products/domain/usecases/get_products.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Duración entre actualizaciones (personaliza según necesites)
const refreshInterval = Duration(seconds: 60); // Cada 30 segundos

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

// Provider con actualización automática que se pausa cuando no se observa
final autoRefreshProductsProvider = StreamProvider<List<Product>>((ref) async* {
  final notifier = ref.watch(productNotifierProvider.notifier);
  
  // Carga inicial
  final initialData = await ref.watch(productNotifierProvider.future);
  yield initialData;
  
  // Configura actualizaciones periódicas
  while (true) {
    await Future.delayed(refreshInterval);
    try {
      await notifier.refresh();
      
      // Emite el nuevo estado
      final state = ref.read(productNotifierProvider);
      if (state.hasValue) {
        yield state.value!;
      }
    } catch (e) {
      // Maneja errores sin detener el loop
      continue;
    }
  }
});