import 'package:budget_buddy/core/error/failures.dart';

import 'package:dartz/dartz.dart';

import '../entities/category_entity.dart';
import '../repositories/category_repository.dart';

class GetCategoryDataUseCase{

  final CategoryRepository categoryRepository;

  GetCategoryDataUseCase({required this.categoryRepository});

  Future <Either<Failure,List<CategoryEntity>>> call()async{

    return await categoryRepository.getCategoryData();
  }
}