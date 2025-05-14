import 'package:budget_buddy/core/domain/entities/sub_category-entity.dart';

import '../../../../core/domain/entities/category_entity.dart';
import '../../../transaction/domain/entities/transaction_entity.dart';

abstract class SubcategoryStates{}

class SubcategoryManagementInitialStates extends SubcategoryStates{}


/// States for handling category insertion
class SubcategoryInsertionLoadingState extends SubcategoryStates {}
class SubcategoryInsertedState extends SubcategoryStates {}
class SubcategoryInsertionErrorState extends SubcategoryStates {
  final String message;
  SubcategoryInsertionErrorState(this.message);
}

/// States for handling category updates
class SubcategoryUpdateLoadingState extends SubcategoryStates {}
class SubcategoryUpdatedState extends SubcategoryStates {}
class SubcategoryUpdateErrorState extends SubcategoryStates {
  final String message;
  SubcategoryUpdateErrorState(this.message);
}

/// States for handling category Delete
class SubcategoryDeleteLoadingState extends SubcategoryStates {}
class SubcategoryDeletedState extends SubcategoryStates {}
class SubcategoryDeleteErrorState extends SubcategoryStates {
  final String message;
  SubcategoryDeleteErrorState(this.message);
}
/// States for handling category retrieval
class GetSubcategoryDataLoadingState extends SubcategoryStates {}
class GetSubcategoryDataSuccessState extends SubcategoryStates {
  final List<SubcategoryEntity> subcategories;
  GetSubcategoryDataSuccessState({required this.subcategories});
}
class GetCategoryDataErrorState extends SubcategoryStates {
  final String errorMessage;
  GetCategoryDataErrorState({required this.errorMessage});
}

/// States for handling UI interactions
class ChangeSubcategoryAppearanceState extends SubcategoryStates {
  final List<SubcategoryEntity> items;
  ChangeSubcategoryAppearanceState({required this.items});

}


// class UpdateSpentAmountLoadingState extends TransactionStates {}
// class UpdateSpentAmountSuccessState extends TransactionStates {
//   UpdateSpentAmountSuccessState();
// }
// class UpdateSpentAmountErrorState extends TransactionStates {
//   final String errorMessage;
//   UpdateSpentAmountErrorState({required this.errorMessage});
// }

class ToggleCategoryEditModeState extends SubcategoryStates {}
class AddSettingUpCategoryState extends SubcategoryStates {}
class AddSettingUpCategoryLoadingState extends SubcategoryStates {}

