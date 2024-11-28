import 'package:sqflite/sqflite.dart';
import '../../../../core/database_helper.dart';
import '../../../../core/error/exceptions.dart';

class UserInfoDataSource {

  Future<List<Map<String, dynamic>>> getUserData() async {
    Database? myDb = await DatabaseHelper.db;

    try {

      return await myDb!.query("userInfo");

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

  Future<int> insertUserData({
  required String currency,
  required String monthlyBudget,
  required String userImg,
  required String userName,
}) async {
    Database? myDb = await DatabaseHelper.db;

    try {
      int response = await myDb!.insert("userInfo",{
        'currency':currency,
        'monthlyBudget':monthlyBudget,
        'userImg':userImg,
        'userName':userName,
      });
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
