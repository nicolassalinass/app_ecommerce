import 'package:app_ecomerce/features/products/domain/entities/product.dart';
import 'package:app_ecomerce/features/products/domain/repositories/product_repository.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProductImage {
  final ProductRepository repository;

  UpdateProductImage(this.repository);

  Future<String> call(int productId, XFile image, String token) async {
    return await repository.updateProductImage(productId, image, token);
  }
}

