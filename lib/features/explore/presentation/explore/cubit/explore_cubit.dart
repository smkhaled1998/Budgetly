    import 'package:budget_buddy/features/explore/data/datasources/category_local_datasource.dart';
    import 'package:budget_buddy/features/explore/data/models/budget_model.dart';
    import 'package:budget_buddy/features/explore/data/repositories/category_repository_imp.dart';
    import 'package:budget_buddy/features/explore/domain/entities/category_entity.dart';
    import 'package:budget_buddy/features/explore/domain/usecases/edit_category_data_usecase.dart';
    import 'package:budget_buddy/features/explore/domain/usecases/get_category_data_usecase.dart';
    import 'package:budget_buddy/features/explore/domain/usecases/insert_category_data_usecase.dart';
    import 'package:flutter/material.dart';
    import 'package:flutter_bloc/flutter_bloc.dart';

    import 'explore_states.dart';

    class ExploreCubit extends Cubit<ExploreStates> {
      ExploreCubit() : super(ExploreInitialState());

      static ExploreCubit get(context) => BlocProvider.of(context);

      getCategoryData() async {
        final response = await GetCategoryDataUseCase(
                categoryRepository: CategoryRepositoryImpl(
                    localDataSource: CategoryLocalDataSource()))
            .call();

        response.fold(
            (failure) =>
                emit(GetCategoryDataErrorState(errorMessage: failure.message)),
            (data) {
          return emit(GetCategoryDataSuccessState(items: data));
        });
        print("=====================Alhamdulillah===============================");
      }

      Future<void> insertCategoryData(CategoryEntity item) async {
        InsertCategoryDataUseCase(
                categoryRepository: CategoryRepositoryImpl(
                    localDataSource: CategoryLocalDataSource()))
            .call(item);
      }

      updateCategoryData(CategoryEntity item) async {
        UpdateCategoryDataUseCase(
                categoryRepository: CategoryRepositoryImpl(
                    localDataSource: CategoryLocalDataSource()))
            .call(item);

        print(
            "=====================Updated Alhamdulillah===============================");
      }

      final List<String> iconImages = [
        "assets/housing.png",
        "assets/saving.png",
        "assets/transportation.png",
        "assets/entertainment.png",
        "assets/healthcare.png",
        "assets/food&drink.png",
      ];
    ///****************** AddNewCategory **************************
      String categoryIcon = "assets/housing.png";
      Color categoryBackgroundColor = Colors.blueAccent;
      String categoryName = "";
      String categorySlice ="";
      CategoryEntity? newCategory;
      CategoryEntity? categoryWithNewExpense;

      changeCategoryIcon(index) {
        categoryIcon = iconImages[index];
        emit(ChangeIconState());
      }

      changeCategoryColor(color) {
        categoryBackgroundColor = color;
        emit(ChangeColorState());
      }

      addNewCategory() {
        newCategory = CategoryModel(
          name: categoryName,
          color: categoryBackgroundColor.toString(),
          icon: categoryIcon,
            categorySlice: categorySlice,
          leftToSpend: categorySlice,
          spent:"0"
        );
      }

      ///****************** AddNewExpense **************************

      double leftToSpend=0;
      double spent=0;
      String selectedExpenseCategoryName = '';

      double expenseAmount = 0;

      addExpenseToCategory () {
        categoryWithNewExpense = CategoryModel(
            name: selectedExpenseCategoryName,
            color: categoryBackgroundColor.toString(),
            icon: categoryIcon,
            categorySlice: categorySlice,
            leftToSpend:(leftToSpend-expenseAmount).toString(),
            spent: (spent).toString()

        );
        updateCategoryData(categoryWithNewExpense!);
      }
      defineCalculatedValue(String value) {
        expenseAmount = double.parse(value);
        spent+=expenseAmount;
        emit(DefineCalculatedValueState());
        getCategoryData();
      }

      defineSelectedCategory(String value) {
        selectedExpenseCategoryName = value;
        emit(DefineSelectedCategoryStateName());
        getCategoryData();
      }
    }
