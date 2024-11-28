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
        throw DatabaseInitializationException("Failed to initialize or open database.");
      } else {
        throw QueryExecutionException("Query execution failed: ${e.toString()}");
      }
    } catch (e) {
      throw Exception("Unknown error opening database: ${e.toString()}");
    }
  }

  static Future<void> _onCreate(Database db, int version) async {
    try {
      // إنشاء جدول الفئات
      await db.execute('''CREATE TABLE category (
        categoryId INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        color TEXT,
        icon TEXT,
        allocatedAmount REAL NOT NULL,
        spentAmount REAL NOT NULL DEFAULT 0
      )''');

      // إنشاء جدول معلومات المستخدم
      await db.execute('''CREATE TABLE userInfo (
        userId INTEGER PRIMARY KEY AUTOINCREMENT,
        userName TEXT NOT NULL,
        monthlyBudget REAL NOT NULL,
        currency TEXT NOT NULL,
        spentAmount REAL NOT NULL DEFAULT 0
      )''');

      // إنشاء جدول المعاملات
      await db.execute('''CREATE TABLE transactions (
        transactionId INTEGER PRIMARY KEY AUTOINCREMENT,
        categoryId INTEGER NOT NULL,
        amount REAL NOT NULL,
        date TEXT NOT NULL,
        FOREIGN KEY (categoryId) REFERENCES category (categoryId) ON DELETE CASCADE
      )''');

      // إنشاء جدول مصروفات المدخلات
      await db.execute('''CREATE TABLE expense_entry (
        expenseEntryId INTEGER PRIMARY KEY AUTOINCREMENT,
        categoryId INTEGER NOT NULL,
        amount REAL NOT NULL,
        date TEXT NOT NULL,
        note TEXT,
        FOREIGN KEY (categoryId) REFERENCES category (categoryId) ON DELETE CASCADE
      )''');

      print("Tables successfully created");
    } on DatabaseException catch (e) {
      throw SQLSyntaxException("SQL syntax error: ${e.toString()}");
    }
  }

  static Future<void> removeDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "budgettly.db");
    await deleteDatabase(path);
    print("Database deleted");
  }
}
