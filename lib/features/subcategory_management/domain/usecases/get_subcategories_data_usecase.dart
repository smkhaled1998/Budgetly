import 'package:budget_buddy/core/error/failures.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/category_management_entity.dart';
import '../../../../core/domain/repositories/category_management_repository.dart';



class GetSubCategoriesDataUseCase{

  final CategoryManagementRepository categoryManagementRepository;

  GetSubCategoriesDataUseCase({required this.categoryManagementRepository});

  Future <Either<Failure,List<CategoryManagementEntity>>> call()async{

    return await categoryManagementRepository.getCategoryData();
  }
}