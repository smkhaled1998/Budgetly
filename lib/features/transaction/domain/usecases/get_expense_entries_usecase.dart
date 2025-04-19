import 'package:budget_buddy/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../entities/transaction_entity.dart';
import '../repositories/transaction_repository.dart';

class TransactionUseCase {
  final TransactionRepository transactionRepository;

  TransactionUseCase({required this.transactionRepository});

  Future<Either<Failure, List<TransactionEntity>>> call() async {
    return await transactionRepository.getExpenseEntries();
  }
}
