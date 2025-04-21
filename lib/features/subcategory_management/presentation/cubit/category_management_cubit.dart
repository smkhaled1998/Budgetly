import 'package:budget_buddy/core/data/repositories/category_repository_impl.dart';
import 'package:budget_buddy/features/category_managment/presentation/cubit/category_management_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constances.dart';
import '../../../../core/data/database/category_management_datasource.dart';
import '../../../../core/data/models/category_model.dart';
import '../../../../core/domain/entities/category_management_entity.dart';
import '../../../transaction/data/repositories/transaction_repository_imp.dart';
import '../../../transaction/domain/entities/transaction_entity.dart';
import '../../domain/usecases/delete_subcategory_data_usecase.dart';
import '../../domain/usecases/edit_subcategory_data_usecase.dart';
import '../../domain/usecases/get_subcategories_data_usecase.dart';
import '../../domain/usecases/insert_new_subcategory_usecase.dart';

class CategoryManagementCubit extends Cubit<CategoryManagementStates> {
  CategoryManagementCubit() : super(CategoryManagementInitialStates());

  static CategoryManagementCubit get(context) => BlocProvider.of(context);
  List<CategoryManagementEntity> fetchedCategories = [];

  void _ensureSavingCategoryIsLast() {
    final savingCategoryIndex =
        fetchedCategories.indexWhere((category) => category.name == "Saving");
    if (savingCategoryIndex != -1 &&
        savingCategoryIndex != fetchedCategories.length - 1) {
      final savingCategory = fetchedCategories.removeAt(savingCategoryIndex);
      fetchedCategories.add(savingCategory);
    }
  }

  Future<void> fetchCategories() async {
    emit(GetCategoryDataLoadingState()); // حالة التحميل
    final response = await GetSubCategoriesDataUseCase(
      categoryManagementRepository: CategoryManagementRepositoryImpl(localDataSource: CategoryManagementDataSource(),),
    ).call();

    response.fold(
      (failure) {
        print(failure.message);
        emit(GetCategoryDataErrorState(errorMessage: failure.message));
      },
      (data) {
        fetchedCategories = data;
        _ensureSavingCategoryIsLast();
        emit(GetCategoryDataSuccessState(categories: data));
      },
    );
    print("=====================Alhamdulillah===============================");
  }

  Future<void> insertNewCategory(CategoryManagementEntity item) async {
    emit(CategoryInsertionLoadingState());
    final useCase = InsertSubCategoryDataUseCase(
      categoryManagementRepository: CategoryManagementRepositoryImpl(localDataSource: CategoryManagementDataSource(),),

    );

    final result = await useCase.call(item);

    result.fold(
      (failure) {
        print('Error occurred: \${failure.message}');
        emit(CategoryInsertionErrorState(failure.message));
      },
      (_) {
        print('Category inserted successfully');
        emit(CategoryInsertedState());
        fetchCategories(); // تحديث الفئات بعد الإضافة
      },
    );
  }

  Future<void> removeCategory(int categoryId) async {
    emit(CategoryDeleteLoadingState()); // حالة التحميل
    final useCase = DeleteSubCategoryDataUseCase(
      categoryManagementRepository: CategoryManagementRepositoryImpl(
        localDataSource: CategoryManagementDataSource(),
      ),
      categoryId: categoryId,
    );

    final result = await useCase.call(categoryId);
    result.fold(
      (failure) {
        print('Error occurred: \${failure.message}');
        emit(CategoryDeleteErrorState(failure.message));
      },
      (_) {
        print('Category updated successfully');
        emit(CategoryDeletedState());
        fetchCategories(); // تحديث الفئات بعد التحديث
      },
    );
  }

  Future<void> updateCategoryData(
      CategoryManagementEntity item, int categoryId) async {
    emit(CategoryUpdateLoadingState()); // حالة التحميل
    final useCase = UpdateSubCategoryDataUseCase(
      categoryManagementRepository: CategoryManagementRepositoryImpl(
        localDataSource: CategoryManagementDataSource(),
      ),
    );

    final result = await useCase.call(item, categoryId);
    result.fold(
      (failure) {
        print('Error occurred: \${failure.message}');
        emit(CategoryUpdateErrorState(failure.message));
      },
      (_) {
        print('Category updated successfully');
        emit(CategoryUpdatedState());
        fetchCategories(); // تحديث الفئات بعد التحديث
      },
    );
  }

  String? categoryIcon;

  void updateCategoryIcon(int index) {
    categoryIcon = iconImages[index];
    emit(ChangeAppearanceState(items: fetchedCategories));
  }

  Color categoryColor = Colors.blueAccent;

  void updateCategoryColor(Color color) {
    categoryColor = color;
    emit(ChangeAppearanceState(items: fetchedCategories));
  }

  void addNewSettingUpCategory(newCategoryEntity) {
    fetchedCategories.add(newCategoryEntity);
    _ensureSavingCategoryIsLast();
    emit(ChangeAppearanceState(items: fetchedCategories));
  }

  bool isEditModeActive = false;

  void toggleEditMode() {
    isEditModeActive = !isEditModeActive;
    fetchCategories();
    emit(ToggleCategoryEditModeState());
  }

  String? updatedCategoryName;
  double? updatedAllocatedAmount;

  void saveUpdatedCategory(
      nameController, CategoryManagementEntity item, budgetController) {
    final updatedName = nameController.isEmpty ? item.name : nameController;
    final updatedAmount = budgetController.isEmpty
        ? item.allocatedAmount
        : double.tryParse(budgetController) ?? item.allocatedAmount;

    CategoryManagementEntity updatedItem = CategoryManagementModel(
      name: updatedName,
      allocatedAmount: updatedAmount,
      color: categoryColor.toString(),
      icon: categoryIcon,
    );

    updateCategoryData(updatedItem, item.categoryId!);
  }

}
