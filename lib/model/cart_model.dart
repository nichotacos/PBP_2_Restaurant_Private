import 'dart:convert';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));
String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  String message;
  Cart data;
  String status;
  CartModel({required this.message, required this.data, required this.status});
  factory CartModel.fromRawJson(String str) =>
      CartModel.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());
  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        message: json["message"],
        data: Cart.fromJson(json["data"]),
        status: json['status'],
      );
  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class Cart {
  final int id, itemId, userId, quantity;
  final double totalPrice;
  Cart(
      {required this.id,
      required this.itemId,
      required this.userId,
      required this.quantity,
      required this.totalPrice});

  factory Cart.fromRawJson(String str) => Cart.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
        itemId: json["itemId"],
        quantity: json["quantity"],
        userId: json["userId"],
        totalPrice: json["totalPrice"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "itemId": itemId,
        "quantity": quantity,
        "userId": userId,
        "totalPrice": totalPrice,
      };
}
