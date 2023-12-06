import 'dart:convert';

class Cart {
  final int? id, itemId, userId, quantity;
  final double? totalPrice;

  Cart({this.id, this.itemId, this.userId, this.quantity, this.totalPrice});

  factory Cart.fromRawJson(String str) => Cart.fromJson(json.decode(str));
  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
        itemId: json["itemId"],
        quantity: json["quantity"],
        userId: json["userId"],
        totalPrice: json["totalPrice"],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        "id": id,
        "itemId": itemId,
        "quantity": quantity,
        "userId": userId,
        "totalPrice": totalPrice,
      };
}
