import 'package:pbp_2_restaurant/model/register_model.dart';
import 'package:http/http.dart' as http;

class RegisterRepository {
  static http.Client client = http.Client();
  static Future<RegisterModel?> register(
      {required String username,
      required String email,
      required String password,
      required String telephone,
      required String bornDate,
      required String imageData,
      required String address,
      required int poin,
      required http.Client client}) async {
    String apiURL = 'http://10.0.2.2:8000/api/user/api';
    try {
      var apiResult = await client.post(Uri.parse(apiURL), body: {
        'username': username,
        'email': password,
        'password': password,
        'telephone': telephone,
        'bornDate': bornDate,
        'imageData': imageData,
        'address': address,
        'poin': poin
      });

      if (apiResult.statusCode == 200) {
        return RegisterModel.fromRawJson(apiResult.body);
      } else {
        throw Exception('Failed to Login');
      }
    } catch (e) {
      return null;
    }
  }

  static Future<RegisterModel?> registerTesting({
    required String username,
    required String email,
    required String password,
    required String telephone,
    required String bornDate,
    required String imageData,
    required String address,
    required int poin,
  }) async {
    String apiUrl = 'http://127.0.0.1:8000/api/user';
    try {
      var apiResult = await http.post(Uri.parse(apiUrl), body: {
        'username': username,
        'email': password,
        'password': password,
        'telephone': telephone,
        'born_date': bornDate,
        'image': imageData,
        'address': address,
        'point': poin.toString(), // Convert int to String
      }, headers: {
        'Accept': 'application/json'
      });

      print(apiResult.body);

      if (apiResult.statusCode == 200) {
        final result = RegisterModel.fromRawJson(apiResult.body);
        return result;
      } else {
        throw Exception('Failed to Register');
      }
    } catch (e) {
      return null;
    }
  }
}
