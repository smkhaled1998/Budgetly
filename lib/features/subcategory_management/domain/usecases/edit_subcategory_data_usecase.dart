import 'package:budget_buddy/core/error/failures.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/category_management_entity.dart';
import '../../../../core/domain/repositories/category_management_repository.dart' show CategoryManagementRepository;

class UpdateSubCategoryDataUseCase{

  final CategoryManagementRepository categoryManagementRepository;

  UpdateSubCategoryDataUseCase({required this.categoryManagementRepository});

  Future <Either<Failure,Unit>> call(CategoryManagementEntity item,int categoryId)async{

    return await categoryManagementRepository.updateCategoryData(item: item,categoryId: categoryId);
  }
}