import 'dart:async';

import 'package:geeksynergy_avadhesh/data/database/sql.dart';
import 'package:geeksynergy_avadhesh/data/database/user.dart';
import 'package:geeksynergy_avadhesh/utils/utils.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  static DatabaseManager? _cacheManager;

  static Database? _database;
  List<String> entities = [
    Sql.createUserTable,
  ];

  DatabaseManager._createInstance();

  init() async {
    try {
      return await openDatabase(
        join(await getDatabasesPath(), 'avadhesh.db'),
        version: 1,
        onCreate: onCreate,
        onUpgrade: (db, oldVersion, newVersion) async {
          if (oldVersion < newVersion) {

          }
        },
      );
    } catch (error, stackTrace) {
      Utils.captureException(error, stackTrace);
    }
  }

  Future<void> onCreate(Database db, int version) async {
    try {
      for (var entity in entities) {
        await db.execute(entity);
      }
    } catch (error, stackTrace) {
      Utils.captureException(error, stackTrace);
    }
  }

  factory DatabaseManager() {
    try {
      _cacheManager = DatabaseManager._createInstance();
    } catch (error, stackTrace) {
      Utils.captureException(error, stackTrace);
    }
    return _cacheManager!;
  }

  Future<Database?> get database async {
    try {
      _database = await init();
    } catch (error, stackTrace) {
      Utils.captureException(error, stackTrace);
    }
    return _database;
  }

  Future<int?> insert(String tableName, Map entity) async {
    try {
      return await database.then((value) async => await value!.insert(
          tableName, entity as Map<String, Object?>,
          conflictAlgorithm: ConflictAlgorithm.replace));
    } catch (error, stackTrace) {
      Utils.captureException(error, stackTrace);
    }
    return null;
  }

  Future<void> updateValue(String tableName, String columnName,
      dynamic columnValue, String filterName, dynamic filterValue) async {
    try {
      await database.then((value) async => await value!.execute(
          "UPDATE $tableName SET $columnName= '$columnValue'  WHERE $filterName='$filterValue' "));
    } catch (error, stackTrace) {
      Utils.captureException(error, stackTrace);
    }
  }

  Future<dynamic> read(
      String tableName, String filterName, dynamic filterValue) async {
    try {
      await database.then((value) async {
        var ret = (await value!.query(tableName,
            where: "$filterName = ?", whereArgs: [filterValue]));
        return ret.isNotEmpty ? ret.first : [];
      });
    } catch (error, stackTrace) {
      Utils.captureException(error, stackTrace);
    }
  }

  Future<SqlUser?> readUser(String filterName, dynamic filterValue) async {
    SqlUser? user;
    try {
      Database? db = await database;
      if (db != null) {
        var ret = (await db.query(Sql.userTable,
            where: "$filterName = ?", whereArgs: [filterValue]));
        if (ret.isNotEmpty) {
          user = SqlUser.fromMap(ret.first);
        }
      }
    } catch (error, stackTrace) {
      Utils.captureException(error, stackTrace);
    }
    return user;
  }



  Future<void> delete(String tableName) async {
    try {
      await database.then((value) async => await value!.delete(tableName));
    } catch (error, stackTrace) {
      Utils.captureException(error, stackTrace);
    }
  }

  Future<void> deleteRow(String tableName, String id) async {
    try {
      await database
          .then((value) async => await value!.delete(tableName, where: id));
    } catch (error, stackTrace) {
      Utils.captureException(error, stackTrace);
    }
  }

  Future<int?> count(String tableName) async {
    int? count = 0;
    try {
      count = Sqflite.firstIntValue(await database.then((value) async =>
          await value!.rawQuery('SELECT COUNT(*) FROM $tableName')));
    } catch (error, stackTrace) {
      Utils.captureException(error, stackTrace);
    }
    return count;
  }

  Future<List<Map<String, Object?>>> readAll(String tableName) async =>
      await database.then((value) async => await value!.query(tableName));
}
