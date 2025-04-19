// import 'package:budget_buddy/core/main_navigator.dart';
// import 'package:budget_buddy/features/expense_entry/data/models/expense_entery_model.dart';
// import 'package:budget_buddy/features/expense_entry/presentation/cubit/expense_entry_states.dart';
// import 'package:budget_buddy/features/expense_entry/presentation/widgets/Expense_Entry_bottom_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../../core/themes/app_color.dart';
//
// import '../../../transaction/presentation/cubit/transaction_cubit.dart';
// import '../../../transaction/presentation/cubit/transaction_states.dart';
// import '../cubit/expense_entery_cubit.dart';
// import '../widgets/Expense_Entry_app_bar.dart';
// import '../widgets/calculator_widget.dart';
// import '../widgets/category_item_widget.dart';
//
// class ExpenseEntryScreen extends StatelessWidget {
//   ExpenseEntryScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<ExpenseEntryCubit>(
//           create: (context) => ExpenseEntryCubit(),
//         ),
//         BlocProvider<TransactionCubit>(
//           create: (context) => TransactionCubit()..fetchCategories(),
//         ),
//       ],
//       child: BlocBuilder<ExpenseEntryCubit, ExpenseEntryStates>(
//         builder: (context, expenseState) {
//           ExpenseEntryCubit expenseCubit = ExpenseEntryCubit.get(context);
//            int? categoryId;
//           return Scaffold(
//             appBar:const ExpenseEntryAppBar() ,
//             body: BlocBuilder<TransactionCubit, TransactionStates>(
//               builder: (context, state) {
//                 if (state is GetCategoryDataLoadingState) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 else if (state is GetCategoryDataSuccessState) {
//                   final categories = state.categories;
//                   return ListView.separated(
//                     itemCount: categories.length,
//                     itemBuilder: (context, index) {
//                       final category = categories[index];
//                       return CategoryItemExpenseWidget(
//                         categoryEntity: category,
//                         onTap: () {
//                           categoryId = category.categoryId!;
//                           expenseCubit.defineSelectedCategory(category.name!, categoryId!);
//                           ExpenseEntryCubit.get(context).storedSpentAmount=category.storedSpentAmount;
//                           _showCalculator(context, expenseCubit.selectedCategory);
//                           print("Selected category: ${category.name}");
//                         },
//                       );
//                     },
//
//                     separatorBuilder: (context, index) => const Divider(),
//                   );
//                 }
//                 else if (state is GetCategoryDataErrorState) {
//                   return Center(
//                     child: Text(
//                       "Error: ${state.errorMessage}",
//                       style: const TextStyle(color: Colors.red),
//                     ),
//                   );
//                 } else {
//                   return const Center(child: Text("No categories available"));
//                 }
//               },
//             ),
//             floatingActionButton: FloatingActionButton(
//
//               onPressed: () {
//                 TransactionCubit categoryCubit=TransactionCubit.get(context);
//                 _handleSubmit(context, expenseCubit, categoryCubit);
//                 // _showCalculator(context, expenseCubit.selectedCategory);
//               },
//               backgroundColor: AppColor.lightGray,
//               child: const Icon(Icons.done),
//             ),
//             bottomNavigationBar: const ExpenseEntryBottomBar()
//           );
//         },
//       ),
//     );
//   }
//   void _handleSubmit(
//       BuildContext context,
//       ExpenseEntryCubit expenseCubit,
//       TransactionCubit categoryCubit,
//
//
//       ) {
//     if (expenseCubit.selectedCategory.isNotEmpty &&
//         expenseCubit.enteredAmount.isNotEmpty) {
//         ExpenseEntryModel item = ExpenseEntryModel(
//         categoryId: expenseCubit.categoryId!,
//         amount: double.parse(expenseCubit.enteredAmount),
//         date: DateTime.now(),
//       );
//
//       expenseCubit.addExpenseEntry(item);
//       double spent = expenseCubit.storedSpentAmount! + double.parse(expenseCubit.enteredAmount);
//       categoryCubit.updateCategorySpending(expenseCubit.categoryId!,spent);
//       Navigator.push(context,   MaterialPageRoute(builder: (context)=>const MainNavigator()) );
//       // Show success feedback
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: const Text('Expense added successfully!'),
//           backgroundColor: Colors.green,
//           behavior: SnackBarBehavior.floating,
//           margin: EdgeInsets.only(
//             bottom: MediaQuery.of(context).size.height - 100,
//             left: 16,
//             right: 16,
//           ),
//         ),
//       );
//
//       // Navigate back
//     } else {
//       // Show error feedback
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Please select a category and enter an amount'),
//           backgroundColor: Colors.red,
//           behavior: SnackBarBehavior.floating,
//         ),
//       );
//     }
//   }
//
//   void _showCalculator(BuildContext context, String selectedCategory) {
//     ExpenseEntryCubit cubit = ExpenseEntryCubit.get(context);
//
//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return CalculatorWidget(
//           selectedCategory: selectedCategory,
//           onValueSelected: (value) {
//             cubit.updateCalculatedValue(value);
//             Navigator.pop(context);
//             print("Calculated Value: ${cubit.enteredAmount}");
//           },
//         );
//       },
//     );
//   }
//
// }
