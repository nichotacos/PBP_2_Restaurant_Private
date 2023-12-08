import 'package:pbp_2_restaurant/model/cart_model.dart';

import 'dart:convert';
import 'package:http/http.dart';

class CartClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api/cart';

  static Future<List<Cart>> fetchAll() async {
    try {
      var response = await get(Uri.http(url, endpoint));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];

      return list.map((e) => Cart.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<List<Cart>> fetchCertain(id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/findCart/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];

      return list.map((e) => Cart.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Cart> find(id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return Cart.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> create(Cart cart) async {
    try {
      var response = await post(Uri.http(url, endpoint),
          headers: {"Content-Type": "application/json"},
          body: cart.toRawJson());
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> update(Cart cart) async {
    try {
      var response = await put(Uri.http(url, '$endpoint/${cart.id}'),
          headers: {"Content-Type": "application/json"},
          body: cart.toRawJson());
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> destroy(id) async {
    try {
      var response = await delete(Uri.http(url, '$endpoint/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<bool> findAvail(id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/findAvail/$id'));

      var decode = jsonDecode(response.body);
      var dataCheck = decode["data"] == null ? true : false;
      if (dataCheck) return false;
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return true;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<bool> checkZeroQty(id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/findAvail/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      var decode = jsonDecode(response.body);
      if (decode["data"] == null) {
        return true;
      } else if (decode["quantity"] == 0) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Cart> findCart(id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/findAvail/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return Cart.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<List<Cart>> findOnProgress(id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/getOnProgress/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];

      return list.map((e) => Cart.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> changeStatus(id) async {
    try {
      var response = await put(Uri.http(url, '$endpoint/changeStatus/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
