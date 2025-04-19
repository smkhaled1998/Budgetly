import 'package:sqflite/sqflite.dart';

import '../../../../core/data/database/database_helper.dart';
import '../../../../core/error/exceptions.dart';

class TransactionDataSource {
  Future<List<Map<String, dynamic>>> fetchTransactions() async {
    Database? myDb = await DatabaseHelper.db;
    try {
      return await myDb!.query('transaction');
    } on DatabaseException catch (e) {
      throw DataRetrievalException("Failed to retrieve expense entry data: ${e.toString()}");
    }
  }

  Future<int> addTransaction( {
    required int categoryId,
    required double amount,
    required DateTime date,
    String? note,
  }) async {
    Database? myDb = await DatabaseHelper.db;
    try {
      return await myDb!.insert('transaction', {
        'categoryId': categoryId,
        'amount': amount,
        'date': date.toIso8601String(), // حفظ التاريخ كـ String
        'note': note,
      });
    } on DatabaseException catch (e) {
      throw DataInsertionException("Failed to add expense entry: ${e.toString()}");
    }
  }

  Future<int> editTransaction(int transactionId, {
    required int categoryId,
    required double amount,
    required DateTime date,
    String? note,
  }) async {
    Database? myDb = await DatabaseHelper.db;
    try {
      return await myDb!.update(
        'transaction',
        {
          'categoryId': categoryId,
          'amount': amount,
          'date': date.toIso8601String(),
          'note': note,
        },
        where: 'transactionId = ?',
        whereArgs: [transactionId],
      );
    } on DatabaseException catch (e) {
      throw DataUpdateException("Failed to update expense entry: ${e.toString()}");
    }
  }

  Future<int> deleteTransaction(int transactionId) async {
    Database? myDb = await DatabaseHelper.db;
    try {
      return await myDb!.delete(
        'expense_entry',
        where: 'expenseEntryId = ?',
        whereArgs: [transactionId],
      );
    } on DatabaseException catch (e) {
      throw DataDeletionException("Failed to delete expense entry: ${e.toString()}");
    }
  }
}
