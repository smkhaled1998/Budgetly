import 'package:budget_buddy/core/error/failures.dart';

import 'package:dartz/dartz.dart';

import '../entities/budget_entity.dart';
import '../repositories/budget_repository.dart';

class GetMAinCategoryDataUseCase{

  final BudgetRepository budgetRepository;

  GetMAinCategoryDataUseCase({required this.budgetRepository});

  Future <Either<Failure,List<BudgetEntity>>> call()async{

    return await budgetRepository.getMainCategoryData();
  }
}