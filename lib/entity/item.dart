import 'dart:convert';

class Item {
  final int? id;

  final String? name;
  final double? price;
  final String? description;
  final String? imageData;

  Item({
    this.id,
    this.name,
    this.price,
    this.description,
    this.imageData,
  });

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));
  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json['id'],
        name: json['name'],
        price: json['price'] is int
            ? (json['price'] as int).toDouble()
            : json['harga'],
        description: json['description'],
        imageData: json['imageData'],
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
