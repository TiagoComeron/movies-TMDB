import 'package:flutter/material.dart';

import '../../model/movie.dart';

class CardMovie extends StatelessWidget {
  final Movie movie;
  final bool onlyTitle;

  const CardMovie({Key? key, required this.movie, required this.onlyTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9),
        ),
        elevation: 3,
        color: const Color.fromRGBO(49, 45, 84, 1),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(9)),
                  child: Image.network(
                    movie.getPosterUrl,
                    errorBuilder: (context, exception, stackTrace) {
                      // return const Center(child: Text("No image avaliable..."));
                      return const Image(image: AssetImage('poster_404.png'));
                    },
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 10, right: 10, bottom: 10),
                  child: Column(children: <Widget>[
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: SizedBox(
                            height: 35,
                            child: Text(
                              movie.getTitle,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                        ]),
                    onlyTitle
                        ? const SizedBox()
                        : Row(children: [
                            Expanded(
                              child: SizedBox(
                                height: 30,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: movie.getGenres.length,
                                  itemBuilder:
                                      (BuildContext context, int index) => Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    color: const Color.fromRGBO(33, 30, 61, 1),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8, top: 3, bottom: 3),
                                      child: Text(
                                        movie.getGenres[index],
                                        style: const TextStyle(fontSize: 13),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 5),
                              child: Card(
                                elevation: 2,
                                color: const Color.fromRGBO(33, 30, 61, 1),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5, right: 5, top: 3, bottom: 2),
                                  child: Text(
                                    movie.getVoteAverage.toString(),
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                  ])),
            ]));
  }
}
