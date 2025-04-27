import 'package:dartz/dartz.dart';

import '../../error/failures.dart';
import '../entities/sub_category-entity.dart';

abstract class SubCategoryRepository{
  Future<Either<Failure,List<SubCategoryEntity>>> getSubCategoryData();
  Future<Either<Failure, Unit>> updateSubCategoryData( {
    required int categoryId,
    required SubCategoryEntity subCategory,
  });
  Future<Either<Failure,Unit>> deleteSubCategoryData(int categoryId);
  Future<Either<Failure,Unit>> insertNewSubCategory(SubCategoryEntity item);
}