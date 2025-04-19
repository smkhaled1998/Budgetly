import 'package:budget_buddy/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/domain/repositories/category_management_repository.dart';


class InsertCategoryDataUseCase {
  final CategoryManagementRepository categoryManagementRepository;

  InsertCategoryDataUseCase({required this.categoryManagementRepository});

  Future<Either<Failure, Unit>> call(item) async {
    return await categoryManagementRepository.insertNewCategory( item);
  }
}
