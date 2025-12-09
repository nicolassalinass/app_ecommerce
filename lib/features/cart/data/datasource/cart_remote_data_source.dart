import 'package:app_ecomerce/features/cart/data/model/cart_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class CartRemoteDataSource {
  Future<CartModel> getCart(String token);
  Future<CartModel> addToCart(int productId, int quantity, String token);
  Future<void> removeCartItem(int productId, String token);
  Future<void> clearCart(String token);
  Future<ItemModel> updateQuantity(int itemId, int newQuantity, String token);

}

class CartRemoteDataSourceImpl implements CartRemoteDataSource{
  final http.Client client;
  final String baseUrl;

  CartRemoteDataSourceImpl({required this.client, required this.baseUrl});

  @override
  Future<CartModel> getCart(String token) async {

    final url = Uri.parse("$baseUrl/cart");

    final reponse = await client.get(
      url,
      headers: {
        'Content-Type': 'application/json', 
        'Authorization': 'Bearer $token'
      },
    );

    if(reponse.statusCode == 200){
      return CartModel.fromJson(json.decode(reponse.body));
    } else {
      throw Exception("Error al obtener el carrito");
    }
  }

  @override
  Future<CartModel> addToCart(int productId, int quantity, String token) async {

    final url = Uri.parse("$baseUrl/cart/add");

    try {
      final response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encode({
          'product_id': productId,
          'quantity': quantity,
        }),
      );

      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return CartModel.fromJson(data);
      } else {
        throw Exception("Error al agregar producto al carrito: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print('Error en addToCart: $e');
      throw Exception("Error al agregar producto al carrito: $e");
    }
  }

  @override
  Future<void> removeCartItem(int itemId, String token) async {
    final url = Uri.parse("$baseUrl/cart/item/$itemId");

    final response = await client.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception(
          "Error al eliminar producto del carrito: ${response.statusCode} - ${response.body}");
    }
  }


  @override
  Future<void> clearCart(String token) async {
    final url = Uri.parse("$baseUrl/cart/clear");

    final response = await client.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception("Error al limpiar el carrito");
    }
  }


  // @override
  // Future<ItemModel> updateQuantity(int itemId, int newQuantity, String token) async {
  //   final url = Uri.parse("$baseUrl/cart/item/$itemId/quantity?new_quantity=$newQuantity");
  //
  //   final response = await client.put(
  //     url,
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token',
  //     },
  //   );
  //
  //   if (response.statusCode == 200) {
  //     return ItemModel.fromJson(jsonDecode(response.body));
  //   } else if (response.statusCode == 404) {
  //     throw Exception("Item not found");
  //   } else {
  //     throw Exception("Error al actualizar cantidad: ${response.statusCode}");
  //   }
  // }

  @override
  Future<ItemModel> updateQuantity(int itemId, int newQuantity, String token) async {
    final url = Uri.parse("$baseUrl/cart/item/$itemId/quantity?new_quantity=$newQuantity");

    final response = await client.put(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      return ItemModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      throw Exception("Item not found");
    } else {
      throw Exception("Error actualizando cantidad: ${response.statusCode}");
    }
  }



}