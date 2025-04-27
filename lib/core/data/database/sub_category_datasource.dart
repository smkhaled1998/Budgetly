import 'package:sqflite/sqflite.dart';
import '../../domain/entities/sub_category-entity.dart';
import 'database_helper.dart';
import '../../error/exceptions.dart';

class SubCategoryDataSource {
  // استرداد جميع الفئات الفرعية من قاعدة البيانات
  Future<List<Map<String, dynamic>>> getSubCategoriesData() async {
    Database? myDb = await DatabaseHelper.db;
    try {
      return await myDb!.query('subCategory');
    } on DatabaseException catch (e) {
      throw DataRetrievalException("Failed to retrieve sub-category data: ${e.toString()}");
    }
  }

  // إدراج فئة فرعية جديدة
  Future<int> insertNewSubCategory({
    required String subCategoryName,
    required String subCategoryColor,
    required String subCategoryIcon,
    required int categoryId,
  }) async {
    Database? myDb = await DatabaseHelper.db;
    try {
      int response = await myDb!.insert('subCategory', {
        'subCategoryName': subCategoryName,
        'subCategoryColor': subCategoryColor,
        'subCategoryIcon': subCategoryIcon,
        'categoryId': categoryId, // ربط الفئة الفرعية بالفئة الرئيسية
      });
      print("Sub-category data inserted");
      return response;
    } on DatabaseException catch (e) {
      throw DataInsertionException("Failed to insert sub-category data: ${e.toString()}");
    }
  }

  // حذف فئة فرعية بناءً على معرفها
  Future<int> deleteSubCategoryData(int subCategoryId) async {
    Database? myDb = await DatabaseHelper.db;
    try {
      int response = await myDb!.delete(
        'subCategory',
        where: 'subCategoryId = ?',
        whereArgs: [subCategoryId],
      );
      print("Sub-category data deleted");
      return response;
    } on DatabaseException catch (e) {
      throw DataDeletionException("Failed to delete sub-category data: ${e.toString()}");
    }
  }

  // تحديث بيانات فئة فرعية
  Future<int> updateSubCategoryData({
    required int subCategoryId,
    required Map<String, dynamic> updatedFields,
  }) async {
    Database? myDb = await DatabaseHelper.db;
    try {
      // تحديث الحقول المحددة فقط
      int response = await myDb!.update(
        'subCategory',
        updatedFields,
        where: 'subCategoryId = ?',
        whereArgs: [subCategoryId],
      );
      print("Sub-category data updated with fields: $updatedFields");
      return response;
    } on DatabaseException catch (e) {
      throw DataUpdateException("Failed to update sub-category data: ${e.toString()}");
    }
  }

  // استرداد فئة فرعية بناءً على معرفها
  Future<Map<String, dynamic>?> getSubCategoryById(int subCategoryId) async {
    Database? myDb = await DatabaseHelper.db;
    try {
      final response = await myDb!.query(
        'subCategory',
        where: 'subCategoryId = ?',
        whereArgs: [subCategoryId],
      );
      if (response.isNotEmpty) {
        return response.first;
      } else {
        return null;
      }
    } on DatabaseException catch (e) {
      throw DataRetrievalException("Failed to retrieve sub-category by ID: ${e.toString()}");
    }
  }


}