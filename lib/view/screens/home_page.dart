import 'package:flutter/material.dart';
import 'package:movies_tmdb/controllers/home_controller.dart';
import 'package:movies_tmdb/model/movie.dart';
import 'package:movies_tmdb/view/screens/details_page.dart';

import '../widgets/card_movie.dart';
import '../widgets/search_modal.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeStatePage();
}

class _HomeStatePage extends State<HomePage> {
  HomeController controller = HomeController();
  List<Movie> movies = [];

  void getFilmes() async {
    movies = await controller.getFilmes();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getFilmes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(33, 30, 61, 1),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (BuildContext context) {
              return const SearchModal();
            },
          );
        },
        backgroundColor: const Color.fromRGBO(74, 74, 74, 0.88),
        child: const Icon(Icons.search),
      ),
      body: Padding(
          padding:
              const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 24,
            crossAxisSpacing: 24,
            childAspectRatio: 0.5,
            children: movies
                .map((Movie movie) => GestureDetector(
                    onTap: () => {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DetailsPage(
                                  id: int.parse(movie.id.toString())),
                            ),
                          )
                        },
                    child: CardMovie(
                      title: movie.getTitle,
                      posterUrl: movie.getPosterUrl,
                      voteAverage: movie.getVoteAverage,
                      genres: movie.getGenres,
                    )))
                .toList(),
          )),
    );
  }
}
