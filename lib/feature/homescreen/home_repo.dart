import 'dart:convert';
import 'dart:developer';

import 'package:cryptogram/feature/homescreen/models/market.dart';
import 'package:http/http.dart' as http;

class HomeRepo {
  static Future<List<Market>> getCoindcxData() async {
    http.Response response =
        await http.get(Uri.parse('https://api.coindcx.com/exchange/ticker'));
    List<dynamic> data = jsonDecode(response.body);
    List<Market> marketData = data.map((e) {
      String coincode = getCoinCode(e['market']);
      String coinImg = "https://coindcx.s3.amazonaws.com/static/coins/" +
          coincode.toLowerCase() +
          ".svg";

      e['coinImg'] = coinImg;
      return Market.fromJson(e);
    }).toList();
    return marketData;
  }

  static String getCoinCode(String coincode) {
    if (coincode.endsWith("INR")) {
      return coincode.substring(0, coincode.length - 3);
    }
    if (coincode.endsWith("USDT")) {
      return coincode.substring(0, coincode.length - 4);
    }
    if (coincode.endsWith("BTC")) {
      return coincode.substring(0, coincode.length - 3);
    }
    return coincode;
  }
}
