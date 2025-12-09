// import 'package:app_ecomerce/features/cart/domain/entities/cart.dart';
// import 'package:app_ecomerce/features/products/domain/entities/product.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_riverpod/legacy.dart';


// class CartProvider extends StateNotifier<List<Cart>> {
//   CartProvider() : super([]);

//   /// Agregar producto al carrito
//   void addProduct(Product product) {
//     final index = state.indexWhere((item) => item.product.id == product.id);

//     if (index != -1) {
//       final updatedItem = state[index].copyWith(
//         cantidad: state[index].cantidad + 1,
//       );

//       final newList = [...state];
//       newList[index] = updatedItem;

//       state = newList;
//     } else {
//       state = [...state, Cart(product: product, cantidad: 1)];
//     }
//   }

//   /// Disminuir cantidad
//   void decreaseProduct(Product product) {
//     final index = state.indexWhere((item) => item.product.id == product.id);
//     if (index == -1) return;

//     if (state[index].cantidad > 1) {
//       final updatedItem = state[index].copyWith(
//         cantidad: state[index].cantidad - 1,
//       );

//       final newList = [...state];
//       newList[index] = updatedItem;

//       state = newList;
//     } else {
//       final updateitem = state[index].copyWith(cantidad: 1);
//       final newList = [...state];
//       newList[index] = updateitem;
//     }
//   }


//   /// Eliminar producto
//   void removeProduct(Product product) {
//     state = state.where((item) => item.product.id != product.id).toList();
//   }

//   /// Limpiar carrito
//   void clear() => state = [];

//   /// Total general
//   double get total => state.fold(
//         0,
//         (sum, item) => sum + item.totalPrice,
//       );
// }

// final cartProvider =
//     StateNotifierProvider<CartProvider, List<Cart>>((ref) {
//   return CartProvider();
// });
