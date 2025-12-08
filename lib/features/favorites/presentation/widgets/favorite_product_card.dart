import 'package:app_ecomerce/core/utils/currency_formatter.dart';
import 'package:app_ecomerce/features/cart/presentation/provider/cart_provider.dart';
import 'package:app_ecomerce/features/favorites/domain/entities/favorites.dart';
import 'package:app_ecomerce/features/favorites/presentation/providers/favorite_providers.dart';
import 'package:app_ecomerce/features/products/presentation/detail_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteProductCard extends ConsumerWidget {
  final Favorites favorite;

  const FavoriteProductCard({super.key, required this.favorite});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                DetailProductScreen(product: favorite.product),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0, bottom: 8.0),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            // border: Border.all(color: Colors.grey.shade500, width: 0.3),
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            borderRadius: BorderRadius.circular(10),
          ),
          height: screenHeight * 0.135,
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  favorite.product.imagen,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset("assets/image-not-found.png");
                  },
                  height: screenHeight * 0.12,
                  width: screenWidth * 0.35,
                  fit: BoxFit.contain,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        favorite.product.nombre,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        CurrencyFormatter.guaraniFormat(favorite.product.precio),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            ref
                                .read(cartProvider.notifier)
                                .addProduct(favorite.product);
                            final snackBar = SnackBar(
                              content: Text(
                                '${favorite.product.nombre} agregado al carrito.',
                              ),
                              duration: const Duration(seconds: 1),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          icon: const Icon(Icons.shopping_cart, size: 18),
                          label: const Text("Agregar"),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 12,
                            ),
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            foregroundColor: Colors.white
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  ref
                      .read(favoriteProviders.notifier)
                      .removeFavorite(favorite.product.id);
                  final snackBar = SnackBar(
                    content: Text(
                      '${favorite.product.nombre} eliminado de favoritos.',
                    ),
                    duration: const Duration(seconds: 1),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 28,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
