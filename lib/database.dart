import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'Expense.dart';

class DatabaseProvider {
  static const _databaseName = "event.db";
  static const _tableName = "expense";
  static const _colId = "id";
  static const _colExpense = "expense";
  static final DatabaseProvider dbProvider = DatabaseProvider();
  late Future<Database> _database;
  void createDatabase() async {
    final path = await getDatabasesPath();
    _database = openDatabase(join(path, _databaseName), version: 1,
        onCreate: ((db, version) {
      return db.execute(
        'CREATE TABLE expense(id INTEGER PRIMARY KEY, expense TEXT, amount TEXT)',
      );
    }));
  }

  // Define a function that inserts dogs into the database
  Future<void> insertExpense(Expense expense) async {
    // Get a reference to the database.
    final db = await _database;
    await db.insert(
      _tableName,
      expense.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //list the expense
  Future<List<Expense>> getExpense() async {
    // Get a reference to the database.
    final db = await _database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('expense');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Expense(
        id: maps[i]['id'],
        expense: maps[i]['expense'],
        amount: maps[i]['amount'],
      );
    });
  }
}
