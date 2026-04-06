class ApiConstants {
  static const String baseUrl = 'https://www.omdbapi.com/';
  static const String apiKey = '8d1f61dc';

  static String searchMovies(String query) {
    return '$baseUrl?s=$query&type=movie&apikey=$apiKey';
  }

  static String searchSeries(String query) {
    return '$baseUrl?s=$query&type=series&apikey=$apiKey';
  }

  static String getMovieDetails(String id) {
    return '$baseUrl?i=$id&plot=full&apikey=$apiKey';
  }
}
