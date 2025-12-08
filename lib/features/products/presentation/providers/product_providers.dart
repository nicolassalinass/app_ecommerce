import 'dart:async';

import 'package:app_ecomerce/config/depends/provider_client_url.dart';
import 'package:app_ecomerce/features/products/data/datasources/products_remote_data_source.dart';
import 'package:app_ecomerce/features/products/data/repositories/product_repository_impl.dart';
import 'package:app_ecomerce/features/products/domain/entities/product.dart';
import 'package:app_ecomerce/features/products/domain/repositories/product_repository.dart';
import 'package:app_ecomerce/features/products/domain/usecases/create_product.dart';
import 'package:app_ecomerce/features/products/domain/usecases/delete_product.dart';
import 'package:app_ecomerce/features/products/domain/usecases/get_products.dart';
import 'package:app_ecomerce/features/products/domain/usecases/update_product.dart';
import 'package:app_ecomerce/features/products/domain/usecases/update_product_image.dart';
import 'package:app_ecomerce/features/products/domain/usecases/uploadImage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Duración entre actualizaciones (personaliza según necesites)
// const refreshInterval = Duration(seconds: 60); // Cada 30 segundos


// Notifier que maneja el estado
class ProductNotifier extends AsyncNotifier<List<Product>> {
  @override
  Future<List<Product>> build() async {
    final getProducts = ref.read(getProductUseCaseProvider);
    return await getProducts();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final getProducts = ref.read(getProductUseCaseProvider);
      return await getProducts();
    });
  }
}

// Provider global del estado
final productNotifierProvider =
    AsyncNotifierProvider<ProductNotifier, List<Product>>(() => ProductNotifier());

// Provider con actualización automática que se pausa cuando no se observa
// final autoRefreshProductsProvider = StreamProvider<List<Product>>((ref) async* {
//   final notifier = ref.watch(productNotifierProvider.notifier);
//
//   // Carga inicial
//   final initialData = await ref.watch(productNotifierProvider.future);
//   yield initialData;
//
//   // Configura actualizaciones periódicas
//   while (true) {
//     await Future.delayed(refreshInterval);
//     try {
//       await notifier.refresh();
//
//       // Emite el nuevo estado
//       final state = ref.read(productNotifierProvider);
//       if (state.hasValue) {
//         yield state.value!;
//       }
//     } catch (e) {
//       // Maneja errores sin detener el loop
//       continue;
//     }
//   }
// });



final providerRemoteDataSource = Provider<ProductsRemoteDataSource>((ref) {
  final client = ref.watch(httpClientProvider);
  final baseUrl = ref.watch(baseUrlProvider);

  return ProductRemoteDataSourceImpl(client: client, baseUrl: baseUrl);
});


final productProviderRepository = Provider<ProductRepository>((ref) {
  final remoteDataSource = ref.watch(providerRemoteDataSource);
  
  return ProductRepositoryImpl(remoteDataSource: remoteDataSource);
  },
);

final getProductUseCaseProvider = Provider<GetProducts>((ref) {
  final repository = ref.watch(productProviderRepository);

  return GetProducts(repository);
},);


final uploadImageUseCaseProvider = Provider<UploadImage>((ref) {
  final repository = ref.watch(productProviderRepository);

  return UploadImage(repository);
},);


final createProductUseCaseProvider = Provider<CreateProduct>((ref) {
  final repository = ref.watch(productProviderRepository);

  return CreateProduct(repository);
},);


final updateProductUseCaseProvider = Provider<UpdateProduct>((ref) {
  final repository = ref.watch(productProviderRepository);

  return UpdateProduct(repository);
},);


final updateProductImageUseCaseProvider = Provider<UpdateProductImage>((ref) {
  final repository = ref.watch(productProviderRepository);

  return UpdateProductImage(repository);
},);


final deleteProductUseCaseProvider = Provider<DeleteProduct>((ref) {
  final repository = ref.watch(productProviderRepository);

  return DeleteProduct(repository);
},);

