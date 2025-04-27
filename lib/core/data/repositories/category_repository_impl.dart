import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/entities/category_entity.dart';
import '../database/category_management_datasource.dart';

import '../../domain/repositories/category_management_repository.dart';
import '../../error/failures.dart';
import '../models/category_model.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryManagementDataSource localDataSource;

  CategoryRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategoryData() async {
    try {
      final response = await localDataSource.getCategoriesData();
      final categories = response.map((data) => CategoryModel.fromJson(data)).toList();
      return Right(categories);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    } catch (e) {
      return Left(UnknownFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> insertNewCategory(CategoryEntity item) async {
    try {
      await localDataSource.insertNewCategory(
        name: item.name!,
        color: item.color!,
        icon: item.icon!,
        allocatedAmount: item.allocatedAmount!,
      );
      return const Right(unit);
    } on DatabaseException catch (e) {
      return Left(DataInsertionFailure(errorMessage: e.toString()));
    } catch (e) {
      return Left(UnknownFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateCategoryData({
    required int categoryId,
    required CategoryEntity item,
  }) async {
    try {
      final Map<String, dynamic> updatedFields = {};

      if (item.name != null) updatedFields['name'] = item.name;
      if (item.color != null) updatedFields['color'] = item.color;
      if (item.icon != null) updatedFields['icon'] = item.icon;
      if (item.allocatedAmount != null) updatedFields['allocatedAmount'] = item.allocatedAmount;

      // التحقق من وجود بيانات للتحديث
      if (updatedFields.isEmpty) {
        return Left(DataUpdateFailure(errorMessage: "No fields to update"));
      }

      // استدعاء دالة التحديث في الداتاسورس مع الحقول المحددة فقط
      await localDataSource.updateCategoryData(
        categoryId: categoryId,
        updatedFields: updatedFields,
      );
      return const Right(unit);
    } on DatabaseException catch (e) {
      return Left(DataUpdateFailure(errorMessage: e.toString()));
    } catch (e) {
      return Left(UnknownFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteCategoryData(int categoryId) async {
    try {
      await localDataSource.deleteCategoryData(categoryId);
      return const Right(unit);
    } on DatabaseException catch (e) {
      return Left(DataDeletionFailure(errorMessage: e.toString()));
    } catch (e) {
      return Left(UnknownFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateSpentAmount(int categoryId, double storedSpentAmount) async {
    try {
      await localDataSource.updateSpentAmount(
        categoryId: categoryId,
        storedSpentAmount:  storedSpentAmount,
      );
      return const Right(unit);
    } on DatabaseException catch (e) {
      return Left(DataUpdateFailure(errorMessage: e.toString()));
    } catch (e) {
      return Left(UnknownFailure(errorMessage: e.toString()));
    }
  }

  @override

  Future<Either<Failure, Unit>> setCategoriesData(
      List<CategoryEntity> categories, // Use positional parameter
      ) async {
    try {
      await localDataSource.initializeCategoriesData(categories: categories);
      return const Right(unit);
    } on DatabaseException catch (e) {
      return Left(DataInsertionFailure(errorMessage: e.toString()));
    } catch (e) {
      return Left(UnknownFailure(errorMessage: e.toString()));
    }
  }
}
