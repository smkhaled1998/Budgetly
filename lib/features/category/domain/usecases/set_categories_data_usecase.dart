import 'package:budget_buddy/features/category/domain/entities/category_entity.dart';
import 'package:budget_buddy/features/category/domain/repositories/category_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class InitializeCategoriesUseCase{
  final CategoryRepository categoryRepository;

  InitializeCategoriesUseCase({required this.categoryRepository});

  Future<Either<Failure, Unit>> call(List<CategoryEntity> categories) async {
    return await categoryRepository.setCategoriesData(categories: categories);
  }
}