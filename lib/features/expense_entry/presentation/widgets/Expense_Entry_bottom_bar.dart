//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../../../../core/themes/app_color.dart';
//
// import '../cubit/expense_entery_cubit.dart';
// import '../cubit/expense_entry_states.dart';
//
//
//
// class ExpenseEntryBottomBar extends StatelessWidget {
//   const ExpenseEntryBottomBar({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // CategoryCubit categoryCubit = CategoryCubit.get(context);
//     ExpenseEntryCubit expenseCubit = ExpenseEntryCubit.get(context);
//
//     return Container(
//       height: 100,
//       margin: const EdgeInsets.all(16),
//       child: Stack(
//         clipBehavior: Clip.none,
//         children: [
//           // Main Bottom Bar Container
//           Container(
//             height: 80,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   AppColor.primaryColor,
//                   AppColor.primaryColor.withOpacity(0.8),
//                 ],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               borderRadius: BorderRadius.circular(25),
//               boxShadow: [
//                 BoxShadow(
//                   color: AppColor.primaryColor.withOpacity(0.3),
//                   spreadRadius: 2,
//                   blurRadius: 15,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: BlocBuilder<ExpenseEntryCubit, TransactionStates>(
//               builder: (context, state) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 24),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       // Category Section
//                       _buildInfoColumn(
//                         title: 'Category',
//                         value: expenseCubit.selectedCategory.isNotEmpty
//                             ? expenseCubit.selectedCategory
//                             : "Select Category",
//                         icon: Icons.category_outlined,
//                       ),
//                       // Amount Section
//                       _buildInfoColumn(
//                         title: 'Amount',
//                         value: expenseCubit.enteredAmount.isNotEmpty
//                             ? '\$${expenseCubit.enteredAmount}'
//                             : '\$0.00',
//                         icon: Icons.attach_money_rounded,
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//
//           // Floating Action Button
//           // Positioned(
//           //   top: -20,
//           //   left: MediaQuery.of(context).size.width / 2 - 92,
//           //   child: GestureDetector(
//           //     onTap: () => _handleSubmit(context, expenseCubit, categoryCubit),
//           //     child: Container(
//           //       width: 60,
//           //       height: 60,
//           //       decoration: BoxDecoration(
//           //         gradient: const LinearGradient(
//           //           colors: [Colors.white, Colors.white70],
//           //           begin: Alignment.topLeft,
//           //           end: Alignment.bottomRight,
//           //         ),
//           //         shape: BoxShape.circle,
//           //         boxShadow: [
//           //           BoxShadow(
//           //             color: Colors.black.withOpacity(0.1),
//           //             spreadRadius: 2,
//           //             blurRadius: 10,
//           //           ),
//           //         ],
//           //       ),
//           //       child: Container(
//           //         margin: const EdgeInsets.all(4),
//           //         decoration: BoxDecoration(
//           //           shape: BoxShape.circle,
//           //           gradient: LinearGradient(
//           //             colors: [
//           //               AppColor.primaryColor,
//           //               AppColor.primaryColor.withOpacity(0.8),
//           //             ],
//           //           ),
//           //         ),
//           //         child: const Icon(
//           //           Icons.check_rounded,
//           //           color: Colors.white,
//           //           size: 32,
//           //         ),
//           //       ),
//           //     ),
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildInfoColumn({
//     required String title,
//     required String value,
//     required IconData icon,
//   }) {
//     return Row(
//       children: [
//         Icon(
//           icon,
//           color: Colors.white70,
//           size: 20,
//         ),
//         const SizedBox(width: 8),
//         Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: GoogleFonts.poppins(
//                 fontSize: 12,
//                 color: Colors.white70,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               value,
//               style: GoogleFonts.poppins(
//                 fontSize: 14,
//                 color: Colors.white,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   // void _handleSubmit(
//   //     BuildContext context,
//   //     ExpenseEntryCubit expenseCubit,
//   //     CategoryCubit categoryCubit,
//   //     ) {
//   //   if (expenseCubit.selectedCategory.isNotEmpty &&
//   //       expenseCubit.enteredAmount.isNotEmpty) {
//   //     ExpenseEntryModel item = ExpenseEntryModel(
//   //       categoryId: expenseCubit.categoryId!,
//   //       amount: double.parse(expenseCubit.enteredAmount),
//   //       date: DateTime.now(),
//   //     );
//   //
//   //     expenseCubit.addExpenseEntry(item);
//   //     double itemAmountSpent = expenseCubit.storedSpentAmount! + double.parse(expenseCubit.enteredAmount);
//   //     categoryCubit.updateCategorySpending(expenseCubit.categoryId!, itemAmountSpent);
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(
//   //         content: const Text('Expense added successfully!'),
//   //         backgroundColor: Colors.green,
//   //         behavior: SnackBarBehavior.floating,
//   //         margin: EdgeInsets.only(
//   //           bottom: MediaQuery.of(context).size.height - 100,
//   //           left: 16,
//   //           right: 16,
//   //         ),
//   //       ),
//   //     );
//   //
//   //     Navigator.push(context, MaterialPageRoute(builder: (context)=>const MainNavigator()));
//   //
//   //   } else {
//   //     // Show error feedback
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       const SnackBar(
//   //         content: Text('Please select a category and enter an amount'),
//   //         backgroundColor: Colors.red,
//   //         behavior: SnackBarBehavior.floating,
//   //       ),
//   //     );
//   //   }
//   // }
// }