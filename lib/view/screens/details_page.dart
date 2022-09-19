import 'package:flutter/material.dart';
import 'package:movies_tmdb/model/movie.dart';
import 'package:movies_tmdb/view/widgets/card_details.dart';
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
  List<Movie> relatedMovies = [];

  void getRelatedMovies(genres, id) async {
    relatedMovies = await controller.getRelatedMovies(genres, id);
    setState(() {});
  }

  void getMovie() async {
    movie = await controller.getMovie(widget.id);

    getRelatedMovies(movie!.getGenres, movie!.getId);

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getMovie();
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
                      errorBuilder: (context, exception, stackTrace) {
                        return Image.asset("imgs/transparent.png");
                      },
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                //3
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: CardDetails(movie: movie),
                      ),
                      Column(
                        children: [
                          const Text(
                            "Related movies",
                            style: TextStyle(fontSize: 20),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 400,
                                  child: GridView.count(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 24,
                                    crossAxisSpacing: 24,
                                    childAspectRatio: 0.5,
                                    children: relatedMovies
                                        .map((Movie movie) => GestureDetector(
                                            onTap: () => {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailsPage(
                                                              id: int.parse(movie
                                                                  .id
                                                                  .toString())),
                                                    ),
                                                  )
                                                },
                                            child: CardMovie(
                                              title: movie.getTitle,
                                              posterUrl: movie.getPosterUrl,
                                              voteAverage: movie.getVoteAverage,
                                              genres: movie.getGenres,
                                              onlyTitle: true,
                                            )))
                                        .toList(),
                                  ),
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
