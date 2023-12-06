import 'dart:convert';

class User {
  final int? id;

  final String? name;
  final double? price;
  final String? description;
  final String? imageData;

  User({
    this.id,
    this.name,
    this.price,
    this.description,
    this.imageData,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));
  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        price: json['price'],
        description: json['description'],
        imageData: json['image'],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'image': imageData,
        'description': description,
      };
}
