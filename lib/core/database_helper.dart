// lib/core/database_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'error/exceptions.dart';

class DatabaseHelper {
  static Database? _db;

  static Future<Database?> get db async {
    if (_db == null) {
      _db = await _initializeDb();
      return _db;
    }
    return _db;
  }

  static Future<Database> _initializeDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'budgettly.db');
    try {
      Database myDb = await openDatabase(
        path,
        version: 1,
        onCreate: _onCreate,
      );
      return myDb;
    } on DatabaseException catch (e) {
      if (e.isOpenFailedError()) {
        throw DatabaseInitializationException();
      } else {
        throw QueryExecutionException();
      }
    } catch (e) {
      throw Exception("Unknown error opening database");
    }
  }

  static Future<void> _onCreate(Database db, int version) async {
    try {
      await db.execute('''
        CREATE TABLE category (
          categoryId INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          color TEXT,
          icon TEXT,
          spent TEXT,
          leftToSpend TEXT,
          categorySlice TEXT
        )
      ''');
      await db.execute('''
        CREATE TABLE userInfo (
          userId INTEGER PRIMARY KEY AUTOINCREMENT,
          userName TEXT NOT NULL,
          monthlyBudget TEXT NOT NULL,
          currency TEXT NOT NULL,
          spentAmount TEXT NOT NULL
        )
      ''');
      print("Tables successfully created");
    } on DatabaseException catch (e) {
      print("SQLSyntaxException + $e");
      throw SQLSyntaxException();
    }
  }

  static Future<void> removeDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "budgettly.db");
    await deleteDatabase(path);
    print("=========== OnDelete ========");
  }
}
