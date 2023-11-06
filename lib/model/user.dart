class User {
  final int? id;

  final String? username;
  final String? email;
  String? password;
  final String? telephone;
  final String? bornDate;
  String? imageData;
  String? address;

  User(
      {this.id,
      this.username,
      this.email,
      this.password,
      this.telephone,
      this.bornDate,
      this.imageData,
      this.address});

  @override
  String toString() =>
      'id: $id, username: $username, email: $email, password: $password, telephone: $telephone, bornDate: $bornDate, address: $address';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'telephone': telephone,
      'bornDate': bornDate,
      'imageData': imageData,
      'address': address
    };
  }

  User.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        username = map['username'],
        email = map['email'],
        password = map['password'],
        telephone = map['telephone'],
        bornDate = map['bornDate'],
        imageData = map['imageData'],
        address = map['address'];
}
