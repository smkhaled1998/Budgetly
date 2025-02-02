import 'package:budget_buddy/core/main_navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/themes/app_color.dart';
import '../../../category/presentation/cubit/category_cubit.dart';
import '../../data/models/expense_entery_model.dart';
import '../cubit/expense_entery_cubit.dart';
import '../cubit/expense_entry_states.dart';

class ExpenseEntryBottomBar extends StatelessWidget {
  const ExpenseEntryBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CategoryCubit categoryCubit = CategoryCubit.get(context);
    ExpenseEntryCubit expenseCubit = ExpenseEntryCubit.get(context);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 80,
          decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: BlocBuilder<ExpenseEntryCubit, ExpenseEntryStates>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Category',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        expenseCubit.selectedCategory.isNotEmpty
                            ? expenseCubit.selectedCategory
                            : "Sample Category",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Value',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        expenseCubit.expenseAmount.isNotEmpty
                            ? '\$ ${expenseCubit.expenseAmount}'
                            : '\$ 0',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
        Positioned(
          top: -35, // جعل الزر بارزاً قليلاً
          left: MediaQuery.of(context).size.width / 2 - 35, // التوسيط بدقة
          child: GestureDetector(
            onTap: () {
              _updateSpentAmount(expenseCubit,categoryCubit);
              categoryCubit.fetchBudgetCategories();
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MainNavigator()));
            },
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Center(
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.primaryColor,
                  ),
                  child: const Icon(
                    Icons.done,
                    size: 28,
                    color: AppColor.backgroundColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );


  }
  void _updateSpentAmount(expenseCubit,categoryCubit){
    if (expenseCubit.selectedCategory.isNotEmpty &&
        expenseCubit.expenseAmount.isNotEmpty) {
      ExpenseEntryModel item = ExpenseEntryModel(
        categoryId: expenseCubit.categoryId!,
        amount: double.parse(expenseCubit.expenseAmount),
        date: DateTime.now(),
      );

      expenseCubit.addExpenseEntry(item);
      double spent = categoryCubit.spentAmount! +
          double.parse(expenseCubit.expenseAmount);

      categoryCubit.updateCategorySpending(expenseCubit.categoryId!, spent);

      print("Expense saved successfully");
    } else {
      print("Please fill in all fields.");
    }
  }
}
