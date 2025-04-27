import 'package:budget_buddy/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/domain/repositories/category_management_repository.dart';


class InsertSubCategoryDataUseCase {
  final CategoryRepository categoryManagementRepository;

  InsertSubCategoryDataUseCase({required this.categoryManagementRepository});

  Future<Either<Failure, Unit>> call(item) async {
    return await categoryManagementRepository.insertNewCategory( item);
  }
}
