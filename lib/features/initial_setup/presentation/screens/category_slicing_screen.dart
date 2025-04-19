// import 'package:budget_buddy/core/themes/app_color.dart';
//
// import 'package:flutter/material.dart';
//
// import '../widgets/build_header_section.dart';
// import '../widgets/category_slicing_card_list.dart';
// import '../widgets/custom_bottom_nav_bar.dart';
//
// class CategorySlicingScreen extends StatelessWidget {
//   final int? monthlySalary;
//   final String? currency;
//
//   const CategorySlicingScreen({super.key, required this.monthlySalary, required this.currency});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.backgroundColor,
//       body: SafeArea(
//         child: Column(
//           children: [
//             BuildHeaderSection(
//               monthlySalary: monthlySalary!,
//               currency: currency!,
//             ),
//             Expanded(
//               child: CategorySlicingCardList(monthlySalary: monthlySalary!,),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: const CustomSetUpBottomBar(categoriesList: [],),
//     );
//   }
//
//
// }
//
