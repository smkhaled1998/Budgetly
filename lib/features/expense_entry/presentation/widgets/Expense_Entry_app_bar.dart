// import 'package:flutter/material.dart';
//
// import '../../../../core/themes/app_color.dart';
// import '../../../transaction/presentation/cubit/transaction_cubit.dart';
// import '../cubit/expense_entery_cubit.dart';
//
// class ExpenseEntryAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const ExpenseEntryAppBar({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
//       actions: [
//         IconButton(
//           onPressed: () {
//            final result= TransactionCubit.get(context).fetchedCategories;
//
//             print("spent Amount of ${result[0].name}=${result[0].storedSpentAmount}" );
//             print("Search icon pressed");
//           },
//           icon: const Icon(Icons.search),
//         ),
//       ],
//     );
//   }
//
//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }
