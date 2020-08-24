import 'dart:async';
import 'package:path/path.dart';
import 'package:break_balance/models/card_transaction.dart';
import 'package:sqflite/sqflite.dart';

class CardTransactionRepository {
  static const String CARD_TRANSACTION_TABLE = "card_transaction";

  Future<Database> get database async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'card_database.db'),
      onCreate: (db, version) {
        return db.execute("CREATE TABLE " +
            CARD_TRANSACTION_TABLE +
            "(id INTEGER PRIMARY KEY, cardId INTEGER, periodId INTEGER, date INTEGER, valueDate INTEGER, description TEXT, debit REAL, credit REAL, category INTEGER)");
      },
      onUpgrade: (db, oldVersion, newVersion) {
      },
      version: 1,
    );
    return database;
  }

  Future<void> save(CardTransaction transaction) async {
    (await database).insert(CARD_TRANSACTION_TABLE, transaction.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<CardTransaction>> getTransactions(int periodId) async {
    final List<Map<String, dynamic>> maps = await (await database)
        .query(CARD_TRANSACTION_TABLE, where: "periodId = ?", whereArgs: [periodId]);
    return List.generate(maps.length, (i) => CardTransaction.fromMap(maps[i]));
  }

  Future<void> delete(int id) async {
    await (await database).delete(CARD_TRANSACTION_TABLE, where: "id = ?", whereArgs: [id]);
  }

}