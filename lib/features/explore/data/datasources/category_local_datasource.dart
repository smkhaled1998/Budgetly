import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
      Database myDb = await openDatabase(path, onCreate: _onCreate,version: 1);
      return myDb;
    } catch (e) {
      print("Error opening category database: $e");
      throw Exception("Error opening category database");
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    try {
      await db.execute('''
        CREATE TABLE category (
          categoryId INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          color TEXT ,
          icon TEXT ,
          spent TEXT ,
          leftToSpend TEXT ,
          total TEXT NOT NULL
        )
      ''');
      print("Category Table successfully created");
    } catch (e) {
      print("Error creating category table: $e");
      throw Exception("Error creating category table");
    }
  }
  removeDataBase()async{
    String databasePath= await getDatabasesPath();
    String path =join(databasePath,"category.db");
    await deleteDatabase(path);

    print("=========== OnDelete ========");
  }

  Future<List<Map<String, dynamic>>> getCategoryData(String sql) async {
    try {
      Database? myDb = await db;
      return await myDb!.rawQuery(sql);
    } catch (e) {
      print("Error fetching category data: $e");
      throw Exception("Error fetching category data");
    }
  }

  Future<int> insertCategoryData(String sql) async {
    try {
      Database? myDb = await db;
      int response = await myDb!.rawInsert(sql);
      print("***************************Category Data inserted*************************");
      return response;
    } catch (e) {
      print("Error inserting category data: $e");
      throw Exception("Error inserting category data");
    }
  }

  Future<int> deleteCategoryData(String sql) async {
    try {
      Database? myDb = await db;
      int response = await myDb!.rawDelete(sql);
      print("Category Data deleted");
      return response;
    } catch (e) {
      print("Error deleting category data: $e");
      throw Exception("Error deleting category data");
    }
  }

  Future<int> updateCategoryData(String sql) async {
    try {
      Database? myDb = await db;
      int response = await myDb!.rawUpdate(sql);
      print("Category Data updated");
      return response;
    } catch (e) {
      print("Error updating category data: $e");
      throw Exception("Error updating category data");
    }
  }
}
