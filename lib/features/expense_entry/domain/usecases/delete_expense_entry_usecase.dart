

import 'package:budget_buddy/core/error/failures.dart';
import 'package:budget_buddy/features/expense_entry/domain/repositories/expense_entry_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteExpenseEntryUseCase {
  final ExpenseEntryRepository expenseEntryRepository;

  DeleteExpenseEntryUseCase({required this.expenseEntryRepository});

  /// حذف مدخل مصروف بناءً على معرفه
  Future<Either<Failure, Unit>> call(int expenseEntryId) async {
    return await expenseEntryRepository.deleteExpenseEntry(expenseEntryId);
  }
}
