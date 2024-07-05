import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/category_entity.dart';

abstract class CategoryRepository{

  Future<Either<Failure,List<CategoryEntity>>> getCategoryData();
  Future<Either<Failure,Unit>> updateCategoryData(CategoryEntity item);
  Future<Either<Failure,Unit>> deleteCategoryData(int categoryId);
  Future<Either<Failure,Unit>> insertCategoryData(CategoryEntity item);


}