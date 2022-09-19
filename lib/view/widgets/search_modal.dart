import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class SearchModal extends StatefulWidget {
  Function(List<dynamic> parameters) applyFilter;
  SearchModal({Key? key, required this.applyFilter}) : super(key: key);

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
  String searchText = "";

  RangeValues _currentRangeValues =
      RangeValues(1850, double.parse(DateTime.now().year.toString()));

  List<String> categoriesFilter = [];

  static List<String> genres = [
    "Action",
    "Animation",
    "Comedy",
    "Crime",
    "Drama",
    "Experimental",
    "Fantasy",
    "Historical",
    "Horror",
    "Romance",
    "Science Fiction",
    "Thriller",
    "Western",
    "Other",
  ];
  final genresList =
      genres.map((genre) => MultiSelectItem<String>(genre, genre)).toList();

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
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          onChanged: (text) {
                            setState(() {
                              searchText = text;
                            });
                            widget.applyFilter([
                              searchText,
                              _currentRangeValues,
                              categoriesFilter
                            ]);
                          },
                          cursorColor: const Color.fromRGBO(49, 45, 84, 1),
                          decoration:
                              const InputDecoration.collapsed(hintText: ''),
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
                  max: double.parse(DateTime.now().year.toString()),
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
                    widget.applyFilter(
                        [searchText, _currentRangeValues, categoriesFilter]);
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
              chipDisplay: MultiSelectChipDisplay(
                chipColor: const Color.fromRGBO(49, 45, 84, 1),
                textStyle: const TextStyle(color: Colors.white),
              ),
              buttonText: const Text(
                "Category",
                style: TextStyle(
                  color: Color.fromRGBO(49, 45, 84, 1),
                  fontSize: 16,
                ),
              ),
              onConfirm: (categories) {
                if (categories.isEmpty) {
                  categoriesFilter = [];
                } else {
                  for (var category in categories) {
                    // genresFilter.add(value)
                    categoriesFilter.add(category.toString());
                  }
                }
                widget.applyFilter(
                    [searchText, _currentRangeValues, categoriesFilter]);
              },
            ),
          ],
        ),
      ),
    );
  }
}
