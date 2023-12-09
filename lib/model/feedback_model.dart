import 'dart:convert';

FeedbackModel feedbackModelFromJson(String str) => FeedbackModel.fromJson(json.decode(str));
String feedbackModelToJson(FeedbackModel data) => json.encode(data.toJson());

class FeedbackModel {
  int? id;
  String? comment;
  String? status;
  String? idUser;

  FeedbackModel(
      {this.id,
      this.comment,
      this.status,
      this.idUser});

  FeedbackModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    status = json['status'];
    idUser = json['id_user'].toString();
  }

  factory FeedbackModel.fromRawJson(String str) => FeedbackModel.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['comment'] = this.comment;
    data['status'] = this.status;
    data['id_user'] = this.idUser;
    return data;
  }
}