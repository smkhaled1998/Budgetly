import 'package:sqflite/sqflite.dart';
import '../../../../core/database_helper.dart';
import '../../../../core/error/exceptions.dart';

class UserInfoLocalDataSource {

  Future<List<Map<String, dynamic>>> getUserData(String query) async {
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

  Future<int> insertUserData(String query) async {
    try {
      Database? myDb = await DatabaseHelper.db;
      int response = await myDb!.rawInsert(query);
      print("***************************User Data inserted*************************");
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

  Future<int> deleteUserData(String query) async {
    try {
      Database? myDb = await DatabaseHelper.db;
      int response = await myDb!.rawDelete(query);
      print("User Data deleted");
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

  Future<int> updateUserData(String sql) async {
    try {
      Database? myDb = await DatabaseHelper.db;
      int response = await myDb!.rawUpdate(sql);
      print("User Data updated");
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
