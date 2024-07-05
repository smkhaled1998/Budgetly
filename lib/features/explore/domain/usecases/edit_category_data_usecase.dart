import 'package:budget_buddy/core/error/failures.dart';

import 'package:dartz/dartz.dart';

import '../entities/category_entity.dart';
import '../repositories/category_repository.dart';

class EditCategoryDataUseCase{

  final CategoryRepository budgetRepository;
  final CategoryEntity item;

  EditCategoryDataUseCase({required this.budgetRepository,required this.item});

  Future <Either<Failure,Unit>> call()async{

    return await budgetRepository.updateCategoryData( item);
  }
}