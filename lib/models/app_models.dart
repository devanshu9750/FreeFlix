class Movies {
  final String name;
  final String movieurl;
  final String imageurl;
  final double imdb;
  final String plot;
  final String subtitleurl;
  final String releasedate;
  final String genre;

  Movies.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        movieurl = json['movieurl'],
        imageurl = json['imageurl'],
        imdb = json['imdb'],
        plot = json['plot'],
        subtitleurl = json['subtitleurl'],
        releasedate = json['releasedate'],
        genre = json['genre'];
}
