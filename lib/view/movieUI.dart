import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:movie_app/models/movie_model.dart';

class MovieFontpage extends StatefulWidget {
  @override
  _MovieFontpageState createState() => _MovieFontpageState();
}

class _MovieFontpageState extends State<MovieFontpage> {
  Widget _loadingWidget = LinearProgressIndicator(
    backgroundColor: Colors.red,
  );
  Widget _disableloadingWidget = SizedBox();
  bool _isloading = false;
  late double height, width;
  List<Widget> _listitems = [];
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("Movie App"),
        actions: [_refreshbutton()],
      ),
      body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            child: Column(
              children: [
                // _isloading == true ? _loadingWidget : _disableloadingWidget,
                //
                //
                _searchbar(),
                SizedBox(
                  height: 10,
                ),
                _movieList()
              ],
            ),
          )),
    );
  }

  Widget _refreshbutton() {
    return IconButton(
      onPressed: () {
        _fetch();
      },
      icon: Icon(Icons.refresh),
    );
  }

  _fetch() async {
    _enableLoading();
    var url =
        Uri.parse("http://www.omdbapi.com/?s=Batman&page=2&apikey=564727fa");
    Response res = await get(url);
    if (res.statusCode == 200) {
      _respondDecorder(res.body);
    } else {
      throw Exception("Failed to load movies details");
    }
    _disableLoading();
  }

  _respondDecorder(dynamic body) {
    final result = jsonDecode(body);
    List data = result["Search"];
    List<Widget> tempList = [];
    for (int i = 0; i < data.length; i++) {
      Map eachelement = data[i];
      // String title = eachelement['Title'];
      // String post = eachelement["Poster"];
      // String year = eachelement["Year"];
      MovieModel model = MovieModel(
        title: eachelement["Title"],
        poster: eachelement["Poster"],

        // year: eachelement["Year"],

        //
        //
      );
      Widget Titlecard = _moviecard(model);
      tempList.add(Titlecard);
    }
    setState(() {});
    _listitems = tempList;
  }

  _enableLoading() {
    setState(() {});
    _isloading = true;
  }

  _disableLoading() {
    setState(() {});
    _isloading = false;
  }

  _movieList() {
    return Expanded(
      child: ListView(children: _listitems),
    );
  }

  Widget _moviecard(MovieModel model) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/movieDetailpage", arguments: model);
      },
      child: Container(
        margin: EdgeInsets.all(10),
        color: Colors.grey[200],
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network(
              model.poster,
              height: 80,
            ),
            SizedBox(
              width: 20,
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(model.title),
                SizedBox(
                  height: 8,
                ),
                // Text(model.year.toString())
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _searchbar() {
    return SizedBox(
      height: height * 0.08,
      child: TextField(
        controller: _textEditingController,
        decoration: InputDecoration(
          icon: Icon(
            Icons.search,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}
