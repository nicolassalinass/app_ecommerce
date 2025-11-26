import 'package:app_ecomerce/features/favorites/presentation/providers/favorite_providers.dart';
import 'package:app_ecomerce/features/favorites/presentation/widgets/favorite_product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteItems = ref.watch(favoriteProviders);

    return Scaffold(
      body: SafeArea(
        child: favoriteItems.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 80,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "No tienes favoritos aún",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Agrega productos a tu lista de favoritos",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: favoriteItems.length,
                itemBuilder: (context, index) {
                  final favorite = favoriteItems[index];
                  return FavoriteProductCard(favorite: favorite);
                },
              ),
      ),
    );
  }
}