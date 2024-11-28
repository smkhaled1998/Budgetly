import 'package:sqflite/sqflite.dart';

import '../../../../core/database_helper.dart';
import '../../../../core/error/exceptions.dart';

class ExpenseEntryDataSource {
  Future<List<Map<String, dynamic>>> getExpenseEntries() async {
    Database? myDb = await DatabaseHelper.db;
    try {
      return await myDb!.query('expense_entry');
    } on DatabaseException catch (e) {
      throw DataRetrievalException("Failed to retrieve expense entry data: ${e.toString()}");
    }
  }

  Future<int> addExpenseEntry( {
    required int categoryId,
    required double amount,
    required DateTime date,
    String? note,
  }) async {
    Database? myDb = await DatabaseHelper.db;
    try {
      // استخدام Map<String, dynamic> لإدخال البيانات
      return await myDb!.insert('expense_entry', {
        'categoryId': categoryId,
        'amount': amount,
        'date': date.toIso8601String(), // حفظ التاريخ كـ String
        'note': note,
      });
    } on DatabaseException catch (e) {
      throw DataInsertionException("Failed to add expense entry: ${e.toString()}");
    }
  }

  Future<int> editExpenseEntry(int expenseEntryId, {
    required int categoryId,
    required double amount,
    required DateTime date,
    String? note,
  }) async {
    Database? myDb = await DatabaseHelper.db;
    try {
      return await myDb!.update(
        'expense_entry',
        {
          'categoryId': categoryId,
          'amount': amount,
          'date': date.toIso8601String(),
          'note': note,
        },
        where: 'expenseEntryId = ?',
        whereArgs: [expenseEntryId],
      );
    } on DatabaseException catch (e) {
      throw DataUpdateException("Failed to update expense entry: ${e.toString()}");
    }
  }

  Future<int> deleteExpenseEntry(int expenseEntryId) async {
    Database? myDb = await DatabaseHelper.db;
    try {
      return await myDb!.delete(
        'expense_entry',
        where: 'expenseEntryId = ?',
        whereArgs: [expenseEntryId],
      );
    } on DatabaseException catch (e) {
      throw DataDeletionException("Failed to delete expense entry: ${e.toString()}");
    }
  }
}
