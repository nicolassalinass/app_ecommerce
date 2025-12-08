import 'package:app_ecomerce/features/products/domain/entities/product.dart';
import 'package:app_ecomerce/features/products/domain/repositories/product_repository.dart';




class UpdateProduct {
  final ProductRepository repository;
    UpdateProduct(this.repository);
    Future<Product> call(int productId, Product product, String token) async {
      return await repository.updateProduct(productId, product, token);


    }
  }