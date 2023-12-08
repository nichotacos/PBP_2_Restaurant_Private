import 'dart:convert';

import 'package:pbp_2_restaurant/model/feedback_model.dart';
import 'package:http/http.dart' as http;

class FeedbackRepository {
  static http.Client client = http.Client();

  static Future<List<FeedbackModel>> fetchFeedback() async {
    String apiUrl = 'http://10.0.2.2:8000/api/feedback';
    try {
      var apiResult = await http.get(
        Uri.parse(apiUrl),
      );
      if (apiResult.statusCode == 200) {
        Iterable list = json.decode(apiResult.body)['data'];
        return list.map((e) => FeedbackModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to Get Data');
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<String?> feedbackCreate({
    required FeedbackModel data,
    // ignore: non_constant_identifier_names
  }) async {
    String apiUrl = 'http://10.0.2.2:8000/api/feedback';

    try {
      var apiResult = await http.post(Uri.parse(apiUrl),
          headers: {'Content-Type': 'application/json'},
          body: data.toRawJson());
      if (apiResult.statusCode == 200) {
        final result = "Berhasil menambahkan Feedback";
        return result;
      } else {
        throw Exception('Failed to Create');
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  static Future<String> feedbackDelete({
    required int id,

  }) async {

    String apiUrl = "http://10.0.2.2:8000/api/feedback/${id}";

    try {
      var apiResult = await http.delete(
        Uri.parse(apiUrl),
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

  static Future<String> feedbackEdit({required FeedbackModel data}) async {

    String apiUrl = "http://10.0.2.2:8000/api/feedback/${data.id}";
    try {
      var apiResult = await http.put(Uri.parse(apiUrl),
          headers: {"Content-Type": "application/json"},
          body: data.toRawJson());

      if (apiResult.statusCode == 200) {
        final result = "Berhasil Mengedit Data";
        return result;
      } else {
        throw Exception('Failed to edit feedback');
      }
    } catch (e) {
      print(apiUrl);
      print('Error: $e');
      return "Gagal";
    }
  }
}
