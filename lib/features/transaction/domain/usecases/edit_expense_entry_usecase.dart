
import 'package:budget_buddy/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../entities/transaction_entity.dart';
import '../repositories/transaction_repository.dart';

class TransactionEntryUseCase {
  final TransactionRepository transactionRepository;

  TransactionEntryUseCase({required this.transactionRepository});

  /// تعديل مدخل مصروف موجود
  Future<Either<Failure, Unit>> call(TransactionEntity item) async {
    return await transactionRepository.editExpenseEntry(item);
  }
}
