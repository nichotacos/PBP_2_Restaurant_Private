import 'package:sqflite/sqflite.dart' as sql;

class SQLHelperChart {
  //create db
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
      CREATE TABLE toChart(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        quantity INTEGER,
        image TEXT,
        desc TEXT,
        price INT,
        id_user INTEGER,
        CONSTRAINT FK_id_user FOREIGN KEY (id_user) REFERENCES user(id)
      )
    """);
  }

  //call db
  static Future<sql.Database> db() async {
    return sql.openDatabase('toChart.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  //insert Employee
  static Future<int> addToChart(String name, int quantity, String image,
      String desc, int price, int id_user) async {
    final db = await SQLHelperChart.db();

    // Cek apakah "name" sudah ada dalam database
    final result =
        await db.query('toChart', where: 'name = ?', whereArgs: [name]);

    if (result.isNotEmpty) {
      // "name" sudah ada dalam database, maka ambil ID-nya
      int existingId = result.first['id'] as int;
      int existingQt = result.first['quantity'] as int;
      int Qt = existingQt + quantity;

      final data = {
        'name': name,
        'quantity': Qt,
        'image': image,
        'desc': desc,
        'price': price,
        'id_user': id_user
      };
      return await db.update('toChart', data, where: "id = $existingId");
    } else {
      // "name" belum ada dalam database, lakukan penambahan
      final data = {
        'name': name,
        'quantity': quantity,
        'image': image,
        'desc': desc,
        'price': price,
        'id_user': id_user
      };
      return await db.insert('toChart', data);
    }
  }

  //read Employee
  static Future<List<Map<String, dynamic>>> getChart() async {
    final db = await SQLHelperChart.db();
    return db.query('toChart');
  }

  //update Employee
  static Future<int> editChart(int id, String name, int quantity, String image,
      String desc, int price, int id_user) async {
    final db = await SQLHelperChart.db();
    final data = {
      'name': name,
      'quantity': quantity,
      'image': image,
      'desc': desc,
      'price': price,
      'id_user': id_user
    };
    return await db.update('toChart', data, where: "id = $id");
  }

  //delete Employee
  static Future<int> deleteChart(int id) async {
    final db = await SQLHelperChart.db();
    return await db.delete('toChart', where: "id = $id");
  }
}
