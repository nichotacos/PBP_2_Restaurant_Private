import 'dart:convert';

TransactionModel transactionModelFromJson(String str) =>
    TransactionModel.fromJson(json.decode(str));
String transactionModelToJson(TransactionModel data) =>
    json.encode(data.toJson());

class TransactionModel {
  String message;
  Transactions data;
  String status;
  TransactionModel(
      {required this.message, required this.data, required this.status});
  factory TransactionModel.fromRawJson(String str) =>
      TransactionModel.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());
  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        message: json["message"],
        data: Transactions.fromJson(json["data"]),
        status: json['status'],
      );
  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class Transactions {
  final int id, userId;
  final String status;
  final String transactionDate;
  final String review;
  final double totalAmount;
  Transactions({
    required this.id,
    required this.userId,
    required this.status,
    required this.transactionDate,
    required this.review,
    required this.totalAmount,
  });

  factory Transactions.fromRawJson(String str) =>
      Transactions.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory Transactions.fromJson(Map<String, dynamic> json) => Transactions(
        id: json["id"],
        userId: json["userId"],
        status: json["status"],
        transactionDate: json["transaction_date"],
        review: json["reviews"] ?? '',
        totalAmount: json["total_amount"] is int
            ? (json["total_amount"] as int).toDouble()
            : json["total_amount"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "status": status,
        "transaction_date": transactionDate,
        "reviews": review,
        "total_amount": totalAmount,
      };
}
