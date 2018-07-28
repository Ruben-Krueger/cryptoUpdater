import 'package:flutter/material.dart';
import 'package:crypto_updater/utils/currency.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;
import 'dart:async';
import 'story.dart';

final currencyFormat = new NumberFormat("#,##0.00", "en_US");


// Returns a listTile representation given a currency
ListTile getCurrencyTile(Currency currency, BuildContext context) {

  return new ListTile(
      leading: currency.percentChange_1h > 0
          ? Icon(Icons.trending_up, color: Colors.green)
          : Icon(Icons.trending_down, color: Colors.red),
      title: Text('${currency.name}',
          style: TextStyle(fontSize: 20.0, color: Colors.white)),
      subtitle: currency.percentChange_1h > 0
          ? Text('Hourly change: +${currency.percentChange_1h}%',
          style: TextStyle(fontSize: 15.0, color: Colors.white))
          : Text('Hourly change: ${currency.percentChange_1h}%',
          style: TextStyle(fontSize: 15.0, color: Colors.white)),
      trailing: Text('\$${currencyFormat.format(currency.price)}',
          style: TextStyle(fontSize: 18.0, color: Colors.white)),
      enabled: true,
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => DetailedView(currency))));
}

class SummaryBox extends StatelessWidget {
  final String leading;
  final String trailing;
  final double leadingSize;
  final double trailingSize;
  final IconData icon;

  SummaryBox(this.leading, this.leadingSize, this.trailing, this.trailingSize,
      this.icon);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Icon(this.icon, color: Colors.white, size: 40.0),
        Text(this.leading,
            textAlign: TextAlign.start,
            style: TextStyle(color: Colors.white, fontSize: this.leadingSize)),
        Text(this.trailing,
            textAlign: TextAlign.start,
            style: TextStyle(color: Colors.blue, fontSize: this.trailingSize)),
      ],
    );
  }
}

class DetailedView extends StatelessWidget {
  final Currency currency;

  DetailedView(this.currency);

  String _supplyFactor() {
    if (this.currency.maxSupply != null) {
      var number =
      ((this.currency.circulatingSupply / this.currency.maxSupply) * 100)
          .round();
      return '$number';
    } else {
      return 'N/A';
    }
  }

  String _percentChange(percentChange) {
    return percentChange > 0
        ? '+${currencyFormat.format(percentChange)}%'
        : '${currencyFormat.format(percentChange)}%';
  }

  IconData _percentSymbol(percentChange) {
    return percentChange > 0 ? Icons.trending_up : Icons.trending_down;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("${this.currency.name} (${this.currency.symbol})"),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: new CustomScrollView(primary: false, slivers: <Widget>[
          new SliverPadding(
              padding: const EdgeInsets.all(10.0),
              sliver: new SliverGrid.count(
                  crossAxisSpacing: 5.0,
                  crossAxisCount: 2,
                  children: <Widget>[
                    SummaryBox('${currencyFormat.format(this.currency.price)}',
                        20.0, "USD price", 20.0, Icons.attach_money),
                    SummaryBox('${this.currency.rank}', 20.0, "Rank", 20.0,
                        Icons.graphic_eq),
                    SummaryBox(_supplyFactor(), 20.0, "Supply Factor", 20.0,
                        Icons.account_balance),
                    SummaryBox(
                        '${currencyFormat.format(this.currency.volume_24h)}',
                        20.0,
                        "Volume 24h",
                        20.0,
                        Icons.import_export),
                    SummaryBox(
                        _percentChange(this.currency.percentChange_24h),
                        20.0,
                        "Change 24h",
                        20.0,
                        _percentSymbol(this.currency.percentChange_24h)),
                    SummaryBox(
                        _percentChange(this.currency.percentChange_7d),
                        20.0,
                        "Change 7d",
                        20.0,
                        _percentSymbol(this.currency.percentChange_7d)),
                  ]))
        ]),
      ),
    );
  }
}


Widget getNewsTile(Story story, BuildContext context) {
  return new Container(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: ListTile(
        leading: Image.network('${story.imageURL}'),
        title: Text('${story.title}',
            style: TextStyle(fontSize: 18.0, color: Colors.white)),
        subtitle: Text(story.getSummary(),
            style: TextStyle(fontSize: 14.0, color: Colors.white)),
        onTap: () => urlLauncher.launch(story.url),
        //enabled: true,
        //onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailedView(currency)))
      ));
}

