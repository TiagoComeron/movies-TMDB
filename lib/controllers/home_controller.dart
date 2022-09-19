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
      print(e);
    }
    // final String response = await rootBundle.loadString('assets/data.json');

    return movies;
  }

  List<Movie> movieFilters(List<dynamic> parameters) {
    List<Movie> newList = [];

    newList = movies
        .where(
          (element) => parameters.first.toString().isEmpty
              ? true
              : element.getTitle
                  .toLowerCase()
                  .contains(parameters.first.toString().toLowerCase()),
        )
        .where((element) =>
            parameters[1].start.round() <= element.getReleaseDate.year &&
            element.getReleaseDate.year <= parameters[1].end.round())
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

    print(parameters);
    return newList;
  }
}
