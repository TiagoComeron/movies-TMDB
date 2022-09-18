import 'package:flutter/material.dart';

class CardMovie extends StatelessWidget {
  final String title;
  final String posterUrl;
  final double voteAverage;
  final List<String> genres;

  const CardMovie(
      {Key? key,
      required this.title,
      required this.posterUrl,
      required this.voteAverage,
      required this.genres})
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
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(9)),
                child: Image.network(
                  posterUrl,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return const SizedBox(
                        height: 200,
                        child: Center(child: Text('Image not found...')));
                  },
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
                              child: Text(
                            title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ))
                        ]),
                    Row(children: [
                      Expanded(
                        child: SizedBox(
                          height: 30,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: genres.length,
                            itemBuilder: (BuildContext context, int index) =>
                                Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              color: const Color.fromRGBO(33, 30, 61, 1),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 3, bottom: 3),
                                child: Text(
                                  genres[index],
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
                              voteAverage.toString(),
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
