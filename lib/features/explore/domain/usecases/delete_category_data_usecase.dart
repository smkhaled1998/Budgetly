import 'package:budget_buddy/core/error/failures.dart';

import 'package:dartz/dartz.dart';

import '../entities/category_entity.dart';
import '../repositories/category_repository.dart';

class DeleteCategoryDataUseCase{

  final CategoryRepository budgetRepository;
  final int categoryId;

  DeleteCategoryDataUseCase(this.categoryId, {required this.budgetRepository});

  Future <Either<Failure,Unit>> call()async{

    return await budgetRepository.deleteCategoryData( categoryId);
  }
}