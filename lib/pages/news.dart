// Import packages
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:crypto_updater/utils/loadData.dart' as loadData;
import 'package:crypto_updater/utils/display.dart' as display;
import 'package:crypto_updater/utils/story.dart';


class News extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(color: Colors.black, child: NewsBody());
  }
}

class NewsBody extends StatefulWidget {
  @override
  NewsBodyState createState() => NewsBodyState();
}

class NewsBodyState extends State<NewsBody> {
  List<Story> _newsList = new List();

  Future<Null> _refresh() async {
    _newsList = await loadData.fetchNews();
    setState(() {
      build(context);
    });
  }

  Widget newsTile() {
    return (new Container(
        child: new RefreshIndicator(
            child: ListView.builder(
                itemCount: _newsList == null ? 0 : _newsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return new Container(
                      child: Center(
                          child: Column(children: <Widget>[
                            display.getNewsTile(_newsList[index], context),
                          ])));
                }),
            onRefresh: _refresh)));
  }



  @override
  Widget build(BuildContext context) {
    return new Container(
        color: Colors.black,
        child: FutureBuilder(
            future: loadData.fetchNews(),
            builder: (context, snapshot) {
              if (_newsList != null) {
                return newsTile();
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}',
                    style:
                    TextStyle(color: Colors.white, fontSize: 20.0),
                    textAlign: TextAlign.justify);
              }
              // By default, show a loading spinner
              return CircularProgressIndicator();
            })
    );
  }

  // because initState() cannot be async
  void _getNews() async {
    _newsList = await loadData.fetchNews();
  }


  @override
  void initState() {
    _getNews();
    super.initState();
  }
}
