import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../error/exceptions.dart';

class DatabaseHelper {
  static Database? _db;

  // Getter للحصول على مثيل قاعدة البيانات
  static Future<Database?> get db async {
    if (_db == null) {
      _db = await _initializeDb();
      return _db;
    }
    return _db;
  }

  // تهيئة قاعدة البيانات
  static Future<Database> _initializeDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'budgettly.db');
    try {
      Database myDb = await openDatabase(
        path,
        version: 1, // زيادة الإصدار
        onCreate: _onCreate,
        onUpgrade: _onUpgrade, // إضافة دالة الترقية
        onOpen: (db) async {
          await db.execute('PRAGMA foreign_keys = ON');
        },
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

  // إنشاء الجداول عند تشغيل التطبيق لأول مرة
  static Future<void> _onCreate(Database db, int version) async {
    try {
      // إنشاء جدول الفئات الرئيسية
      await db.execute('''CREATE TABLE category (
        categoryId INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        color TEXT,
        icon TEXT,
        allocatedAmount REAL NOT NULL,
        storedSpentAmount REAL NOT NULL DEFAULT 0
      )''');

      // إنشاء جدول الفئات الفرعية مع ربطه بجدول الفئات الرئيسية
      await db.execute('''CREATE TABLE subcategory (
        subcategoryId INTEGER PRIMARY KEY AUTOINCREMENT,
        subcategoryName TEXT NOT NULL,
        subcategoryColor TEXT,
        subcategoryIcon TEXT,
        subcategorySpentAmount TEXT
        parentCategoryId INTEGER NOT NULL,
        FOREIGN KEY (parentCategoryId) REFERENCES category (categoryId) ON DELETE CASCADE
      )''');

      // إنشاء جدول معلومات المستخدم
      await db.execute('''CREATE TABLE userInfo (
        userId INTEGER PRIMARY KEY AUTOINCREMENT,
        userName TEXT NOT NULL,
        userImg TEXT NOT NULL,
        monthlySalary TEXT NOT NULL,
        currency TEXT NOT NULL,
        storedSpentAmount REAL NOT NULL DEFAULT 0
      )''');

      // إنشاء جدول المدخلات المالية (المصروفات)
      await db.execute('''CREATE TABLE `transaction` (
        transactionId INTEGER PRIMARY KEY AUTOINCREMENT,
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

  // تحديث الجداول عند زيادة إصدار قاعدة البيانات
  static Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      try {
        // إضافة عمود userImg إلى الجدول userInfo
        await db.execute('ALTER TABLE userInfo ADD COLUMN userImg TEXT NOT NULL DEFAULT ""');
        print("Table userInfo upgraded successfully");
      } catch (e) {
        print("Error upgrading table userInfo: $e");
        throw SQLSyntaxException("Failed to upgrade table userInfo: ${e.toString()}");
      }
    }
  }

  // حذف قاعدة البيانات
  static Future<void> removeDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "budgettly.db");
    await deleteDatabase(path);
    print("Database deleted");
  }
}