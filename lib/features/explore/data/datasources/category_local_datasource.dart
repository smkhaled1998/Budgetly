// lib/features/categories/data/datasources/category_local_data_source.dart
import 'package:sqflite/sqflite.dart';
import '../../../../core/database_helper.dart';
import '../../../../core/error/exceptions.dart';

class CategoryLocalDataSource {
  Future<List<Map<String, dynamic>>> getCategoryData(String query) async {
    try {
      Database? myDb = await DatabaseHelper.db;
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
      Database? myDb = await DatabaseHelper.db;
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
      Database? myDb = await DatabaseHelper.db;
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
      Database? myDb = await DatabaseHelper.db;
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
