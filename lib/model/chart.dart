import 'dart:convert';

class toChart {
  final int? id, quantity, price, id_user;

  String? name, desc, image;

  toChart(
      {this.id,
      this.name,
      this.quantity,
      this.image,
      this.desc,
      this.price,
      this.id_user});

  factory toChart.fromRawJson(String str) => toChart.fromJson(json.decode(str));
  factory toChart.fromJson(Map<String, dynamic> json) => toChart(
        id: json["id"],
        name: json["name"],
        quantity: json["quantity"],
        image: json["image"],
        desc: json["desc"],
        price: json["price"],
        id_user: json["id_user"],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "quantity": quantity,
        "image": image,
        "desc": desc,
        "price": price,
        "id_user": id_user,
      };
}
