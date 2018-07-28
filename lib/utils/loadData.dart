import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:crypto_updater/utils/currency.dart';
import 'dart:convert';
import 'package:crypto_updater/utils/story.dart';


// Asynchronously gets currency data from coinmarketcap API
Future<List<Currency>> fetchCurrencies() async {

  // Basecoin REST API endpoint
  final String url = "https://api.coinmarketcap.com/v2/ticker/";

  // List containing all currency objects created from API data
  List<Currency> currencyList = new List();

  // Map containing API data
  Map<String, dynamic> data;

  // Prevent duplicates in list
  currencyList.clear();

  final response = await http.get(url, headers: {"Accept": "application/json"});

  if (response.statusCode == 200) {
    data = json.decode(response.body);

    // iterate through each of the currencies listed under "data" in API's returned JSON data
    data["data"].forEach((k,v) => currencyList.add(new Currency.fromJSON(data, k)));

    // Sort the list based on price
    currencyList.sort((a, b) => b.price.compareTo(a.price));

    return currencyList;

  } else {
    throw('HTTP request failed, statusCode: ${response?.statusCode}');
  }
}

// Asynchronously gets news stories from cryptocompare API
Future<List<Story>> fetchNews() async{

  final String url = 'https://min-api.cryptocompare.com/data/v2/news/?lang=EN';

  final response = await http.get(url, headers: {"Accept": "application/json"});

  if (response.statusCode == 200) {

    Map<String, dynamic> _mapData;
    List<dynamic> _data;
    List<Story> _storyList = new List();

    // full API response
    _mapData = json.decode(response.body);

    // stories we actually want
    _data = _mapData["Data"];

    // loop over _data list and create a new Story
    for(var i = 0; i < _data.length; i ++) {
      _storyList.add(new Story.fromList(_data, i));
    }
    return _storyList;
  } else {
    throw('HTTP request failed, statusCode: ${response?.statusCode}');
  }
}


