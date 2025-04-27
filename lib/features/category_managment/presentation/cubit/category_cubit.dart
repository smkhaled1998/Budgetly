import 'package:budget_buddy/core/data/repositories/category_repository_impl.dart';
import 'package:budget_buddy/features/category_managment/presentation/cubit/category_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constances.dart';
import '../../../../core/data/database/category_management_datasource.dart';
import '../../../../core/data/models/category_model.dart';
import '../../../../core/domain/entities/category_entity.dart';
import '../../../transaction/data/repositories/transaction_repository_imp.dart';
import '../../../transaction/domain/entities/transaction_entity.dart';
import '../../domain/usecases/delete_category_data_usecase.dart';
import '../../domain/usecases/edit_category_data_usecase.dart';
import '../../domain/usecases/get_categories_data_usecase.dart';
import '../../domain/usecases/initialize_categories_usecase.dart';
import '../../domain/usecases/insert_new_category_usecase.dart';

class CategoryCubit extends Cubit<CategoryStates> {
  CategoryCubit() : super(CategoryManagementInitialStates());

  static CategoryCubit get(context) => BlocProvider.of(context);
  List<CategoryEntity> fetchedCategories = [];
  int remainingBudget = 0;

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
    final response = await GetCategoriesDataUseCase(
      categoryManagementRepository: CategoryRepositoryImpl(localDataSource: CategoryManagementDataSource(),),
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

  Future<void> insertNewCategory(CategoryEntity item) async {
    emit(CategoryInsertionLoadingState());

    // أضف الفئة الجديدة مباشرة إلى القائمة بدون انتظار معالجة قاعدة البيانات
    // نقوم بوضع ID مؤقت، سيتم تعويضه بعد الإدراج في قاعدة البيانات
    final tempCategory = CategoryModel(
      categoryId: DateTime.now().millisecondsSinceEpoch, // ID مؤقت
      name: item.name,
      allocatedAmount: item.allocatedAmount,
      color: item.color,
      icon: item.icon,
      storedSpentAmount: item.storedSpentAmount,
    );

    fetchedCategories.add(tempCategory);
    _ensureSavingCategoryIsLast();
    emit(CategoryInsertedState());

    // بعد إضافة الفئة مؤقتًا، نقوم بتنفيذ عملية الإدراج في قاعدة البيانات
    final useCase = InsertCategoryDataUseCase(
      categoryManagementRepository: CategoryRepositoryImpl(localDataSource: CategoryManagementDataSource(),),
    );

    final result = await useCase.call(item);

    result.fold(
          (failure) {
        print('Error occurred: ${failure.message}');
        emit(CategoryInsertionErrorState(failure.message));

        // في حالة الفشل، نزيل الفئة المؤقتة من القائمة
        fetchedCategories.removeWhere((category) =>
        category.categoryId == tempCategory.categoryId);
        _ensureSavingCategoryIsLast();
        emit(ChangeAppearanceState(items: fetchedCategories));
      },
          (_) {
        print('Category inserted successfully');
        // بعد النجاح، نقوم بتحديث القائمة بالبيانات الحقيقية من قاعدة البيانات
        fetchCategories();
      },
    );
  }

  Future<void> removeCategory(int categoryId) async {
    emit(CategoryDeleteLoadingState()); // حالة التحميل

    // إزالة الفئة مؤقتًا من القائمة
    int index = fetchedCategories.indexWhere((category) => category.categoryId == categoryId);
    CategoryEntity? removedCategory;

    if (index != -1) {
      removedCategory = fetchedCategories.removeAt(index);
      emit(ChangeAppearanceState(items: fetchedCategories));
    }

    final useCase = DeleteCategoryDataUseCase(
      categoryManagementRepository: CategoryRepositoryImpl(
        localDataSource: CategoryManagementDataSource(),
      ),
      categoryId: categoryId,
    );

    final result = await useCase.call(categoryId);
    result.fold(
          (failure) {
        print('Error occurred: ${failure.message}');
        emit(CategoryDeleteErrorState(failure.message));

        // استعادة الفئة المحذوفة إذا فشلت عملية الحذف
        if (removedCategory != null) {
          fetchedCategories.insert(index, removedCategory);
          _ensureSavingCategoryIsLast();
          emit(ChangeAppearanceState(items: fetchedCategories));
        }
      },
          (_) {
        print('Category deleted successfully');
        emit(CategoryDeletedState());
        // تأكيد الحذف، لا نحتاج لتحديث القائمة مرة أخرى
      },
    );
  }

  Future<void> updateCategoryData(
      CategoryEntity item, int categoryId) async {
    emit(CategoryUpdateLoadingState()); // حالة التحميل

    // تحديث الفئة مؤقتًا في القائمة
    int index = fetchedCategories.indexWhere((category) => category.categoryId == categoryId);
    CategoryEntity? oldCategory;

    if (index != -1) {
      oldCategory = fetchedCategories[index];
      fetchedCategories[index] = item;
      _ensureSavingCategoryIsLast();
      emit(ChangeAppearanceState(items: fetchedCategories));
    }

    final useCase = UpdateCategoryDataUseCase(
      categoryManagementRepository: CategoryRepositoryImpl(
        localDataSource: CategoryManagementDataSource(),
      ),
    );

    final result = await useCase.call(item, categoryId);
    result.fold(
          (failure) {
        print('Error occurred: ${failure.message}');
        emit(CategoryUpdateErrorState(failure.message));

        // استعادة الفئة القديمة إذا فشل التحديث
        if (oldCategory != null && index != -1) {
          fetchedCategories[index] = oldCategory;
          _ensureSavingCategoryIsLast();
          emit(ChangeAppearanceState(items: fetchedCategories));
        }
      },
          (_) {
        print('Category updated successfully');
        emit(CategoryUpdatedState());
        // تم التحديث بنجاح، لا نحتاج لتحديث القائمة مرة أخرى
      },
    );
  }

  String? _categoryIcon;
  String get categoryIcon => _categoryIcon ?? Icons.category.codePoint.toString();

  void updateCategoryIcon(String updatedCategoryIcon) {
    _categoryIcon = updatedCategoryIcon;
    emit(ChangeAppearanceState(items: fetchedCategories));
  }

  Color categoryColor = Colors.blueAccent;

  void updateCategoryColor(Color color) {
    categoryColor = color;
    emit(ChangeAppearanceState(items: fetchedCategories));
  }

  void addNewSettingUpCategory(CategoryEntity newCategoryEntity) {
    fetchedCategories.add(newCategoryEntity);
    _ensureSavingCategoryIsLast();
    emit(AddSettingUpCategoryState());
  }

  String? updatedCategoryName;

  void saveUpdatedCategory(
      nameController, CategoryEntity item, budgetController) {
    final updatedName = nameController.isEmpty ? item.name : nameController;
    final updatedAmount = budgetController.isEmpty
        ? item.allocatedAmount
        : double.tryParse(budgetController) ?? item.allocatedAmount;

    CategoryEntity updatedItem = CategoryModel(
      name: updatedName,
      allocatedAmount: updatedAmount,
      color: categoryColor.toString(),
      icon: categoryIcon,
    );

    updateCategoryData(updatedItem, item.categoryId!);
  }

  Future<void> initializeCategoriesStage(List <CategoryEntity> categories) async {
    emit(CategoryInsertionLoadingState());
    final useCase = InitializeCategoriesUseCase(
      categoryRepository: CategoryRepositoryImpl(
        localDataSource: CategoryManagementDataSource(),
      ),
    );

    final result = await useCase.call(categories.cast<CategoryEntity>());

    result.fold(
          (failure) {
        print('Error occurred: ${failure.message}');
        emit(CategoryInsertionErrorState(failure.message));
      },
          (_) {
        print('Category inserted successfully');
        emit(CategoryInsertedState());
        fetchCategories(); // تحديث الفئات بعد الإضافة
      },
    );
  }

  int currentCategoryIndex = 0;
  int totalAllocatedBudgetBasedOnMap = 0;
  Map<int,int> mappedAllocatedCategoryAmount = {};

  void updateRemainingBudgetForProgressBarInSettingUpstage(int difference) {
    remainingBudget += difference;
    emit(UpdateRemainingSalaryState());
  }

  void updateCategoryAllocationAndTotalBudgetInSettingUpstage(int index, int value) {
    mappedAllocatedCategoryAmount[index] = (mappedAllocatedCategoryAmount[index] ?? 0) + value;
    totalAllocatedBudgetBasedOnMap = 0;
    mappedAllocatedCategoryAmount.forEach((key, val) {
      if (key != index) {
        totalAllocatedBudgetBasedOnMap += val;
      }
    });
  }
}