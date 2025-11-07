import 'package:app_ecomerce/features/products/data/models/product_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;



abstract class ProductsRemoteDataSource {
  Future<List<ProductModel>> getProducts();
}

class ProductRemoteDataSourceImpl implements ProductsRemoteDataSource {
  final http.Client client;
  final String baseUrl;

  ProductRemoteDataSourceImpl({required this.client, required this.baseUrl});

  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await client.get(Uri.parse('$baseUrl/products'));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => ProductModel.fromJson(e)).toList();
    }else{
      throw Exception("Error al obtener productos: ${response.statusCode}");
    }
  }
}
