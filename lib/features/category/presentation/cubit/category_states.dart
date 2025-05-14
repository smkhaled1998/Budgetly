import '../../../../core/domain/entities/category_entity.dart';
import '../../../transaction/domain/entities/transaction_entity.dart';

abstract class CategoryStates{}

class CategoryManagementInitialStates extends CategoryStates{}
class TogglePieChartState extends CategoryStates{}


/// States for handling category insertion
class CategoryInsertionLoadingState extends CategoryStates {}
class CategoryInsertedState extends CategoryStates {}
class CategoryInsertionErrorState extends CategoryStates {
  final String message;
  CategoryInsertionErrorState(this.message);
}

/// States for handling category updates
class CategoryUpdateLoadingState extends CategoryStates {}
class CategoryUpdatedState extends CategoryStates {}
class CategoryUpdateErrorState extends CategoryStates {
  final String message;
  CategoryUpdateErrorState(this.message);
}

/// States for handling category Delete
class CategoryDeleteLoadingState extends CategoryStates {}
class CategoryDeletedState extends CategoryStates {}
class CategoryDeleteErrorState extends CategoryStates {
  final String message;
  CategoryDeleteErrorState(this.message);
}

/// States for handling category retrieval
class GetCategoryDataLoadingState extends CategoryStates {}
class GetCategoryDataSuccessState extends CategoryStates {
  final List<CategoryEntity> categories;
  GetCategoryDataSuccessState({required this.categories});
}
class GetCategoryDataErrorState extends CategoryStates {
  final String errorMessage;
  GetCategoryDataErrorState({required this.errorMessage});
}

/// States for handling UI interactions
class ChangeCategoryAppearanceState extends CategoryStates {
  final List<CategoryEntity> items;
  ChangeCategoryAppearanceState({required this.items});

}




class ToggleCategoryEditModeState extends CategoryStates {}
class AddSettingUpCategoryState extends CategoryStates {}
class AddSettingUpCategoryLoadingState extends CategoryStates {}
class UpdateRemainingSalaryState extends CategoryStates {}

