import 'package:budget_buddy/features/explore/data/models/budget_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/category_local_datasource.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryLocalDataSource localDataSource;

  CategoryRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategoryData() async {
    try {
      final response = await localDataSource.getCategoryData('''
      SELECT * FROM `category`
      ''');


      final budget =
          response.map((data) => CategoryModel.fromJson(data)).toList();
      return Right(budget);
    } catch (e) {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> insertCategoryData(CategoryEntity item) async {
    await localDataSource.insertCategoryData('''
   INSERT INTO `category` (
   `name`,`color`,`icon`,`total`,`spent`,`leftToSpend`
   ) VALUES(
   "${item.name}","${item.color}","${item.icon}","${item.total}","${item.spent}","${item.leftToSpend}"
   )
    
    ''');
    try {
      return const Right(unit);
    } catch (e) {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateCategoryData(CategoryEntity budget) async {
    try {
      await localDataSource.updateCategoryData("");
      return const Right(unit);
    } catch (e) {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteCategoryData(int categoryId) async {
    try {
      await localDataSource.deleteCategoryData("");
      return const Right(unit);
    } catch (e) {
      return Left(DatabaseFailure());
    }
  }
}
