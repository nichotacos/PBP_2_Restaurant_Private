import 'package:pbp_2_restaurant/model/login_model.dart';
import 'package:http/http.dart' as http;

class LoginRepository {
  static http.Client client = http.Client();
  static Future<LoginModel?> login(
      {required String username,
      required String password,
      required http.Client client}) async {
    String apiURL = 'http://10.0.2.2:8000/api/user/api';
    try {
      var apiResult = await client.post(Uri.parse(apiURL),
          body: {'username': username, 'password': password});

      if (apiResult.statusCode == 200) {
        return LoginModel.fromRawJson(apiResult.body);
      } else {
        throw Exception('Failed to Login');
      }
    } catch (e) {
      return null;
    }
  }

  static Future<LoginModel?> loginTesting({
    required String username,
    required String password,
  }) async {
    String apiURL = 'http://127.0.0.1:8000/api/user/login';
    try {
      var apiResult = await http.post(Uri.parse(apiURL),
          body: {'username': username, 'password': password});
      if (apiResult.statusCode == 200) {
        return LoginModel.fromRawJson(apiResult.body);
      } else {
        throw Exception('Failed to Login');
      }
    } catch (e) {
      return null;
    }
  }
}
