import 'package:pbp_2_restaurant/model/transaction_model.dart';

import 'dart:convert';
import 'package:http/http.dart';

class TransactionClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api/transactions';

  static Future<List<Transactions>> fetchAll() async {
    try {
      var response = await get(Uri.http(url, endpoint));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];

      return list.map((e) => Transactions.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<List<Transactions>> fetchCertain(id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/findTransaction/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];

      return list.map((e) => Transactions.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Transactions> find(id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return Transactions.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> create(Transactions transaction) async {
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

  static Future<int> findLast() async {
    try {
      var response = await get(Uri.http(url, '$endpoint/findLast'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      var decode = jsonDecode(response.body);
      var found = decode["data"]["id"];

      return found;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> update(Transactions transaction) async {
    try {
      var response = await put(Uri.http(url, '$endpoint/${transaction.id}'),
          headers: {"Content-Type": "application/json"},
          body: transaction.toRawJson());
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
