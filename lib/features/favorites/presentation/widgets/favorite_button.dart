import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_ecomerce/features/products/domain/entities/product.dart';
import 'package:app_ecomerce/features/favorites/domain/entities/favorites.dart';
import 'package:app_ecomerce/features/favorites/presentation/providers/favorite_providers.dart';

class FavoriteButton extends ConsumerWidget {
  final Product product;

  const FavoriteButton({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoriteProviders);
    final isFav = favorites.any((item) => item.product.id == product.id);

    return IconButton(
      icon: Icon(
        isFav ? Icons.favorite : Icons.favorite_border,
        color: isFav ? Colors.red : Colors.grey,
      ),
      onPressed: () {
        if (isFav) {
          ref.read(favoriteProviders.notifier).removeFavorite(product.id);
        } else {
          final newFavorite = Favorites(product: product, isFavorite: true);
          ref.read(favoriteProviders.notifier).addFavorite(newFavorite);
        }
      },
    );
  }
}
