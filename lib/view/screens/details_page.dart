import 'package:flutter/material.dart';
import 'package:movies_tmdb/model/movie.dart';
import 'package:movies_tmdb/view/widgets/card_movie.dart';

import '../../controllers/details_controller.dart';

class DetailsPage extends StatefulWidget {
  final int id;
  const DetailsPage({Key? key, required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DetailsPage();
}

class _DetailsPage extends State<DetailsPage> {
  DetailsController controller = DetailsController();
  bool loading = true;

  Movie? movie;
  void getFilme() async {
    movie = await controller.getFilme(widget.id);
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getFilme();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Scaffold(
            body: Container(
              color: const Color.fromRGBO(33, 30, 61, 1),
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
          )
        : Scaffold(
            backgroundColor: const Color.fromRGBO(33, 30, 61, 1),
            body: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: 250.0,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                      movie!.getBackdropUrl,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return const SizedBox(
                            height: 200,
                            child: Center(child: Text('Image not found...')));
                      },
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                //3
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 400,
                            width: 200,
                            child: CardMovie(
                                title: movie!.getTitle,
                                posterUrl: movie!.getPosterUrl,
                                voteAverage: movie!.getVoteAverage,
                                genres: movie!.getGenres),
                          ),
                          Center(child: Text(movie!.title.toString()))
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              movie!.getTagline.toString(),
                              style: const TextStyle(
                                  letterSpacing: 2,
                                  color: Colors.grey,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              movie!.getOverview.toString(),
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                  letterSpacing: 2,
                                  color: Colors.grey,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Released: ${movie!.getReleaseDate.year}",
                                      textAlign: TextAlign.justify,
                                      style: const TextStyle(
                                          letterSpacing: 2,
                                          color: Colors.grey,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ])),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Runtime: ${movie!.getRuntime}",
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                      letterSpacing: 2,
                                      color: Colors.grey,
                                      fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
