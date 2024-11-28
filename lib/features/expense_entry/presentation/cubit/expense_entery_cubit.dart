import 'package:budget_buddy/features/expense_entry/data/datasources/expense_entry_datasource.dart';
import 'package:budget_buddy/features/expense_entry/data/repositories/expense_entry_repository_imp.dart';
import 'package:budget_buddy/features/expense_entry/domain/usecases/add_expense_entry_usecase.dart';
import 'package:budget_buddy/features/expense_entry/domain/usecases/delete_expense_entry_usecase.dart';
import 'package:budget_buddy/features/expense_entry/domain/usecases/edit_expense_entry_usecase.dart';
import 'package:budget_buddy/features/expense_entry/domain/usecases/get_expense_entries_usecase.dart';
import 'package:budget_buddy/features/expense_entry/presentation/cubit/expense_entry_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/expense_entery_model.dart';

class ExpenseEntryCubit extends Cubit<ExpenseEntryStates> {
  ExpenseEntryCubit() : super(ExpenseEntryInitialState());

  static ExpenseEntryCubit get(context) => BlocProvider.of(context);

  // القيمة التي تم إنفاقها
  int? categoryId;
  String  expenseAmount='' ; // [معدل] متغير الحالة لتخزين القيمة المحسوبة
  String selectedCategory = '';

  Future<void> addExpenseEntry(ExpenseEntryModel item) async {
    final useCase = AddExpenseEntryUseCase(
      expenseEntryRepository: ExpenseEntryRepositoryImpl(
        localDataSource: ExpenseEntryDataSource(),
      ),
    );

    final result = await useCase.call(item);
    result.fold(
          (failure) {
        print('Error occurred: ${failure.message}');
        emit(ExpenseEntryErrorState(failure.message));
      },
          (_) {
        print('Expense entry added successfully');
        // entryCount++; // زيادة عدد المدخلات
        emit(ExpenseEntryAddedState());
      },
    );
  }

  Future<void> deleteExpenseEntry(int expenseEntryId) async {
    final useCase = DeleteExpenseEntryUseCase(
      expenseEntryRepository: ExpenseEntryRepositoryImpl(
        localDataSource: ExpenseEntryDataSource(),
      ),
    );

    final result = await useCase.call(expenseEntryId);
    result.fold(
          (failure) {
        print('Error occurred: ${failure.message}');
        emit(ExpenseEntryErrorState(failure.message));
      },
          (_) {
        print('Expense entry deleted successfully');
        // entryCount--; // تقليل عدد المدخلات
        emit(ExpenseEntryDeletedState());
      },
    );
  }

  Future<void> editExpenseEntry(ExpenseEntryModel item) async {
    final useCase = EditExpenseEntryUseCase(
      expenseEntryRepository: ExpenseEntryRepositoryImpl(
        localDataSource: ExpenseEntryDataSource(),
      ),
    );

    final result = await useCase.call(item);
    result.fold(
          (failure) {
        print('Error occurred: ${failure.message}');
        emit(ExpenseEntryErrorState(failure.message));
      },
          (_) {
        print('Expense entry edited successfully');
        emit(ExpenseEntryEditedState());
      },
    );
  }

  Future<void> getExpenseEntries() async {
    emit(ExpenseEntryLoadingState()); // إضافة حالة تحميل
    final useCase = GetExpenseEntriesUseCase(
      expenseEntryRepository: ExpenseEntryRepositoryImpl(
        localDataSource: ExpenseEntryDataSource(),
      ),
    );

    final result = await useCase.call();
    result.fold(
          (failure) {
        print('Error occurred: ${failure.message}');
        emit(ExpenseEntryErrorState(failure.message));
      },
          (entries) {
        print('Retrieved expense entries successfully');
        print(entries[2].date);

        emit(ExpenseEntryLoadedState(entries));
      },
    );
  }

  void defineCalculatedValue(String value) {
    try {
      // expenseAmount = double.parse(value);
      // spent += expenseAmount; // إضافة القيمة إلى المبلغ المنفق
      emit(DefineCalculatedValueState());
    } catch (e) {
      print('Invalid value for expenseAmount: $value');
    }
  }

  void defineSelectedCategory(String categoryName, int id) {
    selectedCategory = categoryName;
    categoryId = id; // تعيين معرف الفئة المحددة
    emit(DefineSelectedCategoryState());
  }
  void resetValues() {
    // spent = 0.0;
    // expenseAmount = 0.0;
    // entryCount = 0; // إعادة تعيين عدد المدخلات
    emit(ValuesResetState());
  }

  void updateCalculatedValue(value) {
    expenseAmount=value;
    emit(DefineCalculatedValueState());
  }
}
