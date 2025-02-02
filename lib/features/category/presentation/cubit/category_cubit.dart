import 'package:budget_buddy/features/category/data/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constances.dart';
import '../../data/datasources/category_datasource.dart';
import '../../data/repositories/category_repository_imp.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/usecases/delete_category_data_usecase.dart';
import '../../domain/usecases/edit_category_data_usecase.dart';
import '../../domain/usecases/get_categories_data_usecase.dart';
import '../../domain/usecases/insert_new_category_usecase.dart';
import '../../domain/usecases/set_categories_data_usecase.dart';
import '../../domain/usecases/update-spent-amount-usecase.dart';
import 'category_states.dart';

class CategoryCubit extends Cubit<CategoryStates> {
  CategoryCubit() : super(CategoryInitialState());

  static CategoryCubit get(context) => BlocProvider.of(context);
  List<CategoryEntity> fetchedCategories = [];
  void addNewSettingUpCategory(newCategoryEntity){
    fetchedCategories.add(newCategoryEntity);

    emit(ChangeIconState(items: fetchedCategories));
  }
  // void updateAllocatedAmount(int categoryId, double newAmount) {
  //   final index = fetchedCategories.indexWhere((category) => category.categoryId == categoryId);
  //   if (index != -1) {
  //     fetchedCategories[index] = CategoryModel(
  //       categoryId: fetchedCategories[index].categoryId,
  //       name: fetchedCategories[index].name,
  //       color: fetchedCategories[index].color,
  //       icon: fetchedCategories[index].icon,
  //       allocatedAmount: newAmount,
  //       spentAmount: fetchedCategories[index].spentAmount,
  //     );
  //     emit(CategoryUpdatedState());
  //   }
  // }

  double? spentAmount;



  Future<void> fetchBudgetCategories() async {
    emit(GetCategoryDataLoadingState()); // حالة التحميل
    final response = await GetCategoriesDataUseCase(
      categoryRepository: CategoryRepositoryImpl(
        localDataSource: CategoryDataSource(),
      ),
    ).call();

    response.fold(
          (failure) {
        print(failure.message);
        emit(GetCategoryDataErrorState(errorMessage: failure.message));
      },
          (data) {
        fetchedCategories =data;
        emit(GetCategoryDataSuccessState(categories: data));

      },
    );
    print("=====================Alhamdulillah===============================");
  }
  Future<void> initializeCategories(List <CategoryEntity> categories) async {
    emit(CategoryInsertionLoadingState());
    final useCase = InitializeCategoriesUseCase(
      categoryRepository: CategoryRepositoryImpl(
        localDataSource: CategoryDataSource(),
      ),
    );

    final result = await useCase.call(categories);

    result.fold(
          (failure) {
        print('Error occurred: \${failure.message}');
        emit(CategoryInsertionErrorState(failure.message));
      },
          (_) {
        print('Category inserted successfully');
        emit(CategoryInsertedState());
        fetchBudgetCategories(); // تحديث الفئات بعد الإضافة
      },
    );
  }


  Future<void> insertNewCategory(CategoryEntity item) async {
    emit(CategoryInsertionLoadingState()); // حالة التحميل
    final useCase = InsertCategoryDataUseCase(
      categoryRepository: CategoryRepositoryImpl(
        localDataSource: CategoryDataSource(),
      ),
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
        fetchBudgetCategories(); // تحديث الفئات بعد الإضافة
      },
    );
  }
  Future<void> updateCategoryData(CategoryEntity item, int categoryId) async {
    emit(CategoryUpdateLoadingState()); // حالة التحميل
    final useCase = UpdateCategoryDataUseCase(
      categoryRepository: CategoryRepositoryImpl(
        localDataSource: CategoryDataSource(),
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
        fetchBudgetCategories(); // تحديث الفئات بعد التحديث
      },
    );
  }

  Future<void> removeCategory(int categoryId) async {
    emit(CategoryDeleteLoadingState()); // حالة التحميل
    final useCase = DeleteCategoryDataUseCase(
      categoryRepository: CategoryRepositoryImpl(
        localDataSource: CategoryDataSource(),
      ), categoryId: categoryId,
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
        fetchBudgetCategories(); // تحديث الفئات بعد التحديث
      },
    );
  }
  Future<void> updateCategorySpending(int categoryId, double spentAmount) async {
    emit(UpdateSpentAmountLoadingState()); // حالة التحميل
    final useCase = UpdateSpentAmountUseCase(
      categoryRepository: CategoryRepositoryImpl(
        localDataSource: CategoryDataSource(),
      ),
    );

    final result = await useCase.call(categoryId, spentAmount);
    result.fold(
          (failure) {
        print('Error occurred: \${failure.message}');
        emit(UpdateSpentAmountErrorState( errorMessage: failure.message));
      },
          (_) {
        print('Spent amount updated successfully');
        emit(UpdateSpentAmountSuccessState());
        fetchBudgetCategories(); // تحديث الفئات بعد التحديث
      },
    );
  }

  String? categoryIcon ;
  void updateCategoryIcon(int index) {
    categoryIcon = iconImages[index];
    emit(ChangeIconState(items: fetchedCategories));
  }

  Color categoryColor = Colors.blueAccent;
  void updateCategoryColor(Color color) {
    categoryColor = color;
    emit(ChangeColorState(items: fetchedCategories));
  }

  bool isEditModeActive=false;
  void toggleEditMode(){
    isEditModeActive=!isEditModeActive;
    fetchBudgetCategories();
    emit(ToggleCategoryEditModeState());
  }
  String? updatedCategoryName;
  double? updatedAllocatedAmount;
  double remainingBudget=0.0;

  void updateRemainingBudgetForProgressBar(double difference) {
    remainingBudget += difference;
   emit(UpdateRemainingSalaryState());
  }

  ///*******************************************************/////////////

  int currentCategoryIndex=0;
  double currentCategoryValue=0;
  double totalAllocatedBudget=0;
  Map<int,double> allocatedCategoryAmount={};
  void calculateCategoryAllocation(int index, double value) {
    // Update the current category value and the map
    currentCategoryValue += value;

    allocatedCategoryAmount[index] = currentCategoryValue;

    // Reset the total allocated budget before recalculating
    totalAllocatedBudget = 0;

    // Sum all values except the one being edited
    allocatedCategoryAmount.forEach((key, val) {
      if (key != index) {
        totalAllocatedBudget += val;
      }
    });

    print("currentCategoryValue = $currentCategoryValue");
    print("allocatedCategoryAmount = $allocatedCategoryAmount");
    print("totalAllocatedBudget = $totalAllocatedBudget");
  }
}
