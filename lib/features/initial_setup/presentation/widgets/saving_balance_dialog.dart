//
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../../../../core/main_navigator.dart';
// import '../../../transaction/data/models/transaction_model.dart';
// import '../../../transaction/domain/entities/transaction_entity.dart';
// import '../../../transaction/presentation/cubit/transaction_cubit.dart';
//
// class SavingBalanceDialog extends StatelessWidget {
//   const SavingBalanceDialog({
//     Key? key,
//   }) : super(key: key);
//
//
//   @override
//   Widget build(BuildContext context) {
//    TransactionCubit categoryCubit=TransactionCubit.get(context);
//     return AlertDialog(
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(20),
//     ),
//     backgroundColor: Colors.white,
//     contentPadding: EdgeInsets.zero,
//     content: Container(
//       padding: const EdgeInsets.all(24),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.blue.withOpacity(0.1),
//               shape: BoxShape.circle,
//             ),
//             child: const Icon(
//               Icons.savings_rounded,
//               color: Colors.blue,
//               size: 32,
//             ),
//           ),
//           const Gap(16),
//           Text(
//             "Remaining Balance",
//             style: GoogleFonts.roboto(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Colors.black87,
//             ),
//           ),
//           const Gap(8),
//           Text(
//             "You have remaining balance of",
//             textAlign: TextAlign.center,
//             style: GoogleFonts.roboto(
//               color: Colors.black54,
//               fontSize: 16,
//             ),
//           ),
//           const Gap(8),
//           Text(
//             "\$${categoryCubit.remainingBudget.toStringAsFixed(2)}",
//             style: GoogleFonts.roboto(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: Colors.blue,
//             ),
//           ),
//           const Gap(24),
//           Row(
//             children: [
//               Expanded(
//                 child: TextButton(
//                   onPressed: () {
//                     Navigator.pop(context, 'update_categories');
//                   },
//                   style: TextButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 12),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       side: BorderSide(
//                         color: Colors.blue.withOpacity(0.5),
//                       ),
//                     ),
//                   ),
//                   child: Text(
//                     "Update Categories",
//                     style: GoogleFonts.roboto(
//                       color: Colors.blue,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ),
//               const Gap(12),
//               Expanded(
//                 child: ElevatedButton(
//                   onPressed: () async{
//                     _manageSavingBudget(categoryCubit,context);
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     padding: const EdgeInsets.symmetric(vertical: 12),
//                     elevation: 0,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: Text(
//                     "Add to Savings",
//                     style: GoogleFonts.roboto(
//                       color: Colors.white,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     ),
//   );
//
//   }
//
//   void _manageSavingBudget(TransactionCubit categoryCubit, context) async {
//     int index = categoryCubit.fetchedCategories
//         .indexWhere((category) => category.name == "Saving");
//
//     categoryCubit.remainingBudget > 0
//         ? categoryCubit.mappedAllocatedCategoryAmount[index] =
//             categoryCubit.remainingBudget
//         : null;
//
//     TransactionEntity oldCategory=categoryCubit.fetchedCategories[index];
//     final updatedCategory = TransactionModel(
//       categoryId: oldCategory.categoryId,
//       name: oldCategory.name,
//       icon: oldCategory.icon,
//       color: oldCategory.color,
//       allocatedAmount: categoryCubit.mappedAllocatedCategoryAmount[index]!.toDouble(),
//       storedSpentAmount: oldCategory.storedSpentAmount,
//     );
//     categoryCubit.fetchedCategories[index] = updatedCategory;
//
//
//     await categoryCubit.initializeCategoriesStage(categoryCubit.fetchedCategories);
//
//     Navigator.push(
//         context, MaterialPageRoute(builder: (ctx) => const MainNavigator()));
//   }
// }