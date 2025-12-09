import 'package:app_ecomerce/features/products/domain/entities/product.dart';

// class Cart {
//   final Product product;
//   final int cantidad;

//   Cart({required this.product, int? cantidad}) : cantidad = cantidad ?? 1;

//   double get totalPrice => product.precio * cantidad;

//   Cart copyWith({Product? product, int? cantidad}) {
//     return Cart(
//       product: product ?? this.product,
//       cantidad: cantidad ?? this.cantidad,
//     );
//   }
// }

class  Cart{
    int id;
    List<Item> items;

    Cart({
        required this.id,
        required this.items,
    });
}

class Item {
    int? id;
    Product product;
    int quantity;

    Item({
        this.id,
        required this.product,
        required this.quantity,
    });
}

