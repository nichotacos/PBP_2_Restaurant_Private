import 'dart:convert';

TransactionCartModel transactionModelFromJson(String str) =>
    TransactionCartModel.fromJson(json.decode(str));
String transactionModelToJson(TransactionCartModel data) =>
    json.encode(data.toJson());

class TransactionCartModel {
  String message;
  TransactionCart data;
  String status;
  TransactionCartModel(
      {required this.message, required this.data, required this.status});
  factory TransactionCartModel.fromRawJson(String str) =>
      TransactionCartModel.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());
  factory TransactionCartModel.fromJson(Map<String, dynamic> json) =>
      TransactionCartModel(
        message: json["message"],
        data: TransactionCart.fromJson(json["data"]),
        status: json['status'],
      );
  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class TransactionCart {
  final int id, trId, cartId;
  final String? transactionDate;
  final String? review;
  final double? totalAmount;
  TransactionCart({
    required this.id,
    required this.trId,
    required this.cartId,
    this.transactionDate,
    this.review,
    this.totalAmount,
  });

  factory TransactionCart.fromRawJson(String str) =>
      TransactionCart.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory TransactionCart.fromJson(Map<String, dynamic> json) =>
      TransactionCart(
        id: json["id"],
        trId: json["transactionId"],
        cartId: json["cartId"],
        transactionDate: json["transaction_date"],
        review: json["reviews"] ?? '',
        totalAmount: json["total_amount"] is int
            ? (json["total_amount"] as int).toDouble()
            : json["total_amount"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "transactionId": trId,
        "cartId": cartId,
      };
}
