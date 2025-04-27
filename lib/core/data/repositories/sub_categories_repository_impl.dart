import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/entities/sub_category-entity.dart';
import '../database/sub_category_datasource.dart';
import '../../domain/repositories/sub_category_repository.dart';
import '../../error/failures.dart';
import '../models/sub_category_model.dart';

class SubCategoryRepositoryImpl implements SubCategoryRepository {
  final SubCategoryDataSource localDataSource;

  SubCategoryRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<SubCategoryModel>>> getSubCategoryData() async {
    try {
      final response = await localDataSource.getSubCategoriesData();
      final subCategories = response.map((data) => SubCategoryModel.fromJson(data)).toList();
      return Right(subCategories);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    } catch (e) {
      return Left(UnknownFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> insertNewSubCategory(SubCategoryEntity item) async {
    try {
      await localDataSource.insertNewSubCategory(
        subCategoryName: item.subCategoryName!,
        subCategoryColor: item.subCategoryColor!,
        subCategoryIcon: item.subCategoryIcon!,
        categoryId: item.categoryId!,
      );
      return const Right(unit);
    } on DatabaseException catch (e) {
      return Left(DataInsertionFailure(errorMessage: e.toString()));
    } catch (e) {
      return Left(UnknownFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateSubCategoryData({
    required int categoryId,
    required SubCategoryEntity subCategory,
  }) async {
    try {
      final Map<String, dynamic> updatedFields = {};

      if (subCategory.subCategoryName != null) {
        updatedFields['subCategoryName'] = subCategory.subCategoryName;
      }
      if (subCategory.subCategoryColor != null) {
        updatedFields['subCategoryColor'] = subCategory.subCategoryColor;
      }
      if (subCategory.subCategoryIcon != null) {
        updatedFields['subCategoryIcon'] = subCategory.subCategoryIcon;
      }
      if (subCategory.categoryId != null) {
        updatedFields['categoryId'] = subCategory.categoryId;
      }

      // التحقق من وجود بيانات للتحديث
      if (updatedFields.isEmpty) {
        return Left(DataUpdateFailure(errorMessage: "No fields to update"));
      }

      // استدعاء دالة التحديث في الداتاسورس مع الحقول المحددة فقط
      await localDataSource.updateSubCategoryData(
        subCategoryId: subCategory.subCategoryId!,
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
  Future<Either<Failure, Unit>> deleteSubCategoryData(int subCategoryId) async {
    try {
      await localDataSource.deleteSubCategoryData(subCategoryId);
      return const Right(unit);
    } on DatabaseException catch (e) {
      return Left(DataDeletionFailure(errorMessage: e.toString()));
    } catch (e) {
      return Left(UnknownFailure(errorMessage: e.toString()));
    }
  }
}