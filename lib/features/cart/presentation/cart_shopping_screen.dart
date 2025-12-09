import 'package:app_ecomerce/core/utils/currency_formatter.dart';
import 'package:app_ecomerce/features/cart/presentation/card_product_cart.dart';
import 'package:app_ecomerce/features/cart/presentation/provider/cart_remote_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartShoppingScreen extends ConsumerWidget {
  const CartShoppingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Obtener estados del carrito
    final cartAsync = ref.watch(cartRemoteNotifierProvider);

    return Scaffold(
      body: SafeArea(
        child: cartAsync.when(
          data: (cart) {
            if (cart == null || cart.items.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 100,
                      color: Colors.grey.shade400,
                    ),
                    SizedBox(height: 16),
                    Text(
                      "El carrito está vacío",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              );
            }

            final total = cart.items.fold<double>(
              0.0,
              (sum, item) => sum + (item.product.precio * item.quantity),
            );

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];
                      return CardProductCart(cartItem: item);
                    },
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                          color: Colors.grey.shade800, width: 0.4)),
                  ),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, left: 16.0, right: 16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Subotal:",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              CurrencyFormatter.guaraniFormat(total),
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Envio:",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "Gratis",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total:",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              CurrencyFormatter.guaraniFormat(total),
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                Divider(
                  thickness: 0.1,
                  color: Colors.grey.shade800,
                ),

                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, top: 8.0, bottom: 6),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        elevation: 10,
                        shadowColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                      child: Text(
                        "Proceder al Pago",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
          loading: () => Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.red.shade300,
                ),
                SizedBox(height: 16),
                Text(
                  'Error al cargar el carrito',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                TextButton.icon(
                  onPressed: () {
                    ref.read(cartRemoteNotifierProvider.notifier).refresh();
                  },
                  icon: Icon(Icons.refresh),
                  label: Text('Reintentar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}