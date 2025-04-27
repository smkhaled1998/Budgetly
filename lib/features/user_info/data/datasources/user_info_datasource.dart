import 'package:sqflite/sqflite.dart';
import '../../../../core/data/database/database_helper.dart';
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

//   Future<int> insertUserData({
//   required String currency,
//   required String monthlySalary,
//   required String userImg,
//   required String userName,
// }) async {
//     Database? myDb = await DatabaseHelper.db;
//
//     try {
//       int response = await myDb!.insert("userInfo",{
//         'currency':currency,
//         'monthlySalary':monthlySalary,
//         'userImg':userImg,
//         'userName':userName,
//       });
//       print("***************************User Data inserted*************************");
//       return response;
//     } on DatabaseException catch (e) {
//       if (e.isSyntaxError()) {
//         throw SQLSyntaxException();
//       } else {
//         throw DataInsertionException();
//       }
//     } catch (e) {
//       throw DataRetrievalException();
//     }
//   }
   Future<void> insertUserData({
    required String userName,
    required String userImg,
    required String monthlySalary,
    required String currency,
  }) async {
    final db = await DatabaseHelper.db;
    try {
      // حذف أي بيانات موجودة مسبقًا
      await db!.delete('userInfo');
      print("Previous user data deleted successfully");

      // إدراج بيانات المستخدم الجديد
      await db.insert(
        'userInfo',
        {
          'userName': userName,
          'userImg': userImg,
          'monthlySalary': monthlySalary,
          'currency': currency,
          'storedSpentAmount': 0.0, // القيمة الافتراضية
        },
        conflictAlgorithm: ConflictAlgorithm.replace, // استبدال البيانات إذا كان هناك تعارض
      );
      print("New user info inserted successfully");
    } catch (e) {
      print("Error inserting user info: $e");
      throw DataInsertionException("Failed to insert user info: ${e.toString()}");
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
