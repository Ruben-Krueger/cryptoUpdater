import 'package:flutter/material.dart';
import 'package:crypto_updater/pages/market.dart' as market;
import 'package:crypto_updater/pages/news.dart' as news;
import 'package:crypto_updater/pages/info.dart' as info;

void main() => runApp(
    new MaterialApp(home: new Tabs(), debugShowCheckedModeBanner: false));

class Tabs extends StatefulWidget {
  @override
  TabsState createState() => new TabsState();
}

class TabsState extends State<Tabs> with SingleTickerProviderStateMixin {

  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('CryptoUpdater'),
          backgroundColor: Colors.black,
          bottom: new TabBar(
            controller: controller,
            tabs: <Tab>[
              new Tab(icon: new Icon(Icons.trending_up)),
              new Tab(icon: new Icon(Icons.announcement)),
              new Tab(icon: new Icon(Icons.info)),
            ],
          ),
        ),
        body: new TabBarView(
            controller: controller,
            children: <Widget>[
              new market.Market(),
              new news.News(),
              new info.Info()
            ])
    );
  }
}

