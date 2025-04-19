import 'package:budget_buddy/core/error/failures.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/domain/repositories/category_management_repository.dart';


class DeleteCategoryDataUseCase{

  final CategoryManagementRepository categoryManagementRepository;
  final int categoryId;

  DeleteCategoryDataUseCase( {required this.categoryId,required this.categoryManagementRepository});

  Future <Either<Failure,Unit>> call(categoryId)async{

    return await categoryManagementRepository.deleteCategoryData(categoryId);
  }
}