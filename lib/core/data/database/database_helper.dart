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
        version: 2, // زيادة الإصدار من 1 إلى 2
        onCreate: _onCreate,
        onUpgrade: _onUpgrade, // إضافة دالة الترقية
        onOpen: (db) async {
          await db.execute('PRAGMA foreign_keys = ON');
        },
      );
      return myDb;
    } on DatabaseException catch (e) {
      if (e.isOpenFailedError()) {
        print("Database initialization failed: ${e.toString()}");
        await deleteDatabase(path);
        return await _initializeDb(); // محاولة إعادة إنشاء قاعدة البيانات
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
        subcategorySpentAmount REAL DEFAULT 0,
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
    try {
      print("Upgrading database from version $oldVersion to $newVersion");

      if (oldVersion < 2) {
        // التحقق من أعمدة جدول userInfo
        try {
          var userInfoColumns = await db.rawQuery('PRAGMA table_info(userInfo)');
          bool hasUserImg = userInfoColumns.any((column) => column['name'] == 'userImg');

          if (!hasUserImg) {
            await db.execute('ALTER TABLE userInfo ADD COLUMN userImg TEXT NOT NULL DEFAULT ""');
            print("Added userImg column to userInfo table");
          } else {
            print("userImg column already exists in userInfo table");
          }
        } catch (e) {
          print("Error checking userInfo table: $e");
        }

        // التحقق من أعمدة جدول subcategory
        try {
          var subcategoryColumns = await db.rawQuery('PRAGMA table_info(subcategory)');

          // التحقق من وجود عمود subcategorySpentAmount
          bool hasSubcategorySpentAmount = subcategoryColumns.any((column) => column['name'] == 'subcategorySpentAmount');
          if (!hasSubcategorySpentAmount) {
            await db.execute('ALTER TABLE subcategory ADD COLUMN subcategorySpentAmount REAL DEFAULT 0');
            print("Added subcategorySpentAmount column to subcategory table");
          } else {
            print("subcategorySpentAmount column already exists in subcategory table");
          }

          // التحقق من وجود عمود parentCategoryId
          bool hasParentCategoryId = subcategoryColumns.any((column) => column['name'] == 'parentCategoryId');
          if (!hasParentCategoryId) {
            await db.execute('ALTER TABLE subcategory ADD COLUMN parentCategoryId INTEGER NOT NULL DEFAULT 0');
            print("Added parentCategoryId column to subcategory table");
          } else {
            print("parentCategoryId column already exists in subcategory table");
          }
        } catch (e) {
          // إذا كان الخطأ بسبب عدم وجود جدول subcategory، فقم بإنشائه
          print("Error checking subcategory table: $e");

          // التحقق مما إذا كان جدول subcategory موجودًا
          var tables = await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table' AND name='subcategory'");

          if (tables.isEmpty) {
            await db.execute('''CREATE TABLE subcategory (
              subcategoryId INTEGER PRIMARY KEY AUTOINCREMENT,
              subcategoryName TEXT NOT NULL,
              subcategoryColor TEXT,
              subcategoryIcon TEXT,
              subcategorySpentAmount REAL DEFAULT 0,
              parentCategoryId INTEGER NOT NULL,
              FOREIGN KEY (parentCategoryId) REFERENCES category (categoryId) ON DELETE CASCADE
            )''');
            print("Created subcategory table from scratch");
          }
        }
      }

      print("Database upgraded successfully");
    } catch (e) {
      print("Error upgrading database: $e");
      throw SQLSyntaxException("Failed to upgrade database: ${e.toString()}");
    }
  }

  // إعادة إنشاء قاعدة البيانات (مسح وإعادة إنشاء)
  static Future<void> recreateDatabase() async {
    try {
      await removeDatabase();
      await _initializeDb();
      print("Database recreated successfully");
    } catch (e) {
      print("Error recreating database: $e");
      throw DatabaseInitializationException("Failed to recreate database: ${e.toString()}");
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