import 'package:app_ecomerce/features/products/data/models/product_model.dart';
import 'package:app_ecomerce/features/products/domain/entities/product.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';



abstract class ProductsRemoteDataSource {
  Future<List<ProductModel>> getProducts();
  Future<String> uploadImage(XFile image, String token);
  Future<Product> createProduct(Product product, String token);
  Future<Product> updateProduct(int productId, Product product, String token);
  Future<String> updateProductImage(int productId, XFile image, String token);
  Future<void> deleteProduct(int productId, String token);
}

class ProductRemoteDataSourceImpl implements ProductsRemoteDataSource {
  final http.Client client;
  final String baseUrl;

  ProductRemoteDataSourceImpl({required this.client, required this.baseUrl});

  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await client.get(Uri.parse("$baseUrl/products/"));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => ProductModel.fromJson(e)).toList();
    }else{
      throw Exception("Error al obtener productos: ${response.statusCode}");
    }
  }


  @override
  Future<String> uploadImage(XFile image, String token) async {
    final url = Uri.parse("$baseUrl/products/upload-image");
    final request = http.MultipartRequest("POST", url,);
    request.headers["Authorization"] = "Bearer $token";

    // Detectar tipo MIME
    final mimeType = image.mimeType ?? "image/jpeg";
    final mimeParts = mimeType.split("/");
    request.files.add(
      await http.MultipartFile.fromPath('file', image.path, contentType: MediaType(mimeParts[0], mimeType[1])),
    );

    final streamd = await request.send();
    final response = await http.Response.fromStream(streamd);

    if(response.statusCode == 200){
      final data = await jsonDecode(response.body);
      return data["image_url"];
    }else{
      throw Exception("Error al subir imagen: ${response.statusCode}");
    }
  }


  @override
  Future<ProductModel> createProduct(Product product, String token) async{
    // TODO: implement createProduct
    final url = Uri.parse("$baseUrl/products/");

    final productModel = ProductModel(
        nombre: product.nombre,
        descripcion: product.descripcion,
        precio: product.precio,
        stock: product.stock,
        isActive: product.isActive,
        imagen: product.imagen,
        category: product.category,
    );

    final response = await client.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(productModel.toJson())
    );

    if(response.statusCode == 201){
      return ProductModel.fromJson(jsonDecode(response.body));

    }else{
      throw Exception("Error al crear producto: ${response.statusCode}");
    }

  }

  /// ***** Actualizar producto ***********

  @override
  Future<Product> updateProduct(int productId, Product product, String token) async {
    final url = Uri.parse("$baseUrl/products/$productId");

    final productModel = ProductModel(
        nombre: product.nombre,
        descripcion: product.descripcion,
        precio: product.precio,
        stock: product.stock,
        isActive: product.isActive,
        imagen: product.imagen,
        category: product.category,
    );

    final response = await client.put(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(productModel.toJson())
    );

    if(response.statusCode == 200){
      return ProductModel.fromJson(jsonDecode(response.body));
    }else{
      throw Exception("Error al actualizar producto: ${response.statusCode}");
    }
  }

  @override
  Future<String> updateProductImage(int productId, XFile image, String token) async {
    final url = Uri.parse("$baseUrl/products/$productId/update-image");
    final request = http.MultipartRequest("PUT", url);
    request.headers["Authorization"] = "Bearer $token";

    // Detectar tipo MIME
    final mimeType = image.mimeType ?? "image/jpeg";
    final mimeParts = mimeType.split("/");
    request.files.add(
      await http.MultipartFile.fromPath('file', image.path, contentType: MediaType(mimeParts[0], mimeParts[1])),
    );

    final streamed = await request.send();
    final response = await http.Response.fromStream(streamed);

    if(response.statusCode == 200){
      final data = await jsonDecode(response.body);
      return data["image_url"];
    }else{
      throw Exception("Error al actualizar imagen del producto: ${response.statusCode}");
    }
  }


  @override
  Future<void> deleteProduct(int productId, String token) async{
    final url = Uri.parse("$baseUrl/products/$productId");
    final response = await client.delete(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      }
    );

    if(response.statusCode != 204){
      throw Exception("Error al eliminar producto: ${response.statusCode}");
    }
  }
}
