import 'package:app_ecomerce/core/errors/exceptions.dart';
import 'package:app_ecomerce/features/products/data/datasources/products_remote_data_source.dart';
import 'package:app_ecomerce/features/products/domain/entities/product.dart';
import 'package:app_ecomerce/features/products/domain/repositories/product_repository.dart';

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
}