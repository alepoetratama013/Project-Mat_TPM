import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:stock_app/utils/api_key.dart';

class Stock {
  String? status;
  String? message;
  Data? data;

  Stock({this.status, this.message, this.data});

  Stock.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? count;
  List<Results>? results;

  Data({this.count, this.results});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String? ticker;
  String? close;
  String? change;
  String? percent;

  Results({this.ticker, this.close, this.change, this.percent});

  Results.fromJson(Map<String, dynamic> json) {
    ticker = json['ticker'];
    close = json['close'];
    change = json['change'];
    percent = json['percent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ticker'] = ticker;
    data['close'] = close;
    data['change'] = change;
    data['percent'] = percent;
    return data;
  }

  static Future<List<Results>> fetchStocks() async {
    final response = await http.get(Uri.parse(
        "https://api.goapi.id/v1/stock/idx/trending?api_key=$apiKey"));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as Map<String, dynamic>;
      final stockData = Stock.fromJson(jsonData);

      if (stockData.status == "success" && stockData.data != null) {
        return stockData.data!.results ?? [];
      } else {
        throw Exception('Failed to fetch stock data.');
      }
    } else {
      throw Exception('Failed to fetch stock data: ${response.statusCode}');
    }
  }
}
