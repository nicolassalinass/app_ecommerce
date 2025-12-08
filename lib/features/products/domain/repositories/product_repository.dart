
import 'package:app_ecomerce/features/products/domain/entities/product.dart';
import 'package:image_picker/image_picker.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
  Future<String> uploadImage(XFile image, String token);
  Future<Product> createProduct(Product product, String token);
  Future<Product> updateProduct(int productId, Product product, String token);
  Future<String> updateProductImage(int productId, XFile image, String token);
  Future<void> deleteProduct(int productId, String token);
}
