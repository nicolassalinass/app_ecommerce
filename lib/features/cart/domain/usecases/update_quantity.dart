import 'package:app_ecomerce/features/cart/domain/entities/cart.dart';
import 'package:app_ecomerce/features/cart/domain/repository/repository.dart';

class UpdateQuantity{
  final CartRepository repository;

  UpdateQuantity(this.repository);

  Future<Item> updateQuantity(int itemId, int newQuantity, String token){
    return repository.updateQuantity(itemId, newQuantity, token);
  }
}