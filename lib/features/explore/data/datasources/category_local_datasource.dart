import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../../../core/error/exceptions.dart';

class CategoryLocalDataSource {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  Future<Database> initialDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'category.db');
    try {
      Database myDb = await openDatabase(path, onCreate: _onCreate, version: 1);
      return myDb;
    } on DatabaseException catch (e) {
      if (e.isOpenFailedError()) {
        throw DatabaseInitializationException();
      } else {
        throw QueryExecutionException();
      }
    } catch (e) {
      throw Exception("Unknown error opening category database");
    }
  }

  Future<void> _onCreate(Database db, int version) async {
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
      print("Category Table successfully created");
    } on DatabaseException catch (e) {
      print("SQLSyntaxException + $e");
      throw SQLSyntaxException();
    }
  }

  Future<void> removeDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "category.db");
    await deleteDatabase(path);
    print("=========== OnDelete ========");
  }

  Future<List<Map<String, dynamic>>> getCategoryData(String query) async {
    try {
      Database? myDb = await db;
      return await myDb!.rawQuery(query);
    } on DatabaseException catch (e) {
      if (e.isSyntaxError()) {
        throw SQLSyntaxException();
      } else if (e.isOpenFailedError()) {
        throw DatabaseInitializationException();
      } else {
        throw QueryExecutionException();
      }
    } catch (e) {
      throw DataRetrievalException();
    }
  }

  Future<int> insertCategoryData(String query) async {
    try {
      Database? myDb = await db;
      int response = await myDb!.rawInsert(query);
      print("***************************Category Data inserted*************************");
      return response;
    } on DatabaseException catch (e) {
      if (e.isSyntaxError()) {
        throw SQLSyntaxException();
      } else {
        throw DataInsertionException();
      }
    } catch (e) {
      throw DataRetrievalException();
    }
  }

  Future<int> deleteCategoryData(String query) async {
    try {
      Database? myDb = await db;
      int response = await myDb!.rawDelete(query);
      print("Category Data deleted");
      return response;
    } on DatabaseException catch (e) {
      if (e.isSyntaxError()) {
        throw SQLSyntaxException();
      } else {
        throw DataDeletionException();
      }
    } catch (e) {
      throw DataRetrievalException();
    }
  }

  Future<int> updateCategoryData(String sql) async {
    try {
      Database? myDb = await db;
      int response = await myDb!.rawUpdate(sql);
      print("Category Data updated");
      return response;
    } on DatabaseException catch (e) {
      if (e.isSyntaxError()) {
        throw SQLSyntaxException();
      } else {
        throw DataUpdateException();
      }
    } catch (e) {
      throw DataRetrievalException();
    }
  }
}
