// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import '../../../../../core/themes/app_color.dart';
// import '../../../transaction/domain/entities/transaction_entity.dart';
//
// class CategoryItemExpenseWidget extends StatelessWidget {
//   final TransactionEntity categoryEntity;
//   final VoidCallback onTap;
//
//   const CategoryItemExpenseWidget({
//     required this.categoryEntity,
//     required this.onTap,
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         color: AppColor.backgroundColor,
//         padding: const EdgeInsets.all(10),
//         child: Row(
//           children: [
//              Image.asset(categoryEntity.icon!,width: 40,height: 40,),
//             const Gap(15),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(categoryEntity.name!, style: const TextStyle(fontSize: 16)),
//                 Text(
//                   "Left To Spend: \$${categoryEntity.allocatedAmount!-categoryEntity.storedSpentAmount}",
//                   style: const TextStyle(fontSize: 12),
//                 ),
//                 // LinearProgressIndicator(
//                 //   borderRadius: BorderRadius.circular(15),
//                 //   backgroundColor: Colors.grey,
//                 //   valueColor:
//                 //   //state.items[index].color!
//                 //   AlwaysStoppedAnimation(parseColorFromString(categoryEntity.color!)),
//                 //   minHeight: 10,
//                 //   value:categoryEntity.allocatedAmount==0?0: categoryEntity.spentAmount / categoryEntity.allocatedAmount!, // Dynamically calculated
//                 // ),
//
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
