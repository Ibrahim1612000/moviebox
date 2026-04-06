import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/movie.dart';

class FavoritesNotifier extends Notifier<List<Movie>> {
  @override
  List<Movie> build() {
    _loadFavorites();
    return [];
  }

  static const _favoritesKey = 'favorite_movies';

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String? favoritesJson = prefs.getString(_favoritesKey);
    
    if (favoritesJson != null) {
      final List<dynamic> decodedList = json.decode(favoritesJson);
      state = decodedList.map((item) => Movie.fromJson(item)).toList();
    }
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedList = json.encode(state.map((e) => e.toJson()).toList());
    await prefs.setString(_favoritesKey, encodedList);
  }

  void toggleFavorite(Movie movie) {
    if (isFavorite(movie.imdbID)) {
      state = state.where((m) => m.imdbID != movie.imdbID).toList();
    } else {
      state = [...state, movie];
    }
    _saveFavorites();
  }

  bool isFavorite(String imdbID) {
    return state.any((m) => m.imdbID == imdbID);
  }
}

final favoritesProvider = NotifierProvider<FavoritesNotifier, List<Movie>>(() {
  return FavoritesNotifier();
});
