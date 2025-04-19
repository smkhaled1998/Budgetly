import 'package:budget_buddy/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../entities/transaction_entity.dart';
import '../repositories/transaction_repository.dart'; // تأكد من استيراد الكيان المناسب

class TransactionUseCase {
  final TransactionRepository expenseEntryRepository;

  TransactionUseCase({required this.expenseEntryRepository});

  Future<Either<Failure, Unit>> call(TransactionEntity item) async {
    return await expenseEntryRepository.addExpenseEntry(item);
  }
}
