import 'package:app_ecomerce/features/cart/data/datasource/cart_remote_data_source.dart';
import 'package:app_ecomerce/features/cart/domain/entities/cart.dart';
import 'package:app_ecomerce/features/cart/domain/repository/repository.dart';

class RepositoryImpl implements CartRepository{
  final CartRemoteDataSource remoteDataSource;

  RepositoryImpl(this.remoteDataSource);

  @override
  Future<Cart> getCart(String token) async{
    try {
      return await remoteDataSource.getCart(token);
    } catch (e) {
      throw Exception('Error al obtener el carrito: $e');
    }
  }

  @override
  Future<Cart> addToCart(int productId, int quantity, String token) async {
    try {
      return await remoteDataSource.addToCart(productId, quantity, token);
    } catch (e) {
      throw Exception('Error al agregar al carrito: $e');
    }
  }

  @override
  Future<void> removeFromCart(int productId, String token) async {
    try {
      await remoteDataSource.removeCartItem(productId, token);
    } catch (e) {
      throw Exception('Error al eliminar del carrito: $e');
    }
  }

  @override
  Future<void> clearCart(String token) async {
    try {
      await remoteDataSource.clearCart(token);
    } catch (e) {
      throw Exception('Error al limpiar el carrito: $e');
    }
  }

  // @override
  // Future<Item> updateQuantity(int itemId, int newQuantity, String token) async {
  //   try {
  //     final itemModel =
  //     await remoteDataSource.updateQuantity(itemId, newQuantity, token);
  //
  //     return Item(
  //       id: itemModel.id,
  //       product: itemModel.product,
  //       quantity: itemModel.quantity,
  //     );
  //   } catch (e) {
  //     throw Exception("Error actualizando cantidad: $e");
  //   }
  // }

  @override
  Future<Item> updateQuantity(int itemId, int newQuantity, String token) async {
    try {
      final itemModel =
      await remoteDataSource.updateQuantity(itemId, newQuantity, token);

      return Item(
        id: itemModel.id,
        product: itemModel.product,
        quantity: itemModel.quantity,
      );
    } catch (e) {
      throw Exception("Error actualizando cantidad: $e");
    }
  }


}