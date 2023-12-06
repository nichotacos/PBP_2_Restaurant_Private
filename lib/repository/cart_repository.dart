import 'package:pbp_2_restaurant/model/cart_model.dart';
import 'package:http/http.dart' as http;

class CartRepository {
  static http.Client client = http.Client();
  static Future<CartModel?> login({
    required String username,
    required String password,
    required http.Client client,
  }) async {
    String apiUrl = 'http://10.0.2.2:8000/api/cart';
    try {
      var apiResult = await client.post(
        Uri.parse(apiUrl),
        body: {'username': username, 'password': password},
      );
      if (apiResult.statusCode == 200) {
        return CartModel.fromRawJson(apiResult.body);
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      return null;
    }
  }

  static Future<CartModel?> cartTesting({
    required String name,
    required String quantity,
    required String desc,
    required String price,
    required String id_user,
    required String image,
  }) async {
    String apiUrl = 'http://127.0.0.1:8000/api/cart';
    try {
      var apiResult = await http.post(
        Uri.parse(apiUrl),
        body: {
          'name': name,
          'quantity': quantity,
          'desc': desc,
          'price': price,
          'id_user': id_user,
          'image': image
        },
      );
      if (apiResult.statusCode == 200) {
        final result = CartModel.fromRawJson(apiResult.body);
        return result;
      } else {
        throw Exception('Failed to Create');
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  static Future<String> deleteTesting({
    required String id,
  }) async {
    var id_cart = id.toString();
    String apiUrl = "http://127.0.0.1:8000/api/cart/$id_cart";

    try {
      var apiResult = await http.delete(
        Uri.parse(apiUrl),
        body: {'id': id},
        headers: {},
      );
      if (apiResult.statusCode == 200) {
        final result = "Berhasil Menghapus Data";
        return result;
      } else {
        throw Exception('Failed to ');
      }
    } catch (e) {
      print(apiUrl);
      print('Error: $e');
      return "Gagal";
    }
  }
}
