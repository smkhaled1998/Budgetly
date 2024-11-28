import 'package:budget_buddy/features/expense_entry/domain/entities/expense_entry_entity.dart';

abstract class ExpenseEntryStates{}


class ExpenseEntryInitialState extends ExpenseEntryStates{}

class ExpenseEntryAddedState extends ExpenseEntryStates{}
class ExpenseEntryLoadedState extends ExpenseEntryStates{
  ExpenseEntryLoadedState(List<ExpenseEntryEntity> entries);
}
class ExpenseEntryEditedState extends ExpenseEntryStates{}
class ExpenseEntryDeletedState extends ExpenseEntryStates{}


class ExpenseEntryLoadingState extends ExpenseEntryStates{}
class ValuesResetState extends ExpenseEntryStates{}
class DefineCalculatedValueState extends ExpenseEntryStates{}
class DefineSelectedCategoryState extends ExpenseEntryStates{}

class ExpenseEntryErrorState extends ExpenseEntryStates{
  ExpenseEntryErrorState(String message);
}
  class ExpenseEntrySuccessState extends ExpenseEntryStates{
}