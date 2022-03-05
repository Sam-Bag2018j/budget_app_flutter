import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;

class DatabaseHelper {
  static var date;
  static var price;
  static var note;
  static var icon;
  static Future<void> creeatTables(sql.Database database) async {
    await database.execute(""" CREATE TABLE items(
     id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    price INTEGER,
    note TEXT,
    date STRING,
    icon STRING
    )""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'Samera Sqlite Test',
      version: 1,
      onCreate: (sql.Database database, int version) async =>
          await creeatTables(database),
    );
  }

  static Future<int> creatItem(
      int price, String note, String icon, String date) async {
    final db = await DatabaseHelper.db();
    final data = {'price': price, 'note': note, 'icon': icon, 'date': date};
    final id = await db.insert('items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await DatabaseHelper.db();
    return db.query('items', orderBy: "id");
  }

  // Read a single item by id
  // The app doesn't use this method but I put here in case you want to see it
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await DatabaseHelper.db();
    return db.query('items', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(
      int id, int price, String note, String icon, String date) async {
    final db = await DatabaseHelper.db();

    final data = {
      'price': price,
      'note': note,
      'icon': icon,
      'date': date,
    };

    final result =
        await db.update('items', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await DatabaseHelper.db();
    try {
      await db.delete("items", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
