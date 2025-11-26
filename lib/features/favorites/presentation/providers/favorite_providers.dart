import 'package:app_ecomerce/features/favorites/domain/entities/favorites.dart';
import 'package:flutter_riverpod/legacy.dart';

class FavoriteProviders extends StateNotifier<List<Favorites>> {
  FavoriteProviders(): super([]);

  void addFavorite(Favorites favorite) {
    final exists = state.any((item) => item.product.id == favorite.product.id);
    if (!exists) {
      state = [...state, favorite];
    }
  }

  void removeFavorite(dynamic productId) {
    state = state.where((item) => item.product.id != productId).toList();
  }

  void toggleFavorite(dynamic productId) {
    final index = state.indexWhere((item) => item.product.id == productId);
    if (index != -1) {
      final item = state[index];
      final updated = Favorites(product: item.product, isFavorite: !item.isFavorite);
      state = [
        ...state.sublist(0, index),
        updated,
        ...state.sublist(index + 1),
      ];
    }
  }

  bool isFavorite(dynamic productId) {
    final fav = state.firstWhere(
      (item) => item.product.id == productId,
      orElse: () => Favorites(product: null as dynamic, isFavorite: false),
    );
    return fav.isFavorite;
  }


}


final favoriteProviders = StateNotifierProvider<FavoriteProviders, List<Favorites>>(
  (ref) => FavoriteProviders(),
  );