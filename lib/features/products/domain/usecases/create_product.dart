import 'package:app_ecomerce/features/products/domain/entities/product.dart';
import 'package:app_ecomerce/features/products/domain/repositories/product_repository.dart';

class CreateProduct{
  final ProductRepository repository;

  CreateProduct(this.repository);

  Future<Product> createProduct(Product product, String token) async {
    return await repository.createProduct(product, token);
  }
}