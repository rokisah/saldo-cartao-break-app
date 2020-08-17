import 'dart:async';
import 'package:path/path.dart';
import 'package:saldo_cartao_break/models/card_info.dart';
import 'package:sqflite/sqflite.dart';

class CardInfoRepository {
  static const String CARD_INFO_TABLE = "card_info";

  Future<Database> get database async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'card_database.db'),
      onCreate: (db, version) {
        return db.execute("CREATE TABLE " +
            CARD_INFO_TABLE +
            "(id INTEGER PRIMARY KEY, name TEXT, userid TEXT, registerCode TEXT, accessCode TEXT)");
      },
      onUpgrade: (db, oldVersion, newVersion) {
        db.execute("ALTER TABLE " + CARD_INFO_TABLE + " ADD COLUMN access_valid INTEGER DEFAULT 0");
        db.execute("ALTER TABLE " + CARD_INFO_TABLE + " ADD COLUMN active INTEGER DEFAULT 0");
      },
      version: 2,
    );
    return database;
  }

  Future<void> save(CardInfo card) async {
    (await database).insert(CARD_INFO_TABLE, card.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<CardInfo>> getCards(String userId) async {
    final List<Map<String, dynamic>> maps = await (await database)
        .query(CARD_INFO_TABLE, where: "userId = ?", whereArgs: [userId]);
    return List.generate(maps.length, (i) => CardInfo.fromMap(maps[i]));
  }

  Future<List<CardInfo>> getActiveCard(String userId) async {
    final List<Map<String, dynamic>> maps = await (await database)
        .query(CARD_INFO_TABLE, where: "userId = ? AND active = 1 AND access_valid = 1", whereArgs: [userId]);
    return List.generate(maps.length, (i) => CardInfo.fromMap(maps[i]));
  }

  Future<void> delete(int id) async {
    await (await database).delete(CARD_INFO_TABLE, where: "id = ?", whereArgs: [id]);
  }

  void invalidateAccess(int id) async {
    await (await database).update(CARD_INFO_TABLE, {"access_valid": 0}, where: "id = ?", whereArgs: [id]);
  }

}