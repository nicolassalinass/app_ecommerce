import 'package:app_ecomerce/features/cart/domain/repository/repository.dart';

class RemoveCartItem {
  final CartRepository repository;
  RemoveCartItem(this.repository);
  Future<void> removeCartItem(int productItem, String token) async {
    return await repository.removeFromCart(productItem, token);
  }
}