class Movie {
  final int id;
  final String title;
  final String description;
  final String posterUrl;
  final int duration;
  final String releaseDate;

  Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.posterUrl,
    required this.duration,
    required this.releaseDate,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      posterUrl: json['poster_url'],
      duration: json['duration'],
      releaseDate: json['release_date'],
    );
  }
}