import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/movie.dart';
import '../models/movie_details.dart';
import '../services/movie_service.dart';

final movieServiceProvider = Provider<MovieService>((ref) {
  return MovieService();
});

// Featured Movies (e.g. Marvel)
final featuredMoviesProvider = FutureProvider<List<Movie>>((ref) async {
  final service = ref.read(movieServiceProvider);
  return service.searchMovies('Marvel');
});

// Popular Movies (e.g. Avengers)
final popularMoviesProvider = FutureProvider<List<Movie>>((ref) async {
  final service = ref.read(movieServiceProvider);
  return service.searchMovies('Avengers');
});

// Latest Movies (e.g. 2024 query)
final latestMoviesProvider = FutureProvider<List<Movie>>((ref) async {
  final service = ref.read(movieServiceProvider);
  return service.searchMovies('2024');
});

// TV Series (e.g. Game of Thrones)
final seriesProvider = FutureProvider<List<Movie>>((ref) async {
  final service = ref.read(movieServiceProvider);
  return service.searchSeries('Game of Thrones');
});

// Movie Details Family
final movieDetailsProvider = FutureProvider.family<MovieDetails, String>((ref, id) async {
  final service = ref.read(movieServiceProvider);
  return service.getMovieDetails(id);
});
