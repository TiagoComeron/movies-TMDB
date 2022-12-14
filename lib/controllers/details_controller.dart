import 'package:dio/dio.dart';
import '../model/movie.dart';

class DetailsController {
  Future<Movie> getMovie(int id) async {
    Movie movie = Movie();

    try {
      var response = await Dio().get(
          'https://desafio-mobile.nyc3.digitaloceanspaces.com/movies-v2/$id');

      movie = Movie().fromJSON(response.data);
    } catch (e) {
      return movie;
    }
    return movie;
  }

  Future<List<Movie>> getRelatedMovies(List<String> genres, int id) async {
    List<Movie> relatedMovies = [];

    try {
      var response = await Dio()
          .get('https://desafio-mobile.nyc3.digitaloceanspaces.com/movies-v2');

      for (var item in response.data) {
        relatedMovies.add(Movie().fromJSON(item));
      }

      relatedMovies = relatedMovies.where((element) {
        for (var genre in element.getGenres) {
          for (var genresFilter in genres) {
            if ((genresFilter.toString().toLowerCase() ==
                    genre.toLowerCase()) &&
                element.id != id) {
              return true;
            }
          }
        }
        return false;
      }).toList();
    } catch (e) {
      return relatedMovies = [];
    }

    return relatedMovies;
  }
}
