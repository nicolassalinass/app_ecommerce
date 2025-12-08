import 'package:app_ecomerce/features/products/domain/entities/product.dart';

class ProductModel extends Product {

  ProductModel({
    super.id,
    required super.nombre,
    required super.descripcion,
    required super.precio,
    required super.stock,
    required super.isActive,
    required super.imagen,
    required super.category,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json){
    return ProductModel(
      id: json["id"],
      nombre: json["name"],
      descripcion: json["description"],
      precio: json["price"],
      stock: json["stock"],
      isActive: json["is_active"] ?? true,
      imagen: json["image"] ?? "",
      category: json["category"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "name": nombre,
    "description": descripcion,
    "price": precio,
    "stock": stock,
    "is_active": isActive,
    "image": imagen,
    "category": category,
  };

}