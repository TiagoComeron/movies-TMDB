import 'package:dio/dio.dart';
import '../model/movie.dart';

class HomeController {
  Future<List<Movie>> getFilmes() async {
    List<Movie> movies = [];

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
}
