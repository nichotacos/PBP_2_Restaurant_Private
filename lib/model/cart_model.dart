import 'dart:convert';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));
String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  String message;
  Cart data;
  CartModel({
    required this.message,
    required this.data,
  });
  factory CartModel.fromRawJson(String str) =>
      CartModel.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());
  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        message: json["message"],
        data: Cart.fromJson(json["data"]),
      );
  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class Cart {
  String name;
  String quantity;
  String desc;
  String price;
  String id_user;
  String image;
  Cart({
    required this.name,
    required this.quantity,
    required this.desc,
    required this.price,
    required this.id_user,
    required this.image,
  });
  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        name: json["name"],
        quantity: json["quantity"],
        desc: json["desc"],
        price: json["price"],
        id_user: json["id_user"],
        image: json["image"],
      );
  Map<String, dynamic> toJson() => {
        "name": name,
        "quantity": quantity,
        "desc": desc,
        "price": price,
        "id_user": id_user,
        "image": image,
      };
}
