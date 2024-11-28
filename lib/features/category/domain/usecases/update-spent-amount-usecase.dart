import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/category_repository.dart';

class UpdateSpentAmountUseCase{
  CategoryRepository categoryRepository;
  UpdateSpentAmountUseCase({required this.categoryRepository});
  Future <Either<Failure,Unit>> call(int categoryId, double spentAmount)async{
    return await categoryRepository.updateSpentAmount(categoryId, spentAmount);
  }
}