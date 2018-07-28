
// A class representing a cryptocurrency
class Currency {

  // Constructor
  Currency({this.name, this.symbol, this.rank,
    this.circulatingSupply, this.totalSupply, this.maxSupply, this.price,
    this.volume_24h, this.marketCap, this.percentChange_1h, this.percentChange_7d, this.percentChange_24h});

  // Returns a string version of the currency
  String toString() {
    return "Name: ${this.name}, Rank: ${this.rank}, Price: ${this.price}";
  }

  factory Currency.fromJSON(Map<String, dynamic> json, String key) {
    return Currency(
      name: json['data'][key]['name'] as String,
      symbol: json['data'][key]['symbol'] as String,
      rank: json['data'][key]['rank'] as int,
      circulatingSupply: json['data'][key]['circulating_supply'] as double,
      totalSupply: json['data'][key]['total_supply'] as double,
      maxSupply: json['data'][key]['max_supply'] as double,
      price: json['data'][key]['quotes']['USD']['price'] as double,
      volume_24h: json['data'][key]['quotes']['USD']['volume_24h'] as double,
      marketCap: json['data'][key]['quotes']['USD']['market_cap'] as double,
      percentChange_1h: json['data'][key]['quotes']['USD']['percent_change_1h'] as double,
      percentChange_24h: json['data'][key]['quotes']['USD']['percent_change_24h'] as double,
      percentChange_7d: json['data'][key]['quotes']['USD']['percent_change_7d'] as double,
    );
  }

  // Class variables
  final String name;
  final String symbol;
  final int rank;
  final double circulatingSupply;
  final double totalSupply;
  final double maxSupply;
  final double price;
  final double volume_24h;
  final double marketCap;
  final double percentChange_1h;
  final double percentChange_24h;
  final double percentChange_7d;

}


