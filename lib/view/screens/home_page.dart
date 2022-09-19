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
  bool hasFilter = false;

  void getMovies() async {
    movies = await controller.getMovies();
    setState(() {});
  }

  applyFilter(List<dynamic> parameters) {
    setState(() {
      hasFilter = true;
    });
    movies = controller.movieFilters(parameters);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromRGBO(33, 30, 61, 1),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(top: 10),
        child: Row(
          children: [
            FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (BuildContext context) {
                      return SingleChildScrollView(
                          child: Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: SearchModal(applyFilter: applyFilter),
                      ));
                    });
              },
              backgroundColor: const Color.fromRGBO(74, 74, 74, 0.88),
              child: const Icon(Icons.search),
            ),
            !hasFilter
                ? const SizedBox()
                : Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: FloatingActionButton(
                      onPressed: () {
                        applyFilter([
                          "",
                          RangeValues(1850,
                              double.parse(DateTime.now().year.toString())),
                          []
                        ]);
                        setState(() {
                          hasFilter = !hasFilter;
                        });
                      },
                      backgroundColor: const Color.fromRGBO(74, 74, 74, 0.88),
                      child: const Icon(Icons.filter_alt_off),
                    ),
                  ),
          ],
        ),
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
                      onlyTitle: false,
                    )))
                .toList(),
          )),
    );
  }
}
