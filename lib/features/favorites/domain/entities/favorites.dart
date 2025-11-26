import 'package:app_ecomerce/features/products/domain/entities/product.dart';

class Favorites {

  final Product product;
  final bool isFavorite;

  Favorites({required this.product, required this.isFavorite}); 
}