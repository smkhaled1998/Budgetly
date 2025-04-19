// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../core/data/database/category_management_datasource.dart';
// import '../../data/models/transaction_model.dart';
// import '../../data/repositories/transaction_repository_imp.dart';
// import '../../domain/entities/transaction_entity.dart';
// import 'transaction_states.dart';
//
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../expense_entry/presentation/cubit/expense_entry_states.dart';

class TransactionCubit extends Cubit<TransactionStates> {
  TransactionCubit() : super(TransactionInitialState());

  static TransactionCubit get(context) => BlocProvider.of(context);

  bool showPieChart = false;

  void togglePieChart() {
    showPieChart = !showPieChart;
    emit(TogglePieChartState());
  }
}

//   List<TransactionEntity> fetchedCategories = [];
//
//
//   // double? spentAmount;
//
//   Future<void> updateCategorySpending(int categoryId, double spentAmount) async {
//     emit(UpdateSpentAmountLoadingState()); // حالة التحميل
//     final useCase = UpdateSpentAmountUseCase(
//       categoryRepository: TransactionRepositoryImpl(
//         localDataSource: CategoryManagementDataSource(),
//       ),
//     );
//
//     final result = await useCase.call(categoryId, spentAmount);
//     result.fold(
//           (failure) {
//         print('Error occurred: \${failure.message}');
//         emit(UpdateSpentAmountErrorState( errorMessage: failure.message));
//       },
//           (_) {
//         print('Spent amount updated successfully');
//         fetchCategories();
//         emit(UpdateSpentAmountSuccessState());
//         fetchCategories(); // تحديث الفئات بعد التحديث
//       },
//     );
//   }
//
//   Future<void> initializeCategoriesStage(List <TransactionEntity> categories) async {
//     emit(CategoryInsertionLoadingState());
//     final useCase = InitializeCategoriesUseCase(
//       categoryRepository: TransactionRepositoryImpl(
//         localDataSource: CategoryManagementDataSource(),
//       ),
//     );
//
//     final result = await useCase.call(categories);
//
//     result.fold(
//           (failure) {
//         print('Error occurred: \${failure.message}');
//         emit(CategoryInsertionErrorState(failure.message));
//       },
//           (_) {
//         print('Category inserted successfully');
//         emit(CategoryInsertedState());
//         fetchCategories(); // تحديث الفئات بعد الإضافة
//       },
//     );
//   }
//
// ///*********************************************************
//
//
//
//
//
//   ///*******************************************************////////
//   int remainingBudget=0;
//   int currentCategoryIndex=0;
//   int totalAllocatedBudgetBasedOnMap=0;
//   Map<int,int> mappedAllocatedCategoryAmount={};
//   void updateRemainingBudgetForProgressBarInSettingUpstage(int difference) {
//     remainingBudget += difference;
//     emit(UpdateRemainingSalaryState());
//   }
//   void updateCategoryAllocationAndTotalBudgetInSettingUpstage(int index, int value) {
//
//     mappedAllocatedCategoryAmount[index] = (mappedAllocatedCategoryAmount[index] ?? 0) + value;
//     totalAllocatedBudgetBasedOnMap = 0;
//     mappedAllocatedCategoryAmount.forEach((key, val) {
//       if (key != index) {
//         totalAllocatedBudgetBasedOnMap += val;
//       }
//     });
//
//   }
//
//   int? categoryId;
//   String  enteredAmount='' ;
//   String selectedCategory = '';
//   double? storedSpentAmount;
//
//   Future<void> addExpenseEntry(TransactionModel item) async {
//
//     final useCase = AddExpenseEntryUseCase(
//       expenseEntryRepository: ExpenseEntryRepositoryImpl(
//         localDataSource: TransactionDataSource(),
//       ),
//     );
//
//     final result = await useCase.call(item);
//     result.fold(
//           (failure) {
//         print('Error occurred: ${failure.message}');
//         emit(ExpenseEntryErrorState(failure.message));
//       },
//           (_) {
//         print('Expense entry added successfully');
//         emit(ExpenseEntryAddedState());
//       },
//     );
//   }
//
//   Future<void> deleteExpenseEntry(int expenseEntryId) async {
//     final useCase = DeleteExpenseEntryUseCase(
//       expenseEntryRepository: ExpenseEntryRepositoryImpl(
//         localDataSource: TransactionDataSource(),
//       ),
//     );
//
//     final result = await useCase.call(expenseEntryId);
//     result.fold(
//           (failure) {
//         print('Error occurred: ${failure.message}');
//         emit(ExpenseEntryErrorState(failure.message));
//       },
//           (_) {
//         print('Expense entry deleted successfully');
//         // entryCount--; // تقليل عدد المدخلات
//         emit(ExpenseEntryDeletedState());
//       },
//     );
//   }
//
//   Future<void> editExpenseEntry(TransactionModel item) async {
//     final useCase = EditExpenseEntryUseCase(
//       expenseEntryRepository: ExpenseEntryRepositoryImpl(
//         localDataSource: TransactionDataSource(),
//       ),
//     );
//
//     final result = await useCase.call(item);
//     result.fold(
//           (failure) {
//         print('Error occurred: ${failure.message}');
//         emit(ExpenseEntryErrorState(failure.message));
//       },
//           (_) {
//         print('Expense entry edited successfully');
//         emit(ExpenseEntryEditedState());
//       },
//     );
//   }
//
//   Future<void> getExpenseEntries() async {
//     emit(ExpenseEntryLoadingState()); // إضافة حالة تحميل
//     final useCase = GetExpenseEntriesUseCase(
//       expenseEntryRepository: ExpenseEntryRepositoryImpl(
//         localDataSource: TransactionDataSource(),
//       ),
//     );
//
//     final result = await useCase.call();
//     result.fold(
//           (failure) {
//         print('Error occurred: ${failure.message}');
//         emit(ExpenseEntryErrorState(failure.message));
//       },
//           (entries) {
//         print('Retrieved expense entries successfully');
//         print(entries[2].date);
//
//         emit(ExpenseEntryLoadedState(entries));
//       },
//     );
//   }
//
//   // void defineCalculatedValue(String value) {
//   //   try {
//   //     // expenseAmount = double.parse(value);
//   //     // spent += expenseAmount; // إضافة القيمة إلى المبلغ المنفق
//   //     emit(DefineCalculatedValueState());
//   //   } catch (e) {
//   //     print('Invalid value for expenseAmount: $value');
//   //   }
//   // }
//
//   void defineSelectedCategory(String categoryName, int id) {
//     selectedCategory = categoryName;
//     categoryId = id; // تعيين معرف الفئة المحددة
//     emit(DefineExpenseDetailsState ());
//   }
//   void resetValues() {
//     // spent = 0.0;
//     // expenseAmount = 0.0;
//     // entryCount = 0; // إعادة تعيين عدد المدخلات
//     emit(ValuesResetState());
//   }
//
//   void updateCalculatedValue(value) {
//     enteredAmount=value;
//     emit(DefineExpenseDetailsState());
//   }
// }
