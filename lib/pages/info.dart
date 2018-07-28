import 'package:flutter/material.dart';


class Info extends StatelessWidget {

  final String paragraph = "A cryptocurrency (or crypto currency) is digital asset designed to work as a medium of exchange that uses strong cryptography to secure financial transactions, control the creation of additional units, and verify the transfer of assets. Cryptocurrency is a kind of digital currency, virtual currency or alternative currency.";

  @override
  Widget build(BuildContext context) {
    return new Container(
        color: Colors.black,
        padding: new EdgeInsets.all(15.0),
        child: Column(
            children: <Widget>[
              Text('Cryptocurrency', style: TextStyle(color: Colors.white, fontSize: 25.0), textAlign: TextAlign.justify),
              Text(paragraph, style: TextStyle(color: Colors.white, fontSize: 25.0), textAlign: TextAlign.left),
              Text('-Wikipedia, the free encyclopedia', style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white, fontSize: 20.0), textAlign: TextAlign.justify),
            ]
        ));}

}





