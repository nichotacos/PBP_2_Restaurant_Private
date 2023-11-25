import 'dart:convert';

class User {
  final int? id;

  final String? username;
  final String? email;
  String? password;
  final String? telephone;
  final String? bornDate;
  String? imageData;
  String? address;
  int? poin;

  User(
      {this.id,
      this.username,
      this.email,
      this.password,
      this.telephone,
      this.bornDate,
      this.imageData,
      this.address,
      this.poin});

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));
  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        username: json['username'],
        email: json['email'],
        password: json['password'],
        telephone: json['telephone'],
        bornDate: json['born_date'],
        imageData: json['image'],
        address: json['address'],
        poin: json['point'],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'email': email,
        'password': password,
        'telephone': telephone,
        'born_date': bornDate,
        'image': imageData,
        'address': address,
        'point': poin,
      };
}
