class MovieData {
  bool watched;
  String title;
  double rating;
  String releaseDate;
  String review;

  MovieData(
    this.watched,
    this.title,
    this.rating,
    this.releaseDate,
    this.review,
  );

  factory MovieData.fromMap(Map<String, dynamic> map) => MovieData(
        map["watched"],
        map["title"],
        map["rating"],
        map["release_date"],
        map["review"],
      );
}

class Movie {
  int pk;
  MovieData fields;

  Movie({
    required this.pk,
    required this.fields,
  });

  factory Movie.fromMap(Map<String, dynamic> map) => Movie(
        pk: map["pk"],
        fields: MovieData.fromMap(map["fields"]),
      );
}
