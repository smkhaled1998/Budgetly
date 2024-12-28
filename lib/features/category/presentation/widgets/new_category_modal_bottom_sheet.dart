// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
//
// import 'color_icon_picker_dialog.dart';
//
// class AddNewCategoryBottomSheet extends StatelessWidget {
//   const AddNewCategoryBottomSheet({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           const Text("Add New Category"),
//           const Gap(15),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             GestureDetector(
//               onTap: () => ColorPickerDialog.show(context, categoryCubit),
//               child: Row(
//                 children: [
//                   Container(
//                     height: 50,
//                     width: 50,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: categoryCubit.categoryColor,
//                     ),
//                   ),
//                   const Icon(Icons.arrow_drop_down),
//                 ],
//               ),
//             ),
//             GestureDetector(
//               onTap: () => IconPickerDialog.show(context, categoryCubit),
//               child: Row(
//                 children: [
//                   Container(
//                     height: 50,
//                     width: 50,
//                     decoration: const BoxDecoration(
//                       shape: BoxShape.circle,
//                     ),
//                     child: Image.asset(categoryCubit.categoryIcon ??
//                         "assets/category.png"),
//                   ),
//                   const Icon(Icons.arrow_drop_down),
//                 ],
//               ),
//             ),
//           ],
//         ),
//
//           const Gap(20),
//           const Gap(15),
//           TextField(
//             controller: nameController,
//             decoration: const InputDecoration(
//               hintText: "Name",
//             ),
//           ),
//           const Row()
//         ],
//       ),
//     );
//   }
// }
