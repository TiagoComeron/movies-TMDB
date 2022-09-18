import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class SearchModal extends StatefulWidget {
  const SearchModal({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchModalPage();
}

class Genre {
  final int id;
  final String name;

  Genre({
    required this.id,
    required this.name,
  });
}

class _SearchModalPage extends State<SearchModal> {
  RangeValues _currentRangeValues =
      RangeValues(1850, double.parse(DateTime.now().year.toString()));

  static List<Genre> genres = [
    Genre(id: 1, name: "Action"),
    Genre(id: 2, name: "Animation"),
    Genre(id: 3, name: "Comedy"),
    Genre(id: 4, name: "Crime"),
    Genre(id: 5, name: "Drama"),
    Genre(id: 6, name: "Experimental"),
    Genre(id: 7, name: "Fantasy"),
    Genre(id: 8, name: "Historical"),
    Genre(id: 9, name: "Horror"),
    Genre(id: 10, name: "Romance"),
    Genre(id: 11, name: "Science Fiction"),
    Genre(id: 12, name: "Thriller"),
    Genre(id: 13, name: "Western"),
    Genre(id: 14, name: "Other"),
  ];
  final genresList =
      genres.map((genre) => MultiSelectItem<Genre>(genre, genre.name)).toList();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      decoration: const BoxDecoration(
          color: Color.fromRGBO(217, 217, 217, 1),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0))),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color.fromRGBO(165, 165, 165, 1),
              ),
              height: 30,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Icon(
                      Icons.search,
                      color: Color.fromRGBO(49, 45, 84, 1),
                    ),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          cursorColor: Color.fromRGBO(49, 45, 84, 1),
                          decoration: InputDecoration.collapsed(hintText: ''),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Column(
              children: [
                const Text(
                  "Period Between",
                  style: TextStyle(color: Color.fromRGBO(49, 45, 84, 1)),
                ),
                RangeSlider(
                  activeColor: const Color.fromRGBO(49, 45, 84, 1),
                  inactiveColor: const Color.fromARGB(118, 33, 30, 61),
                  values: _currentRangeValues,
                  max: 2022,
                  min: 1850,
                  divisions: DateTime.now().year - 1850,
                  labels: RangeLabels(
                    _currentRangeValues.start.round().toString(),
                    _currentRangeValues.end.round().toString(),
                  ),
                  onChanged: (RangeValues values) {
                    setState(() {
                      _currentRangeValues = values;
                    });
                  },
                ),
              ],
            ),
            MultiSelectDialogField(
              items: genresList,
              title: const Text("Category"),
              selectedColor: Colors.blue,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color.fromRGBO(165, 165, 165, 1),
              ),
              buttonText: const Text(
                "Category",
                style: TextStyle(
                  color: Color.fromRGBO(49, 45, 84, 1),
                  fontSize: 16,
                ),
              ),
              onConfirm: (results) {
                print(results);
              },
            ),
          ],
        ),
      ),
    );
  }
}
