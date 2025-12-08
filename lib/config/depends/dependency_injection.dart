import 'package:app_ecomerce/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:app_ecomerce/features/auth/data/repositories/login_repository_impl.dart';
import 'package:app_ecomerce/features/auth/domain/repositories/auth_repository.dart';
import 'package:app_ecomerce/features/auth/domain/usecases/login_user.dart';
import 'package:app_ecomerce/features/products/data/datasources/products_remote_data_source.dart';
import 'package:app_ecomerce/features/products/data/repositories/product_repository_impl.dart';
import 'package:app_ecomerce/features/products/domain/repositories/product_repository.dart';
import 'package:app_ecomerce/features/products/domain/usecases/get_products.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async{

  // Cliente Http
  sl.registerLazySingleton(() => http.Client());

  // DataSource
  sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(client: sl(), baseUrl: "http://192.168.0.160:8000"),
  );

  //Repository
  sl.registerLazySingleton<AuthRepository>(
        () => LoginRepositoryImpl(remoteDataSource: sl<AuthRemoteDataSource>()),
  );

  //Usecase
  sl.registerLazySingleton<LoginUser>(
        () => LoginUser(sl<AuthRepository>()),
  );

  /********************* PRODUCTOS *********************/
  // DataSource
  sl.registerLazySingleton<ProductsRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(
      client: sl(), 
      baseUrl: "http://10.0.2.2:8080/api"),
  );

  // Registrar usando la interfaz explícita
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(remoteDataSource: sl<ProductsRemoteDataSource>()),
  );

  sl.registerLazySingleton<GetProducts>(
    () => GetProducts(sl<ProductRepository>()),
  );

}

