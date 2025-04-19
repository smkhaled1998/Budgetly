

import 'package:budget_buddy/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../repositories/transaction_repository.dart';

class TransactionUseCase {
  final TransactionRepository transactionRepository;

  TransactionUseCase({required this.transactionRepository});

  /// حذف مدخل مصروف بناءً على معرفه
  Future<Either<Failure, Unit>> call(int expenseEntryId) async {
    return await transactionRepository.deleteExpenseEntry(expenseEntryId);
  }
}
