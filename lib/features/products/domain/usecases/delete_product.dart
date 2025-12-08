import 'package:app_ecomerce/features/products/domain/repositories/product_repository.dart';

class DeleteProduct {
  final ProductRepository repository;

  DeleteProduct(this.repository);

  Future<void> delete(int productId, String token) async {
    return await repository.deleteProduct(productId, token);
  }
}