import 'package:budget_buddy/features/category/domain/entities/category_entity.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../../../../core/database_helper.dart';
import '../../../../core/error/exceptions.dart';

class CategoryDataSource {

  Future<List<Map<String, dynamic>>> getCategoryData() async {
    Database? myDb = await DatabaseHelper.db;
    try {
      return await myDb!.query('category');
    } on DatabaseException catch (e) {
      throw DataRetrievalException("Failed to retrieve category data: ${e.toString()}");
    }
  }

  Future<int> insertNewCategory({
    required String name,
    required String color,
    required String icon,
    required double allocatedAmount,
  }) async {
    Database? myDb = await DatabaseHelper.db;
    try {
      int response = await myDb!.insert('category', {
        'name': name,
        'color': color,
        'icon': icon,
        'allocatedAmount': allocatedAmount.toString(),
        'spentAmount': 0.0, // تعيين spentAmount إلى 0 عند الإدخال الأولي
      });
      print("Category data inserted");
      return response;
    } on DatabaseException catch (e) {
      throw DataInsertionException("Failed to insert category data: ${e.toString()}");
    }
  }

  Future<int> deleteCategoryData(int categoryId) async {
    Database? myDb = await DatabaseHelper.db;
    try {
      int response = await myDb!.delete(
        'category',
        where: 'categoryId = ?',
        whereArgs: [categoryId],
      );
      print("Category data deleted");
      return response;
    } on DatabaseException catch (e) {
      throw DataDeletionException("Failed to delete category data: ${e.toString()}");
    }
  }

  Future<int> updateCategoryData({
    required int categoryId,
    required Map<String, dynamic> updatedFields,
  }) async {
    Database? myDb = await DatabaseHelper.db;
    try {
      // تحديث الحقول المحددة فقط
      int response = await myDb!.update(
        'category',
        updatedFields,
        where: 'categoryId = ?',
        whereArgs: [categoryId],
      );
      print("Category data updated with fields: $updatedFields");
      return response;
    } on DatabaseException catch (e) {
      throw DataUpdateException("Failed to update category data: ${e.toString()}");
    }
  }

  Future<int> initializeCategoriesData({
    required List<CategoryEntity> categories,
  }) async {
    Database? myDb = await DatabaseHelper.db;
    try {
      // استخدام Batch لإضافة جميع الفئات أو تحديثها
      Batch batch = myDb!.batch();

      for (var category in categories) {
        // التأكد من وجود الفئة في قاعدة البيانات
        final existingCategory = await myDb.query(
          'category',
          where: 'categoryId = ?',
          whereArgs: [category.categoryId],
        );

        if (existingCategory.isNotEmpty) {
          // تحديث السجل إذا كان موجودًا
          batch.update(
            'category',
            {
              'name': category.name,
              'color': category.color,
              'icon': category.icon,
              'allocatedAmount': category.allocatedAmount.toString(),
              'spentAmount': category.spentAmount.toString(),
            },
            where: 'categoryId = ?',
            whereArgs: [category.categoryId],
          );
        } else {
          // إدخال سجل جديد إذا لم يكن موجودًا
          batch.insert(
            'category',
            {
              'name': category.name,
              'color': category.color,
              'icon': category.icon,
              'allocatedAmount': category.allocatedAmount.toString(),
              'spentAmount': category.spentAmount.toString(),
            },
          );
        }
      }

      // تنفيذ العمليات دفعة واحدة
      await batch.commit(noResult: true);
      print("All categories initialized/updated successfully");
      return categories.length;
    } on DatabaseException catch (e) {
      throw DataInsertionException("Failed to initialize categories data: ${e.toString()}");
    }
  }

  Future<int> updateSpentAmount({
    required int categoryId,
    required double spentAmount,
  }) async {
    Database? myDb = await DatabaseHelper.db;
    try {
      int response = await myDb!.update(
        'category',
        {
          'spentAmount': spentAmount,
        },
        where: 'categoryId = ?',
        whereArgs: [categoryId],
      );
      print("Spent amount updated");
      return response;
    } on DatabaseException catch (e) {
      throw DataUpdateException("Failed to update spent amount: ${e.toString()}");
    }
  }

  Future<Map<String, dynamic>?> getCategoryById(int categoryId) async {
    Database? myDb = await DatabaseHelper.db;
    try {
      final response = await myDb!.query(
        'category',
        where: 'categoryId = ?',
        whereArgs: [categoryId],
      );
      if (response.isNotEmpty) {
        return response.first;
      } else {
        return null;
      }
    } on DatabaseException catch (e) {
      throw DataRetrievalException("Failed to retrieve category by ID: ${e.toString()}");
    }
  }
}
