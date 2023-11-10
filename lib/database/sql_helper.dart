// import 'dart:js_interop_unsafe';

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:pbp_2_restaurant/model/user.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  //create db
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
      CREATE TABLE user(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        username TEXT NOT NULL UNIQUE,
        email TEXT UNIQUE,
        password TEXT,
        telephone VARCHAR(20) UNIQUE,
        bornDate VARCHAR(10),
        imageData TEXT,
        address TEXT,
        poin INTEGER DEFAULT 0
      )
    """);
  }

  //call db
  static Future<sql.Database> db() async {
    return sql.openDatabase('user.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  //insert User
  static Future<int> addUser(String username, String email, String password,
      String telephone, String bornDate) async {
    final db = await SQLHelper.db();
    Uint8List imageData =
        (await rootBundle.load('assets/images/test.jpeg')).buffer.asUint8List();
    String base64Image = base64Encode(imageData);
    final data = {
      'username': username,
      'email': email,
      'password': password,
      'telephone': telephone,
      'bornDate': bornDate,
      'imageData': base64Image,
      'address': null,
      'poin': 0
    };
    return await db.insert('user', data);
  }

  //read User
  static Future<List<Map<String, dynamic>>> getUser() async {
    final db = await SQLHelper.db();
    return db.query('user');
  }

  //read certain user
  static Future<User?> getCertainUser(int? id) async {
    final db = await SQLHelper.db();
    var result = await db.rawQuery(
      "SELECT * FROM $User WHERE id = '$id'",
    );

    // ignore: prefer_is_empty
    if (result.length > 0) {
      return User.fromMap(result[0]);
    }

    return null;
  }

  //update User
  static Future<int> editUser(
    int id,
    String username,
    String email,
    String password,
    String telephone,
    String bornDate,
  ) async {
    final db = await SQLHelper.db();
    final data = {
      'username': username,
      'email': email,
      'password': password,
      'telephone': telephone,
      'bornDate': bornDate
    };
    return await db.update('user', data, where: "id = $id");
  }

  //delete User
  static Future<int> deleteUser(int id) async {
    final db = await SQLHelper.db();
    return await db.delete('user', where: "id = $id");
  }

  //validate login
  static Future<User?> checkLogin(String username, String password) async {
    final db = await SQLHelper.db();
    var result = await db.rawQuery(
      "SELECT * FROM $User WHERE username = '$username' and password = '$password'",
    );

    // ignore: prefer_is_empty
    if (result.length > 0) {
      return User.fromMap(result[0]);
    }

    return null;
  }

  //unique username and email
  static Future<int> uniqueValidation(String element, String column) async {
    final db = await SQLHelper.db();
    var result = await db.rawQuery(
      "SELECT * FROM $User WHERE $column = '$element'",
    );

    return result.length;
  }

  // static Future<void> saveImage(String base64ImageInput, int userId) async {
  //   final db = await SQLHelper.db();
  //   await db.transaction(
  //     (txn) async {
  //       await txn.execute(
  //         "UPDATE $User SET imageData = $base64ImageInput' WHERE id = '$userId'",
  //       );
  //     },
  //   );
  // }

  static Future<int> editImage(
      String base64ImageInput, int userId, String username) async {
    final db = await SQLHelper.db();

    final data = {'imageData': base64ImageInput};

    return await db.update('user', data, where: 'id = ?', whereArgs: [userId]);
  }

  static Future<int> editPoin(int id, int poin) async {
    final db = await SQLHelper.db();
    final data = {'poin': poin};
    return await db.update('user', data, where: "id = $id");
  }
}
