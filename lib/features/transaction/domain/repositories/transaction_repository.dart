
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/transaction_entity.dart';

abstract class TransactionRepository{

  Future<Either<Failure,List<TransactionEntity>>> getExpenseEntries();
  Future<Either<Failure,Unit>> editExpenseEntry(TransactionEntity item);
  Future<Either<Failure,Unit>> deleteExpenseEntry(int categoryId);
  Future<Either<Failure,Unit>> addExpenseEntry(TransactionEntity item);


}