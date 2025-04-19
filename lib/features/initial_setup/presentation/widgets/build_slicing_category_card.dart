// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../../../../../../core/themes/app_color.dart';
//
// import '../../../transaction/domain/entities/transaction_entity.dart';
// import '../../../transaction/presentation/cubit/transaction_cubit.dart';
// import 'insufficient_balance_dialog.dart';
//
// class BuildSlicingCategoryCard extends StatelessWidget {
//   final TransactionEntity categoryEntity;
//   final TextEditingController controller;
//   final int index;
//   final int monthlySalary;
//   final Map<int, int> previousValue;
//   final Function(TransactionCubit, TransactionEntity, int) onUpdateCategory;
//
//   const BuildSlicingCategoryCard({
//     super.key,
//     required this.categoryEntity,
//     required this.controller,
//     required this.index,
//     required this.monthlySalary,
//     required this.previousValue,
//     required this.onUpdateCategory,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     TransactionCubit categoryCubit = TransactionCubit.get(context);
//
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 5),
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       decoration: BoxDecoration(
//         color: AppColor.backgroundColor,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: const [
//           BoxShadow(
//             color: AppColor.lightGray,
//             blurRadius: 10,
//             offset: Offset(0, 5),
//           ),
//         ],
//       ),
//       child: ListTile(
//         leading: CircleAvatar(
//           backgroundColor: AppColor.secondaryColor.withOpacity(0.1),
//           child: Image.asset(
//             categoryEntity.icon!,
//             width: 25,
//             height: 25,
//           ),
//         ),
//         title: Text(
//           categoryEntity.name!,
//           style: GoogleFonts.roboto(
//             fontWeight: FontWeight.w600,
//             color: AppColor.textColor,
//           ),
//         ),
//         trailing: SizedBox(
//           width: 100,
//           child:TextField(
//             controller: controller,
//             onTap: () {
//               // Select all text when the field is tapped
//               controller.selection = TextSelection(
//                 baseOffset: 0,
//                 extentOffset: controller.text.length,
//               );
//             },
//             textAlign: TextAlign.end,
//             decoration: InputDecoration(
//               prefixIcon: Padding(
//                 padding: const EdgeInsets.only(left: 15, right: 4),
//                 child: Text(
//                   '﷼',
//                   style: GoogleFonts.roboto(
//                     color: AppColor.accentColor,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//               prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
//               hintText: '0.00',
//               hintStyle: GoogleFonts.roboto(color: AppColor.textLightColor),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: BorderSide.none,
//               ),
//               filled: true,
//               fillColor: AppColor.lightGray,
//               contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
//             ),
//             keyboardType: TextInputType.number,
//             style: GoogleFonts.roboto(
//               color: AppColor.textColor,
//               fontWeight: FontWeight.w600,
//             ),
//             onChanged: (value) {
//               _handleValueChange(value, categoryCubit, context);
//             },
//           )
//
//         ),
//       ),
//     );
//   }
//
//   void _handleValueChange(
//     String value,
//     TransactionCubit categoryCubit,
//     BuildContext context,
//   ) {
//     if (value.isEmpty) {
//         int difference = previousValue[index] ?? 0;
//         categoryCubit.updateRemainingBudgetForProgressBarInSettingUpstage(difference);
//         previousValue[index] = 0;
//         categoryCubit.mappedAllocatedCategoryAmount[index] = 0;
//         onUpdateCategory(categoryCubit, categoryEntity, 0);
//       return;
//     }
//
//     try {
//       int newAllocation = int.parse(value);
//       int previousAllocation =-(categoryCubit.mappedAllocatedCategoryAmount[index]??0);
//       int difference = previousAllocation - newAllocation;
//         categoryCubit.updateCategoryAllocationAndTotalBudgetInSettingUpstage(index, difference);
//
//       if (categoryCubit.remainingBudget + difference < 0) {
//         categoryCubit.updateRemainingBudgetForProgressBarInSettingUpstage(difference);
//         _showBudgetAlertDialog(context,categoryCubit);
//       } else {
//         categoryCubit.updateRemainingBudgetForProgressBarInSettingUpstage(difference);
//         previousValue[index]=newAllocation;
//         onUpdateCategory(categoryCubit, categoryEntity, newAllocation);
//       }
//     } catch (e) {
//       print('Invalid number format in field $index');
//       print(' ${e.toString()}');
//     }
//   }
//
//   void _showBudgetAlertDialog(
//       BuildContext context, TransactionCubit categoryCubit) {
//     showGeneralDialog(
//       context: context,
//       barrierDismissible: true,
//       barrierLabel: '',
//       barrierColor: Colors.black54,
//       transitionDuration: const Duration(milliseconds: 300),
//       pageBuilder: (context, animation1, animation2) {
//         return Container();
//       },
//       transitionBuilder: (context, animation, secondaryAnimation, child) {
//         return ScaleTransition(
//           scale: Tween<double>(begin: 0.5, end: 1.0).animate(
//             CurvedAnimation(
//               parent: animation,
//               curve: Curves.easeOutCubic,
//             ),
//           ),
//           child: FadeTransition(
//             opacity: animation,
//             child: BlocProvider.value(
//               value: categoryCubit,
//               child: InsufficientBalanceDialog(
//                 index: index,
//                 categoryCubit: categoryCubit,
//                 monthlySalary: monthlySalary ,
//                 totalAllocatedBudgetBasedOnMap:
//                     categoryCubit.totalAllocatedBudgetBasedOnMap,
//                 controller: controller,
//                 onValueChange: _handleValueChange,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
