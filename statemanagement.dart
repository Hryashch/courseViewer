import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesNotifier extends StateNotifier<List<int>> {
  FavoritesNotifier() : super([]) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList('favorite_courses')?.map(int.parse).toList() ?? [];
    state = favorites;
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorite_courses', state.map((id) => id.toString()).toList());
  }

  void toggleFavorite(int courseId) {
    if (state.contains(courseId)) {
      state = state.where((id) => id != courseId).toList();
    } else {
      state = [...state, courseId];
    }
    _saveFavorites(); 
  }

  bool isFavorite(int courseId) {
    return state.contains(courseId);
  }
}

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, List<int>>((ref) {
  return FavoritesNotifier();
});
