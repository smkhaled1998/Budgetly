import '../../../../core/domain/entities/category_management_entity.dart';
import '../../../transaction/domain/entities/transaction_entity.dart';

abstract class CategoryManagementStates{}

class CategoryManagementInitialStates extends CategoryManagementStates{}


/// States for handling category insertion
class CategoryInsertionLoadingState extends CategoryManagementStates {}
class CategoryInsertedState extends CategoryManagementStates {}
class CategoryInsertionErrorState extends CategoryManagementStates {
  final String message;
  CategoryInsertionErrorState(this.message);
}

/// States for handling category updates
class CategoryUpdateLoadingState extends CategoryManagementStates {}
class CategoryUpdatedState extends CategoryManagementStates {}
class CategoryUpdateErrorState extends CategoryManagementStates {
  final String message;
  CategoryUpdateErrorState(this.message);
}

/// States for handling category Delete
class CategoryDeleteLoadingState extends CategoryManagementStates {}
class CategoryDeletedState extends CategoryManagementStates {}
class CategoryDeleteErrorState extends CategoryManagementStates {
  final String message;
  CategoryDeleteErrorState(this.message);
}
/// States for handling category retrieval
class GetCategoryDataLoadingState extends CategoryManagementStates {}
class GetCategoryDataSuccessState extends CategoryManagementStates {
  final List<CategoryManagementEntity> categories;
  GetCategoryDataSuccessState({required this.categories});
}
class GetCategoryDataErrorState extends CategoryManagementStates {
  final String errorMessage;
  GetCategoryDataErrorState({required this.errorMessage});
}

/// States for handling UI interactions
class ChangeAppearanceState extends CategoryManagementStates {
  final List<CategoryManagementEntity> items;
  ChangeAppearanceState({required this.items});

}


// class UpdateSpentAmountLoadingState extends TransactionStates {}
// class UpdateSpentAmountSuccessState extends TransactionStates {
//   UpdateSpentAmountSuccessState();
// }
// class UpdateSpentAmountErrorState extends TransactionStates {
//   final String errorMessage;
//   UpdateSpentAmountErrorState({required this.errorMessage});
// }

class ToggleCategoryEditModeState extends CategoryManagementStates {}
class AddSettingUpCategoryState extends CategoryManagementStates {}
class AddSettingUpCategoryLoadingState extends CategoryManagementStates {}

