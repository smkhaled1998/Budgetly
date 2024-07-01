import 'package:budget_buddy/core/error/failures.dart';

import 'package:dartz/dartz.dart';

import '../repositories/budget_repository.dart';

class EditMAinCategoryDataUseCase{

  final BudgetRepository budgetRepository;

  EditMAinCategoryDataUseCase({required this.budgetRepository});

  Future <Either<Failure,Unit>> call()async{

    return await budgetRepository.editMainCategoryData();
  }
}