// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gap/gap.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:budget_buddy/core/themes/app_color.dart';
//
// import '../../../transaction/data/models/transaction_model.dart';
// import '../../../transaction/domain/entities/transaction_entity.dart';
// import '../../../transaction/presentation/cubit/transaction_cubit.dart';
// import '../../../transaction/presentation/cubit/transaction_states.dart';
// import 'build_slicing_category_card.dart';
//
// class CategorySlicingCardList extends StatelessWidget {
//   CategorySlicingCardList({super.key, required this.monthlySalary});
//
//   final Map<int, TextEditingController> controllers = {};
//   final Map<int, int> _previousValues = {};
//   final int monthlySalary;
//
//   @override
//   Widget build(BuildContext context) {
//     final categoryCubit = TransactionCubit.get(context);
//     return BlocBuilder<TransactionCubit, TransactionStates>(
//       builder: (context, state) {
//         if (state is GetCategoryDataLoadingState) {
//           return const Center(
//             child: CircularProgressIndicator(
//               valueColor: AlwaysStoppedAnimation<Color>(AppColor.primaryColor),
//             ),
//           );
//         } else if (state is GetCategoryDataErrorState) {
//           return Center(
//             child: Text(
//               (state).errorMessage,
//               style: GoogleFonts.roboto(color: Colors.red),
//             ),
//           );
//         } else if (state is GetCategoryDataSuccessState ||
//             state is AddSettingUpCategoryState ||
//             state is UpdateRemainingSalaryState ||
//             state is ChangeAppearanceState ||
//             state is CategoryUpdatedState) {
//           final currentCategory = categoryCubit.fetchedCategories;
//           return ListView.builder(
//             padding: const EdgeInsets.all(16),
//             itemCount: currentCategory.length,
//             itemBuilder: (context, index) {
//               if (!controllers.containsKey(index)) {
//                 controllers[index] = TextEditingController();
//                 _previousValues[index] = 0;
//               }
//               return BuildSlicingCategoryCard(
//                 categoryEntity: currentCategory[index],
//                 controller: controllers[index]!,
//                 index: index,
//                 monthlySalary: monthlySalary,
//                 previousValue: _previousValues,
//                 onUpdateCategory: _updateCategory,
//               );
//             },
//           );
//         }
//         return const SizedBox();
//       },
//     );
//   }
//
//   void _updateCategory(TransactionCubit categoryCubit, TransactionEntity oldCategory,
//       int newAmount) {
//     final updatedCategory = TransactionModel(
//       categoryId: oldCategory.categoryId,
//       name: oldCategory.name,
//       icon: oldCategory.icon,
//       color: oldCategory.color,
//       allocatedAmount: newAmount.toDouble(),
//       storedSpentAmount: oldCategory.storedSpentAmount,
//     );
//
//     final index = categoryCubit.fetchedCategories.indexWhere(
//           (category) => category.categoryId == oldCategory.categoryId,
//     );
//
//     if (index != -1) {
//       categoryCubit.fetchedCategories[index] = updatedCategory;
//     }
//   }
// }