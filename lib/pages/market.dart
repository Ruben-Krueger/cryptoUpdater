import 'dart:async';
import 'package:flutter/material.dart';
import 'package:crypto_updater/utils/loadData.dart' as loadData;
import 'package:crypto_updater/utils/display.dart' as display;

class Market extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(color: Colors.black, child: MarketBody());
  }
}

class MarketBody extends StatefulWidget {
  @override
  MarketBodyState createState() => MarketBodyState();
}


class MarketBodyState extends State<MarketBody> {

  List currencyList = new List();

  Future<Null> _refresh() async {
    currencyList = await loadData.fetchCurrencies();
    setState(() {
      build(context);
    });
  }

  Widget currencyTile() {
    return (new Container(
        child: new RefreshIndicator(
            child: ListView.builder(
                itemCount: currencyList == null ? 0 : currencyList.length,
                itemBuilder: (BuildContext context, int index) {
                  return new Container(
                      child: Center(
                          child: Column(children: <Widget>[
                            display.getCurrencyTile(currencyList[index], context),
                          ])));
                }),
            onRefresh: _refresh)));
  }


  @override
  Widget build(BuildContext context) {
//    if(currencyList != null) currencyList.clear();
    return new Container(
        color: Colors.black,
        child: FutureBuilder(
            future: loadData.fetchCurrencies(),
            builder: (context, snapshot) {
              if (currencyList != null) {
                return currencyTile();
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                    textAlign: TextAlign.justify);
              }
              // By default, show a loading spinner
              return new Container(child: CircularProgressIndicator());
            })
    );
  }

  void _getCurrencies() async{
    currencyList = await loadData.fetchCurrencies();
  }

  @override
  void initState() {
    _getCurrencies();
    super.initState();
  }
}
