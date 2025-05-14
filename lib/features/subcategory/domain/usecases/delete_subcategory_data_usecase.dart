import 'package:budget_buddy/core/error/failures.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/domain/repositories/category_management_repository.dart';
import '../../../../core/domain/repositories/sub_category_repository.dart';


class DeleteSubcategoryDataUseCase{

  final SubcategoryRepository subcategoryRepository;
  final int categoryId;

  DeleteSubcategoryDataUseCase( {required this.categoryId,required this.subcategoryRepository});

  Future <Either<Failure,Unit>> call(categoryId)async{

    return await subcategoryRepository.deleteSubcategoryData(categoryId);
  }
}