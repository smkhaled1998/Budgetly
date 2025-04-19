// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../../core/themes/app_color.dart';
// import '../../../category_managment/presentation/screens/categories_manager_screen.dart';
// import '../cubit/transaction_cubit.dart';
//
// class CategoryManageActionRow extends StatelessWidget {
//   const CategoryManageActionRow({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           "Budgets",
//           style: GoogleFonts.abel(
//             fontWeight: FontWeight.bold,
//             fontSize: 20.0,
//             color: AppColor.accentColor,
//             letterSpacing: 1.5,
//           ),
//         ),
//         MaterialButton(
//           onPressed: () {
//             final exploreCubit = BlocProvider.of<TransactionCubit>(context);
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => BlocProvider.value(
//                   value: exploreCubit,
//                   child: const CategoriesManagerScreen(),
//                 ),
//               ),
//             );
//           },
//           color: AppColor.accentColor,
//           child: Text(
//             "Manage Category",
//             style: GoogleFonts.abel(
//               fontWeight: FontWeight.bold,
//               fontSize: 15.0,
//               color: Colors.white,
//               letterSpacing: 1.5,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
