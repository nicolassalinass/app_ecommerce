import 'package:app_ecomerce/features/cart/domain/entities/cart.dart';
import 'package:app_ecomerce/features/cart/domain/repository/repository.dart';

class GetCart {
  final CartRepository repository;
  GetCart(this.repository);
  Future<Cart> getCart(String token) async {
    return await repository.getCart(token);
  }
}