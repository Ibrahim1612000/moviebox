class Movie {
  final String title;
  final String year;
  final String imdbID;
  final String type;
  final String poster;

  Movie({
    required this.title,
    required this.year,
    required this.imdbID,
    required this.type,
    required this.poster,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['Title'] ?? 'Unknown',
      year: json['Year'] ?? 'Unknown',
      imdbID: json['imdbID'] ?? '',
      type: json['Type'] ?? 'Unknown',
      poster: json['Poster'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Title': title,
      'Year': year,
      'imdbID': imdbID,
      'Type': type,
      'Poster': poster,
    };
  }
}
