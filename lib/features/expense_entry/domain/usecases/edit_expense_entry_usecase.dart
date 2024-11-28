
import 'package:budget_buddy/core/error/failures.dart';
import 'package:budget_buddy/features/expense_entry/domain/entities/expense_entry_entity.dart';
import 'package:budget_buddy/features/expense_entry/domain/repositories/expense_entry_repository.dart';
import 'package:dartz/dartz.dart';

class EditExpenseEntryUseCase {
  final ExpenseEntryRepository expenseEntryRepository;

  EditExpenseEntryUseCase({required this.expenseEntryRepository});

  /// تعديل مدخل مصروف موجود
  Future<Either<Failure, Unit>> call(ExpenseEntryEntity item) async {
    return await expenseEntryRepository.editExpenseEntry(item);
  }
}
