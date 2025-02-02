import 'dart:async'; // لإضافة التأخير لتفعيل الأنيميشن
import 'package:budget_buddy/features/expense_entry/data/models/expense_entery_model.dart';
import 'package:budget_buddy/features/expense_entry/presentation/cubit/expense_entry_states.dart';
import 'package:budget_buddy/features/expense_entry/presentation/widgets/Expense_Entry_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/themes/app_color.dart';
import '../../../category/presentation/cubit/category_cubit.dart';
import '../../../category/presentation/cubit/category_states.dart';
import '../cubit/expense_entery_cubit.dart';
import '../widgets/Expense_Entry_app_bar.dart';
import '../widgets/calculator_widget.dart';
import '../widgets/category_item_widget.dart';

class ExpenseEntryScreen extends StatelessWidget {
  ExpenseEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ExpenseEntryCubit>(
          create: (context) => ExpenseEntryCubit(),
        ),
        BlocProvider<CategoryCubit>(
          create: (context) => CategoryCubit()..fetchBudgetCategories(),
        ),
      ],
      child: BlocBuilder<ExpenseEntryCubit, ExpenseEntryStates>(
        builder: (context, expenseState) {
          ExpenseEntryCubit expenseCubit = ExpenseEntryCubit.get(context);
           int? categoryId;
          return Scaffold(
            appBar:ExpenseEntryAppBar() ,
            body: BlocBuilder<CategoryCubit, CategoryStates>(
              builder: (context, state) {
                if (state is GetCategoryDataLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                else if (state is GetCategoryDataSuccessState) {
                  final categories = state.categories;
                  return ListView.separated(
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return CategoryItemWidget(
                        category: category,
                        onTap: () {
                          categoryId = category.categoryId!;
                          expenseCubit.defineSelectedCategory(category.name!, categoryId!);
                          CategoryCubit.get(context).spentAmount=category.spentAmount;


                          _showCalculator(context, expenseCubit.selectedCategory);
                          print("Selected category: ${category.name}");
                        },
                      );
                    },

                    separatorBuilder: (context, index) => const Divider(),
                  );
                }
                else if (state is GetCategoryDataErrorState) {
                  return Center(
                    child: Text(
                      "Error: ${state.errorMessage}",
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else {
                  return const Center(child: Text("No categories available"));
                }
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                _showCalculator(context, expenseCubit.selectedCategory);
              },
              backgroundColor: AppColor.lightGray,
              tooltip: 'Show Calculator',
              child: const Icon(Icons.calculate),
            ),
            bottomNavigationBar: const ExpenseEntryBottomBar()
          );
        },
      ),
    );
  }

  void _showCalculator(BuildContext context, String selectedCategory) {
    ExpenseEntryCubit cubit = ExpenseEntryCubit.get(context);

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return CalculatorWidget(
          selectedCategory: selectedCategory,
          onValueSelected: (value) {
            cubit.updateCalculatedValue(value);
            Navigator.pop(context);
            print("Calculated Value: ${cubit.expenseAmount}");
          },
        );
      },
    );
  }

}
