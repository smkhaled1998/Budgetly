import 'package:budget_buddy/features/explore/data/models/budget_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
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

      final budget = response.map((data) => CategoryModel.fromJson(data)).toList();
      return Right(budget);

    } on DataRetrievalException catch (e) {
      return Left(DataRetrievalFailure(errorMessage: e.toString()));
    } on DatabaseInitializationException catch (e) {
      return Left(DatabaseInitializationFailure(errorMessage: e.toString()));
    } on SQLSyntaxException catch (e) {
      return Left(SQLSyntaxFailure(errorMessage: e.toString()));
    } on QueryExecutionException catch (e) {
      return Left(QueryExecutionFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> insertCategoryData(CategoryEntity item) async {
    try {
      await localDataSource.insertCategoryData('''
      INSERT INTO `category` (
      `name`,`color`,`icon`,`categorySlice`,`spent`,`leftToSpend`
      ) VALUES(
      "${item.name}","${item.color}","${item.icon}","${item.categorySlice}","${item.spent}","${item.leftToSpend}"
      )
      ''');
      return const Right(unit);
    } on DataInsertionException catch (e) {
      return Left(DataInsertionFailure(errorMessage: e.toString()));
    } on DatabaseInitializationException catch (e) {
      return Left(DatabaseInitializationFailure(errorMessage: e.toString()));
    } on SQLSyntaxException catch (e) {
      return Left(SQLSyntaxFailure(errorMessage: e.toString()));
    } on QueryExecutionException catch (e) {
      return Left(QueryExecutionFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateCategoryData(CategoryEntity category) async {
    try {
      await localDataSource.updateCategoryData('''
      UPDATE `category`
      SET `name` = "${category.name}", `color` = "${category.color}", `icon` = "${category.icon}", `categorySlice` = "${category.categorySlice}", `spent` = "${category.spent}", `leftToSpend` = "${category.leftToSpend}"
      WHERE `name` = "${category.name}"
      ''');
      return const Right(unit);
    } on DataUpdateException catch (e) {
      return Left(DataUpdateFailure(errorMessage: e.toString()));
    } on DatabaseInitializationException catch (e) {
      return Left(DatabaseInitializationFailure(errorMessage: e.toString()));
    } on SQLSyntaxException catch (e) {
      return Left(SQLSyntaxFailure(errorMessage: e.toString()));
    } on QueryExecutionException catch (e) {
      return Left(QueryExecutionFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteCategoryData(int categoryId) async {
    try {
      await localDataSource.deleteCategoryData('''
      DELETE FROM `category`
      WHERE `id` = $categoryId
      ''');
      return const Right(unit);
    } on DataDeletionException catch (e) {
      return Left(DataDeletionFailure(errorMessage: e.toString()));
    } on DatabaseInitializationException catch (e) {
      return Left(DatabaseInitializationFailure(errorMessage: e.toString()));
    } on SQLSyntaxException catch (e) {
      return Left(SQLSyntaxFailure(errorMessage: e.toString()));
    } on QueryExecutionException catch (e) {
      return Left(QueryExecutionFailure(errorMessage: e.toString()));
    }
  }
}
