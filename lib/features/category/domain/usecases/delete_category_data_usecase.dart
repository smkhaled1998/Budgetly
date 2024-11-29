import 'package:budget_buddy/core/error/failures.dart';

import 'package:dartz/dartz.dart';

import '../entities/category_entity.dart';
import '../repositories/category_repository.dart';

class DeleteCategoryDataUseCase{

  final CategoryRepository categoryRepository;
  final int categoryId;

  DeleteCategoryDataUseCase( {required this.categoryId,required this.categoryRepository});

  Future <Either<Failure,Unit>> call(categoryId)async{

    return await categoryRepository.deleteCategoryData(categoryId);
  }
}