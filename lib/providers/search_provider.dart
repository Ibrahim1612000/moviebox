import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/movie.dart';
import 'movie_provider.dart';

class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  void updateQuery(String query) => state = query;
}

final searchQueryProvider = NotifierProvider<SearchQueryNotifier, String>(() {
  return SearchQueryNotifier();
});

final searchResultsProvider = FutureProvider<List<Movie>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query.isEmpty) {
    return [];
  }
  
  final service = ref.read(movieServiceProvider);
  return service.searchMovies(query);
});
