import 'package:budget_buddy/core/error/failures.dart';

import 'package:dartz/dartz.dart';

import '../entities/category_entity.dart';
import '../repositories/category_repository.dart';

class InsertCategoryDataUseCase {
  final CategoryRepository budgetRepository;

  InsertCategoryDataUseCase({required this.budgetRepository});

  Future<Either<Failure, Unit>> call(item) async {
    return await budgetRepository.insertCategoryData( item);
  }
}
