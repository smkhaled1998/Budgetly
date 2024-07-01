import 'package:budget_buddy/core/error/failures.dart';

import 'package:dartz/dartz.dart';

import '../entities/budget_entity.dart';
import '../repositories/budget_repository.dart';

class DeleteMainCategoryDataUseCase{

  final BudgetRepository budgetRepository;

  DeleteMainCategoryDataUseCase({required this.budgetRepository});

  Future <Either<Failure,Unit>> call()async{

    return await budgetRepository.deleteMainCategoryData();
  }
}