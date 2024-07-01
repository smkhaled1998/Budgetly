import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/budget_entity.dart';

abstract class BudgetRepository{

  Future<Either<Failure,List<BudgetEntity>>> getMainCategoryData();
  Future<Either<Failure,Unit>> editMainCategoryData(BudgetEntity item);
  Future<Either<Failure,Unit>> deleteMainCategoryData(BudgetEntity item);


}