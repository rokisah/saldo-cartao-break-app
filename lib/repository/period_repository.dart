import 'dart:async';
import 'package:path/path.dart';
import 'package:break_balance/models/period.dart';
import 'package:sqflite/sqflite.dart';

class PeriodRepository {
  static const String PERIOD_TABLE = "period";

  Future<Database> get database async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'card_database.db'),
      onCreate: (db, version) {
        return db.execute("CREATE TABLE " +
            PERIOD_TABLE +
            "(id INTEGER PRIMARY KEY, cardId INTEGER, month INTEGER, year INTEGER, text TEXT, value TEXT)");
      },
      onUpgrade: (db, oldVersion, newVersion) {
      },
      version: 1,
    );
    return database;
  }

  Future<void> save(Period period) async {
    (await database).insert(PERIOD_TABLE, period.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Period>> getPeriods(int cardId) async {
    final List<Map<String, dynamic>> maps = await (await database)
        .query(PERIOD_TABLE, where: "cardId = ?", whereArgs: [cardId]);
    return List.generate(maps.length, (i) => Period.fromMap(maps[i]));
  }

  Future<void> delete(int id) async {
    await (await database).delete(PERIOD_TABLE, where: "id = ?", whereArgs: [id]);
  }

}