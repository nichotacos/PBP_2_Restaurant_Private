import 'dart:convert';

class RegisterModel {
  final int status;
  final String message;
  final User data;

  const RegisterModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory RegisterModel.fromRawJson(String str) =>
      RegisterModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
      status: json['status'],
      message: json['message'],
      data: User.fromJson(json['data']));

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data.toJson(),
      };
}

class User {
  final int id;
  final String username;
  final String password;
  final String email;
  final String telephone;
  final String bornDate;
  final int poin;
  final String imageData;
  final String address;

  User(
      {required this.id,
      required this.username,
      required this.password,
      required this.email,
      required this.telephone,
      required this.bornDate,
      required this.poin,
      required this.imageData,
      required this.address});

  factory User.fromRawJson(String str) => User.fromRawJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'password': password,
        'telephone': telephone,
        'born_date': bornDate,
        'image': imageData,
        'address': address,
        'point': poin,
      };
}
