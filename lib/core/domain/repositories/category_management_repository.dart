import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/category_management_entity.dart';

abstract class CategoryManagementRepository{
  Future<Either<Failure,List<CategoryManagementEntity>>> getCategoryData();
  Future<Either<Failure, Unit>> updateCategoryData( {
    required int categoryId,
    required CategoryManagementEntity item,
  });
  Future<Either<Failure,Unit>> deleteCategoryData(int categoryId);
  Future<Either<Failure,Unit>> insertNewCategory(CategoryManagementEntity item);
}