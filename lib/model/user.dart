class User {
  final int? id;

  final String? username;
  final String? email;
  final String? password;
  final String? telephone;
  final String? bornDate;

  User(
      {this.id,
      this.username,
      this.email,
      this.password,
      this.telephone,
      this.bornDate});

  @override
  String toString() =>
      'id: $id, username: $username, email: $email, password: $password, telephone: $telephone, bornDate: $bornDate';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'telephone': telephone,
      'bornDate': bornDate
    };
  }

  User.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        username = map['username'],
        email = map['email'],
        password = map['password'],
        telephone = map['telephone'],
        bornDate = map['bornDate'];
}
