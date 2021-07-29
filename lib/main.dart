import 'package:flutter/material.dart';

import 'view/movieDetail.dart';
import 'view/movieUI.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MovieFontpage(),
      routes: {
        "/moviefontpage": (context) => MovieFontpage(),
        "/movieDetailpage": (context) => MovieDetailpage()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
