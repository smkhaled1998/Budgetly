import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constances.dart';
import '../../data/datasources/category_datasource.dart';
import '../../data/models/category_model.dart';
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
double monthlySalary=0;
  List<CategoryEntity> fetchedCategories = [];
  double? spentAmount;

  void addAndGetCategoriesList(newCategory){
    fetchedCategories.add(newCategory);
    emit(AddSettingUpCategoryState());
  }

  Future<void> getBudgetCategories() async {
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
        fetchedCategories = categoriesList=data;
        emit(GetCategoryDataSuccessState(categories: data));

      },
    );
    print("=====================Alhamdulillah===============================");
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
        getBudgetCategories(); // تحديث الفئات بعد الإضافة
      },
    );
  }
  Future<void> initializeCategories(List <CategoryEntity> categories) async {
    emit(CategoryInsertionLoadingState());
    final useCase = SetCategoriesDataUseCase(
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
        getBudgetCategories(); // تحديث الفئات بعد الإضافة
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
        getBudgetCategories(); // تحديث الفئات بعد التحديث
      },
    );
  }
  Future<void> deleteCategoryData(int categoryId) async {
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
        getBudgetCategories(); // تحديث الفئات بعد التحديث
      },
    );
  }
  Future<void> updateSpentAmount(int categoryId, double spentAmount) async {
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
        getBudgetCategories(); // تحديث الفئات بعد التحديث
      },
    );
  }

  String? categoryIcon ;
  void changeCategoryIcon(int index) {
    categoryIcon = iconImages[index];
    emit(ChangeIconState(items: fetchedCategories));
  }

  Color categoryColor = Colors.blueAccent;
  void changeCategoryColor(Color color) {
    categoryColor = color;
    emit(ChangeColorState(items: fetchedCategories));
  }

  bool isCategoryEditMode=false;
  void toggleCategoryEditMode(){
    isCategoryEditMode=!isCategoryEditMode;
    getBudgetCategories();
    emit(ToggleCategoryEditModeState());
  }
String? editedCategoryName;
double? editedAllocatedAmount;



}
