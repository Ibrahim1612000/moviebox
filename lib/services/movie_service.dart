import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../core/api/api_constants.dart';
import '../models/movie.dart';
import '../models/movie_details.dart';

class MovieService {
  final http.Client _client = http.Client();

  Future<List<Movie>> searchMovies(String query) async {
    try {
      final response = await _client
          .get(Uri.parse(ApiConstants.searchMovies(query)))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['Response'] == 'True') {
          final List<dynamic> results = data['Search'];
          return results.map((json) => Movie.fromJson(json)).toList();
        } else {
          throw Exception(data['Error'] ?? 'Failed to load movies');
        }
      } else {
        throw Exception('Failed to load movies. Status code: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }

  Future<List<Movie>> searchSeries(String query) async {
    try {
      final response = await _client
          .get(Uri.parse(ApiConstants.searchSeries(query)))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['Response'] == 'True') {
          final List<dynamic> results = data['Search'];
          return results.map((json) => Movie.fromJson(json)).toList();
        } else {
          throw Exception(data['Error'] ?? 'Failed to load series');
        }
      } else {
        throw Exception('Failed to load series. Status code: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }

  Future<MovieDetails> getMovieDetails(String imdbID) async {
    try {
      final response = await _client
          .get(Uri.parse(ApiConstants.getMovieDetails(imdbID)))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['Response'] == 'True') {
          return MovieDetails.fromJson(data);
        } else {
          throw Exception(data['Error'] ?? 'Failed to load movie details');
        }
      } else {
        throw Exception('Failed to load movie details. Status: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }
}
