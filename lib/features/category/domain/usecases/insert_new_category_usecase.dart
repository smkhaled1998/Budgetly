import 'package:budget_buddy/core/error/failures.dart';

import 'package:dartz/dartz.dart';

import '../repositories/category_repository.dart';

class InsertCategoryDataUseCase {
  final CategoryRepository categoryRepository;

  InsertCategoryDataUseCase({required this.categoryRepository});

  Future<Either<Failure, Unit>> call(item) async {
    return await categoryRepository.insertNewCategory( item);
  }
}
