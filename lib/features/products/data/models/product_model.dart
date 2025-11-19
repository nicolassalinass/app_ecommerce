import 'package:app_ecomerce/features/products/domain/entities/product.dart';

class ProductModel extends Product {

  ProductModel({
    required super.id,
    required super.nombre,
    required super.descripcion,
    required super.precio,
    required super.imagen,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json){
    return ProductModel(
      id: json['id'], 
      nombre: json['nombre'], 
      descripcion: json['descripcion'], 
      precio: (json['precio'])?.toDouble()?? 0.0, 
      imagen: json['imagenes']
    );

  }

}