import 'package:budget_buddy/core/error/failures.dart';

import 'package:dartz/dartz.dart';

import '../entities/category_entity.dart';
import '../repositories/category_repository.dart';

class UpdateCategoryDataUseCase{

  final CategoryRepository categoryRepository;

  UpdateCategoryDataUseCase({required this.categoryRepository});

  Future <Either<Failure,Unit>> call(CategoryEntity item,int categoryId)async{

    return await categoryRepository.updateCategoryData(item: item,categoryId: categoryId);
  }
}