import 'package:dio/dio.dart';
import '../model/movie.dart';

class HomeController {
  List<Movie> movies = [];

  Future<List<Movie>> getMovies() async {
    try {
      var response = await Dio()
          .get('https://desafio-mobile.nyc3.digitaloceanspaces.com/movies-v2');

      for (var item in response.data) {
        movies.add(Movie().fromJSON(item));
      }
    } catch (e) {
      return movies = [];
    }

    return movies;
  }

  List<Movie> movieFilters(List<dynamic> parameters) {
    List<Movie> newList = [];
    int rangeStart = parameters[1]?.start.round();
    int rangeEnd = parameters[1]?.end.round();

    newList = movies
        .where(
          (element) => parameters.first.toString().isEmpty
              ? true
              : element.getTitle
                  .toLowerCase()
                  .contains(parameters.first.toString().toLowerCase()),
        )
        .where((element) =>
            rangeStart <= element.getReleaseDate.year &&
            element.getReleaseDate.year <= rangeEnd)
        .where((element) {
      if (parameters.last.isEmpty) return true;

      for (var genre in element.getGenres) {
        for (var genresFilter in parameters.last) {
          if (genresFilter.toString().toLowerCase() == genre.toLowerCase()) {
            return true;
          }
        }
      }
      return false;
    }).toList();

    return newList;
  }
}
