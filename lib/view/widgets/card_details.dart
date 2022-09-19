import 'package:flutter/material.dart';

import '../../model/movie.dart';

class CardDetails extends StatefulWidget {
  const CardDetails({Key? key, required this.movie}) : super(key: key);
  final Movie? movie;

  @override
  State<CardDetails> createState() => _CardDetailsState();
}

class _CardDetailsState extends State<CardDetails> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9),
      ),
      elevation: 3,
      color: const Color.fromRGBO(49, 45, 84, 1),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 180,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(9)),
                    child: Image.network(
                      widget.movie!.getPosterUrl,
                      errorBuilder: (context, exception, stackTrace) {
                        return const Center(
                            child: Text("No image avaliable..."));
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 200,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, left: 30, right: 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                              child: Text(
                            widget.movie!.getTitle,
                            style: const TextStyle(fontSize: 20),
                          )),
                          SizedBox(
                            height: 25,
                            child: Text(
                              widget.movie!.getTagline,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                            child: ListView.builder(
                              reverse: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.movie!.getGenres.length,
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
                                    widget.movie!.getGenres[index],
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Released: ${widget.movie!.getReleaseDate.year}",
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10,
                                      wordSpacing: 3),
                                ),
                                Text(
                                  "Runtime: ${widget.movie!.getRuntime}",
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10,
                                      wordSpacing: 3),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                            child: Card(
                              elevation: 2,
                              color: const Color.fromRGBO(33, 30, 61, 1),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 5, right: 5, top: 3, bottom: 2),
                                child: Text(
                                  widget.movie!.getVoteAverage.toString(),
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0, bottom: 10),
              child: Text(
                widget.movie!.getOverview,
                style: const TextStyle(
                    color: Colors.grey, fontSize: 12, wordSpacing: 3),
                textAlign: TextAlign.justify,
              ),
            )
          ],
        ),
      ),
    );
  }
}
