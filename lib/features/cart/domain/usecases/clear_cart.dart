import 'package:app_ecomerce/features/cart/domain/repository/repository.dart';

class ClearCart {

  final CartRepository repository;

  ClearCart(this.repository);
  
  Future<void> clearCart(String token) async {
    return await repository.clearCart(token);
  }
}