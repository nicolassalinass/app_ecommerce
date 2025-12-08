import 'package:app_ecomerce/core/errors/exceptions.dart';
import 'package:app_ecomerce/features/products/data/datasources/products_remote_data_source.dart';
import 'package:app_ecomerce/features/products/domain/entities/product.dart';
import 'package:app_ecomerce/features/products/domain/repositories/product_repository.dart';
import 'package:image_picker/image_picker.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductsRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Product>> getProducts() async {
    try{
      return await remoteDataSource.getProducts();
    }on ServerException catch (e){
      throw Exception(e.message);
    }
  }

  @override
  Future<Product> createProduct(Product product, String token) async {
    try{
      return await remoteDataSource.createProduct(product, token);
    }catch (e){
      throw Exception(e.toString());
    }
  }


  @override
  Future<String> uploadImage(XFile image, String token) async {
    try{
      return await remoteDataSource.uploadImage(image, token);
    }on ServerException catch (e){
      throw Exception(e.message);
    }
  }

  @override
  Future<Product> updateProduct(int productId, Product product, String token) async {
    try{
      return await remoteDataSource.updateProduct(productId, product, token);
    }catch (e){
      throw Exception(e.toString());
    }
  }

  @override
  Future<String> updateProductImage(int productId, XFile image, String token) async {
    try{
      return await remoteDataSource.updateProductImage(productId, image, token);
    }on ServerException catch (e){
      throw Exception(e.message);
    }
  }


  @override
  Future<void> deleteProduct(int productId, String token) async{
    try{
      return await remoteDataSource.deleteProduct(productId, token);
    }on ServerException catch (e){
      throw Exception(e.message);
    }
  }

}