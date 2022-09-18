class Movie {
  final int? id;
  final String? title;
  final String? overview;
  final String? tagline;
  final String? posterUrl;
  final String? backdropUrl;
  final double? voteAverage;
  final int? runtime;
  List<String>? genres;
  final DateTime? releaseDate;

  get getId => id;

  get getTitle => title;

  get getOverview => overview;

  get getTagline => tagline;

  get getPosterUrl => posterUrl;

  get getBackdropUrl => backdropUrl;

  get getVoteAverage => voteAverage;

  get getRuntime => runtime;

  get getGenres => genres;

  get getReleaseDate => releaseDate;

  Movie(
      {this.id,
      this.title,
      this.overview,
      this.tagline,
      this.posterUrl,
      this.voteAverage,
      this.runtime,
      this.backdropUrl,
      this.genres,
      this.releaseDate});

  Movie fromJSON(dynamic json) {
    List<dynamic> genreList = json['genres'];
    return Movie(
        id: json['id'],
        title: json['title'],
        posterUrl: json['poster_url'],
        voteAverage: json['vote_average'],
        releaseDate: DateTime.parse(json['release_date']),
        tagline: json['tagline'],
        overview: json['overview'],
        runtime: json['runtime'],
        backdropUrl: json['backdrop_url'],
        genres: genreList.map((e) => e.toString()).toList());
  }
}
