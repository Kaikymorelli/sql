import 'dart:js_interop_unsafe';
import 'package:flutter/foundation.dart';
import 'package:fluttersql/sqflite.dart' as sql;

class SqlDb {
  static Future<void> createTables(sql.Database database) async {
    await database.execute(""" CREATE TABLE tutorial(
    id INTERGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title TEXT,
    description TEXT,
    createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )
   """ );
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'dbteste.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      }
    );
  }

  static Future<int> insert(String title, String? descrption) async {
    final db = await SqlDb.db();

    final data = {'title': title, 'descriptions': descrption};
    final id = await db.insert('items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future <List<Map<String, dynamic>>> buscarTodos() async {
    final db = await SqlDb.db();
    return db.query('items', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> buscaPorItem(int id) async {
    final db = await SqlDb.db();
    return db.query('items', where: "id = ?", whereArgs: [id], limit: 1 );
  }

  static Future<int> atualizaItem(
      int id, String title, String? descrption) async {
    final db = await SqlDb.db();

    final data = {
      'title': title,
      'description': descrption,
      'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update('items', data, where: "id = ?", whereArgs: [id] );
    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await SqlDb.db();
    try{
      await db.delete("items", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Algo deu errado na exclusao do item: $err");
    }
  }


}