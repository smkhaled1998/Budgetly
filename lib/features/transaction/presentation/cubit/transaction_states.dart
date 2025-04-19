//
// import '../../domain/entities/transaction_entity.dart';
//
// // Define states for the Explore Cubit
// abstract class TransactionStates {}
//
// class CategoryInitialState extends TransactionStates {}
//
// /// States for handling category insertion
// class CategoryInsertionLoadingState extends TransactionStates {}
// class CategoryInsertedState extends TransactionStates {}
// class CategoryInsertionErrorState extends TransactionStates {
//   final String message;
//   CategoryInsertionErrorState(this.message);
// }
//
// /// States for handling category updates
// class CategoryUpdateLoadingState extends TransactionStates {}
// class CategoryUpdatedState extends TransactionStates {}
// class CategoryUpdateErrorState extends TransactionStates {
//   final String message;
//   CategoryUpdateErrorState(this.message);
// }
//
// /// States for handling category Delete
// class CategoryDeleteLoadingState extends TransactionStates {}
// class CategoryDeletedState extends TransactionStates {}
// class CategoryDeleteErrorState extends TransactionStates {
//   final String message;
//   CategoryDeleteErrorState(this.message);
// }
// /// States for handling category retrieval
// class GetCategoryDataLoadingState extends TransactionStates {}
// class GetCategoryDataSuccessState extends TransactionStates {
//   final List<TransactionEntity> categories;
//   GetCategoryDataSuccessState({required this.categories});
// }
// class GetCategoryDataErrorState extends TransactionStates {
//   final String errorMessage;
//   GetCategoryDataErrorState({required this.errorMessage});
// }
//
// /// States for handling UI interactions
// // class ChangeAppearanceState extends TransactionStates {
// //   final List<TransactionEntity> items;
// //
// //   ChangeAppearanceState({required this.items});
// //
// // }
// // class ChangeColorState extends CategoryStates {
// //   final List<CategoryEntity> items;
// //
// //   ChangeColorState({required this.items});
// //
// // }
//
//
//
// class UpdateSpentAmountLoadingState extends TransactionStates {}
// class UpdateSpentAmountSuccessState extends TransactionStates {
//   UpdateSpentAmountSuccessState();
// }
// class UpdateSpentAmountErrorState extends TransactionStates {
//   final String errorMessage;
//   UpdateSpentAmountErrorState({required this.errorMessage});
// }
//
// class ToggleCategoryEditModeState extends TransactionStates {}
// class AddSettingUpCategoryState extends TransactionStates {}
// class AddSettingUpCategoryLoadingState extends TransactionStates {}
//
// class UpdateRemainingSalaryState extends TransactionStates {}
// class ExpenseEntryInitialState extends TransactionStates{}
//
// class ExpenseEntryAddedState extends TransactionStates{}
// class ExpenseEntryLoadedState extends TransactionStates{
//   ExpenseEntryLoadedState(List<TransactionEntity> entries);
// }
// class ExpenseEntryEditedState extends TransactionStates{}
// class ExpenseEntryDeletedState extends TransactionStates{}
//
//
// class ExpenseEntryLoadingState extends TransactionStates{}
// class ValuesResetState extends TransactionStates{}
// class DefineExpenseDetailsState extends TransactionStates{}
//
// class ExpenseEntryErrorState extends TransactionStates{
//   ExpenseEntryErrorState(String message);
// }
// class ExpenseEntrySuccessState extends TransactionStates{
// }

import '../../../transaction/domain/entities/transaction_entity.dart';

abstract class TransactionStates{}


class TransactionInitialState extends TransactionStates{}
class TogglePieChartState extends TransactionStates {}
class TransactionEditModeState extends TransactionStates {}


class ExpenseEntryAddedState extends TransactionStates{}
class ExpenseEntryLoadedState extends TransactionStates{
  ExpenseEntryLoadedState(List<TransactionEntity> entries);
}
class ExpenseEntryEditedState extends TransactionStates{}
class ExpenseEntryDeletedState extends TransactionStates{}


class ExpenseEntryLoadingState extends TransactionStates{}
class ValuesResetState extends TransactionStates{}
class DefineExpenseDetailsState extends TransactionStates{}

class ExpenseEntryErrorState extends TransactionStates{
  ExpenseEntryErrorState(String message);
}
class ExpenseEntrySuccessState extends TransactionStates{
}