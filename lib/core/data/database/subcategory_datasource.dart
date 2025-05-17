import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';
import '../../error/exceptions.dart';

class SubcategoryDataSource {
  Future<List<Map<String, dynamic>>> getSubcategoriesData() async {
    Database? myDb = await DatabaseHelper.db;
    try {
      return await myDb!.query('subcategory');
    } on DatabaseException catch (e) {
      throw DataRetrievalException("Failed to retrieve sub-category data: ${e.toString()}");
    }
  }

  // إدراج فئة فرعية جديدة
  Future<int> insertNewSubcategory({
    required String subcategoryName,
    required String subcategoryColor,
    required String subcategoryIcon,
    required int parentCategoryId,
  }) async {
    Database? myDb = await DatabaseHelper.db;
    try {
      // FIXED: Remove the subcategorySpentAmount field if it doesn't exist in the schema
      int response = await myDb!.insert('subcategory', {
        'subcategoryName': subcategoryName,
        'subcategoryColor': subcategoryColor,
        'subcategoryIcon': subcategoryIcon,
        'parentCategoryId': parentCategoryId, // ربط الفئة الفرعية بالفئة الرئيسية
      });
      print("Sub-category data inserted");
      return response;
    } on DatabaseException catch (e) {
      throw DataInsertionException("Failed to insert sub-category data: ${e.toString()}");
    }
  }

  // حذف فئة فرعية بناءً على معرفها
  Future<int> deleteSubcategoryData(int subcategoryId) async {
    Database? myDb = await DatabaseHelper.db;
    try {
      int response = await myDb!.delete(
        'subcategory',
        where: 'subcategoryId = ?',
        whereArgs: [subcategoryId],
      );
      print("Sub-category data deleted");
      return response;
    } on DatabaseException catch (e) {
      throw DataDeletionException("Failed to delete sub-category data: ${e.toString()}");
    }
  }

  // تحديث بيانات فئة فرعية
  Future<int> updateSubcategoryData({
    required int subcategoryId,
    required Map<String, dynamic> updatedFields,
  }) async {
    Database? myDb = await DatabaseHelper.db;
    try {
      // تحديث الحقول المحددة فقط
      int response = await myDb!.update(
        'subcategory',
        updatedFields,
        where: 'subcategoryId = ?',
        whereArgs: [subcategoryId],
      );
      print("Sub-category data updated with fields: $updatedFields");
      return response;
    } on DatabaseException catch (e) {
      throw DataUpdateException("Failed to update sub-category data: ${e.toString()}");
    }
  }
}