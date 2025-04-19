
import '../../../transaction/domain/entities/transaction_entity.dart';

abstract class TransactionStates{}


class TransactionInitialState extends TransactionStates{}
class TogglePieChartState extends TransactionStates {}


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