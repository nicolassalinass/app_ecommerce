import 'package:app_ecomerce/features/products/data/models/product_model.dart';
import 'package:app_ecomerce/features/cart/domain/entities/cart.dart';

class CartModel extends Cart {
    CartModel({
        required super.id,
        required super.items,
    });

    factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json["id"],
        items: List<ItemModel>.from(json["items"].map((x) => ItemModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "items": List<dynamic>.from(items.map((x) => (x as ItemModel).toJson())),
    };
}

class ItemModel extends Item {
    ItemModel({
        super.id,
        required ProductModel product,
        required super.quantity,
    }) : super(product: product);

    factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        id: json["id"],
        product: ProductModel.fromJson(json["product"]),
        quantity: json["quantity"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product": (product as ProductModel).toJson(),
        "quantity": quantity,
    };
}

// class Product {
//     String name;
//     String description;
//     int price;
//     int stock;
//     bool isActive;
//     String image;
//     String category;
//     int id;
//     DateTime createdAt;

//     Product({
//         required this.name,
//         required this.description,
//         required this.price,
//         required this.stock,
//         required this.isActive,
//         required this.image,
//         required this.category,
//         required this.id,
//         required this.createdAt,
//     });

//     factory Product.fromJson(Map<String, dynamic> json) => Product(
//         name: json["name"],
//         description: json["description"],
//         price: json["price"],
//         stock: json["stock"],
//         isActive: json["is_active"],
//         image: json["image"],
//         category: json["category"],
//         id: json["id"],
//         createdAt: DateTime.parse(json["created_at"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "name": name,
//         "description": description,
//         "price": price,
//         "stock": stock,
//         "is_active": isActive,
//         "image": image,
//         "category": category,
//         "id": id,
//         "created_at": createdAt.toIso8601String(),
//     };
// }
