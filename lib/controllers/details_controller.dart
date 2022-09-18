import 'package:dio/dio.dart';
import '../model/movie.dart';

class DetailsController {
  Future<Movie> getFilme(int id) async {
    Movie movie = Movie();

    try {
      var response = await Dio().get(
          'https://desafio-mobile.nyc3.digitaloceanspaces.com/movies-v2/$id');

      movie = Movie().fromJSON(response.data);
      await Future.delayed(const Duration(seconds: 1));
      return movie;
    } catch (e) {
      print(e);
    }
    // final String response =
    //     await rootBundle.loadString('assets/singleData.json');
    // final data = await json.decode(response);
    return movie;
  }
}
