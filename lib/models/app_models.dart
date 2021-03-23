class Movies {
  final String name;
  final String movieUrl;
  final String imageUrl;
  final double imdb;
  final String plot;
  final String subtitleUrl;
  final String releaseDate;
  final String genre;

  Movies.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        movieUrl = json['movieUrl'],
        imageUrl = json['imageUrl'],
        imdb = json['imdb'],
        plot = json['plot'],
        subtitleUrl = json['subtitleUrl'],
        releaseDate = json['releaseDate'],
        genre = json['genre'];
}
