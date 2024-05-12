class Market {
  final String coinpair;
  final String changes;
  final String price;
  final String coinImg;

  Market({
    required this.coinpair,
    required this.changes,
    required this.price,
    required this.coinImg,
  });

  factory Market.fromJson(Map<String, dynamic> json) {
    return Market(
        coinpair: json['market'] ?? '',
        changes: json['change_24_hour'] ?? '',
        price: json['last_price'] ?? '',
        coinImg: json['coinImg'] ?? '');
  }
}
