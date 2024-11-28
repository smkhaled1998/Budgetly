import 'package:budget_buddy/core/error/failures.dart';
import 'package:budget_buddy/features/expense_entry/domain/repositories/expense_entry_repository.dart';
import 'package:dartz/dartz.dart';
import '../entities/expense_entry_entity.dart'; // تأكد من استيراد الكيان المناسب

class AddExpenseEntryUseCase {
  final ExpenseEntryRepository expenseEntryRepository;

  AddExpenseEntryUseCase({required this.expenseEntryRepository});

  Future<Either<Failure, Unit>> call(ExpenseEntryEntity item) async {
    return await expenseEntryRepository.addExpenseEntry(item);
  }
}
