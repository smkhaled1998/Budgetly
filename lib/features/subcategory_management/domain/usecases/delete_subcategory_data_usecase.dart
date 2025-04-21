import 'package:budget_buddy/core/error/failures.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/domain/repositories/category_management_repository.dart';


class DeleteSubCategoryDataUseCase{

  final CategoryManagementRepository categoryManagementRepository;
  final int categoryId;

  DeleteSubCategoryDataUseCase( {required this.categoryId,required this.categoryManagementRepository});

  Future <Either<Failure,Unit>> call(categoryId)async{

    return await categoryManagementRepository.deleteCategoryData(categoryId);
  }
}