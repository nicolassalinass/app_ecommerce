import 'package:app_ecomerce/features/cart/domain/entities/cart.dart';
import 'package:app_ecomerce/features/cart/domain/repository/repository.dart';

class AddCart {
  final CartRepository repository;
  AddCart(this.repository);

  Future<Cart> addToCart(int productId, int quantity, String token) async {
    return await repository.addToCart(productId, quantity, token);
  }
}