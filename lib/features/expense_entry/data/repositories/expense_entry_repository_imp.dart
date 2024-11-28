import 'package:budget_buddy/features/expense_entry/domain/entities/expense_entry_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/expense_entry_repository.dart';
import '../datasources/expense_entry_datasource.dart';
import '../models/expense_entery_model.dart';

class ExpenseEntryRepositoryImpl implements ExpenseEntryRepository {
  final ExpenseEntryDataSource localDataSource;

  ExpenseEntryRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, Unit>> addExpenseEntry(ExpenseEntryEntity item) async {
    try {
      await localDataSource.addExpenseEntry(
          categoryId: item.categoryId,
          amount: item.amount,
          date: item.date,
          note: item.note);
      return Right(unit);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(
          message: "Failed to add expense entry: ${e.toString()}"));
    } catch (e) {
      return Left(DatabaseFailure(
          message: "An unknown error occurred while adding expense entry."));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteExpenseEntry(int expenseEntryId) async {
    try {
      await localDataSource.deleteExpenseEntry(expenseEntryId);
      return Right(unit);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(
        message: "Failed to delete expense entry: ${e.toString()}",
      ));
    } catch (e) {
      return Left(DatabaseFailure(
          message: "An unknown error occurred while deleting expense entry."));
    }
  }

  @override
  Future<Either<Failure, Unit>> editExpenseEntry(
      ExpenseEntryEntity item) async {
    try {
      final expenseEntryModel = ExpenseEntryModel(
        categoryId: item.categoryId,
        amount: item.amount,
        date: item.date,
        note: item.note,
        expenseEntryId: item.expenseEntryId,
      );

      await localDataSource.editExpenseEntry(item.expenseEntryId!,
          date: item.date,
          amount: item.amount,
          categoryId: item.categoryId,
          note: item.note);
      return Right(unit);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(
          message: "Failed to edit expense entry: ${e.toString()}"));
    } catch (e) {
      return Left(DatabaseFailure(
          message: "An unknown error occurred while editing expense entry."));
    }
  }

  @override
  Future<Either<Failure, List<ExpenseEntryEntity>>> getExpenseEntries() async {
    try {
      final entries = await localDataSource.getExpenseEntries();
      // تحويل القائمة من نموذج قاعدة البيانات إلى كائنات الكيان
      final expenseEntries =
          entries.map((entry) => ExpenseEntryModel.fromJson(entry)).toList();
      return Right(expenseEntries);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(
          message: "Failed to retrieve expense entries: ${e.toString()}"));
    } catch (e) {
      return Left(DatabaseFailure(
          message:
              "An unknown error occurred while retrieving expense entries."));
    }
  }
}
