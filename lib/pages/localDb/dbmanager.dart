import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'favouriteModel.dart';

class DbFavouriteManager {
  Database? _database;

  Future openDb() async {
    if (_database == null) {
      _database = await openDatabase(
          join(await getDatabasesPath(), "favourite.db"),
          version: 1, onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE favourite(id INTEGER PRIMARY KEY autoincrement, product_id INTEGER ,product_name TEXT, product_image TEXT, size TEXT, thickness TEXT, finish TEXT,category_id INTEGER, category_name TEXT)",
        );
      });
    }
  }

  Future<int?> insertStudent(FavouriteModel student) async {
    await openDb();
    print(student);
    return await _database?.insert('favourite', student.toMap());
  }

  Future<List<FavouriteModel>> getAllFavouriteList() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database!.query('favourite');
    return List.generate(maps.length, (i) {
      return FavouriteModel(
          product_id: maps[i]['product_id'],
          product_name: maps[i]['product_name'],
          product_image: maps[i]['product_image'],
          size: maps[i]['size'],
          thickness: maps[i]['thickness'],
          finish: maps[i]['finish'],
          category_id: maps[i]['category_id'],
          category_name: maps[i]['category_name']);
    });
  }

  Future<void> deleteFavourite(int category_id, int product_id) async {
    await openDb();
    await _database?.delete('favourite',
        where: "category_id = ? and product_id = ?",
        whereArgs: [category_id, product_id]);
  }

  Future<int> getCount(int categoryId, int productId) async {
    //database connection
    await openDb();
    Database? db = _database;
    var x = await db!.rawQuery(
        'SELECT COUNT (*) from favourite where category_id =$categoryId and product_id=$productId');
    int? count = Sqflite.firstIntValue(x);
    print("COUNT ------==========$count");
    return count ?? 0;
  }
}
