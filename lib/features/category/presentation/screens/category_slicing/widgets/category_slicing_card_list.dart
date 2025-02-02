import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:budget_buddy/features/category/data/models/category_model.dart';
import 'package:budget_buddy/features/category/domain/entities/category_entity.dart';
import 'package:budget_buddy/core/themes/app_color.dart';

import '../../../cubit/category_cubit.dart';
import '../../../cubit/category_states.dart';
import 'build_slicing_category_card.dart';

class CategorySlicingCardList extends StatelessWidget {
  CategorySlicingCardList({super.key, required this.monthlySalary});

  final Map<int, TextEditingController> controllers = {};
  final Map<int, double> _previousValues = {};
  final double monthlySalary;

  @override
  Widget build(BuildContext context) {
    final categoryCubit = CategoryCubit.get(context);
    return BlocBuilder<CategoryCubit, CategoryStates>(
      builder: (context, state) {
        if (state is GetCategoryDataLoadingState) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColor.primaryColor),
            ),
          );
        } else if (state is GetCategoryDataErrorState) {
          return Center(
            child: Text(
              (state).errorMessage,
              style: GoogleFonts.roboto(color: Colors.red),
            ),
          );
        } else if (state is GetCategoryDataSuccessState ||
            state is AddSettingUpCategoryState ||
            state is UpdateRemainingSalaryState ||
            state is ChangeIconState ||
            state is CategoryUpdatedState) {
          final categories = categoryCubit.fetchedCategories;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              // categoryCubit.currentCategoryIndex=index;
              if (!controllers.containsKey(index)) {
                controllers[index] = TextEditingController();
                _previousValues[index] = 0.0;
              }
              return BuildSlicingCategoryCard(
                categoryEntity: categories[index],
                controller: controllers[index]!,
                index: index,
                monthlySalary: monthlySalary,
                previousValues: _previousValues,
                onUpdateCategory: _updateCategory,
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }

  void _updateCategory(CategoryCubit categoryCubit, CategoryEntity oldCategory,
      double newAmount) {
    final updatedCategory = CategoryModel(
      categoryId: oldCategory.categoryId,
      name: oldCategory.name,
      icon: oldCategory.icon,
      color: oldCategory.color,
      allocatedAmount: newAmount,
      spentAmount: oldCategory.spentAmount,
    );

    final index = categoryCubit.fetchedCategories.indexWhere(
          (category) => category.categoryId == oldCategory.categoryId,
    );

    if (index != -1) {
      categoryCubit.fetchedCategories[index] = updatedCategory;
    }
  }
}