import 'package:pbp_2_restaurant/model/transaction_cart_model.dart';

import 'dart:convert';
import 'package:http/http.dart';

class TransactionCartClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api/transactionsCart';

  static Future<List<TransactionCart>> fetchAll() async {
    try {
      var response = await get(Uri.http(url, endpoint));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];

      return list.map((e) => TransactionCart.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<TransactionCart> find(id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return TransactionCart.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> create(TransactionCart transaction) async {
    try {
      var response = await post(Uri.http(url, endpoint),
          headers: {"Content-Type": "application/json"},
          body: transaction.toRawJson());
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<TransactionCart> findLast() async {
    try {
      var response = await get(Uri.http(url, '$endpoint/findLast'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return TransactionCart.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
