import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/expense_entry_entity.dart';

abstract class ExpenseEntryRepository{

  Future<Either<Failure,List<ExpenseEntryEntity>>> getExpenseEntries();
  Future<Either<Failure,Unit>> editExpenseEntry(ExpenseEntryEntity item);
  Future<Either<Failure,Unit>> deleteExpenseEntry(int categoryId);
  Future<Either<Failure,Unit>> addExpenseEntry(ExpenseEntryEntity item);


}