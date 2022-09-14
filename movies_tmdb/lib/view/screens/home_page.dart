import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromRGBO(33, 30, 61, 1),
      body: Center(
        child: Text(
          "First Screen",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
