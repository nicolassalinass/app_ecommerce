import 'package:app_ecomerce/features/cart/domain/entities/cart.dart';

abstract class CartRepository{
  Future<Cart> getCart(String token);
  Future<Cart> addToCart(int productId, int quantity, String token);
  Future<void> removeFromCart(int productItem, String token);
  Future<void> clearCart(String token);
  Future<Item> updateQuantity(int itemId, int newQuantity, String token);

}
