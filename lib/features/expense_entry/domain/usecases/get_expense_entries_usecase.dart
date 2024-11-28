import 'package:budget_buddy/core/error/failures.dart';
import 'package:budget_buddy/features/expense_entry/domain/entities/expense_entry_entity.dart';
import 'package:budget_buddy/features/expense_entry/domain/repositories/expense_entry_repository.dart';
import 'package:dartz/dartz.dart';

class GetExpenseEntriesUseCase {
  final ExpenseEntryRepository expenseEntryRepository;

  GetExpenseEntriesUseCase({required this.expenseEntryRepository});

  /// استرجاع قائمة من مدخلات المصروفات
  Future<Either<Failure, List<ExpenseEntryEntity>>> call() async {
    return await expenseEntryRepository.getExpenseEntries();
  }
}
