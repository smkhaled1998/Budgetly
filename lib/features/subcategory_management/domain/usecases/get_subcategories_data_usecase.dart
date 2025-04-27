import 'package:budget_buddy/core/error/failures.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/category_entity.dart';
import '../../../../core/domain/repositories/category_management_repository.dart';



class GetSubCategoriesDataUseCase{

  final CategoryRepository categoryManagementRepository;

  GetSubCategoriesDataUseCase({required this.categoryManagementRepository});

  Future <Either<Failure,List<CategoryEntity>>> call()async{

    return await categoryManagementRepository.getCategoryData();
  }
}