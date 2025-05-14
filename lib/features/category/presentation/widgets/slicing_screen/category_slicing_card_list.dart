import 'package:budget_buddy/core/data/models/category_model.dart';
import 'package:budget_buddy/core/domain/entities/category_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:budget_buddy/core/themes/app_color.dart';

import '../../cubit/category_cubit.dart';
import '../../cubit/category_states.dart';
import 'build_slicing_category_card.dart';

class CategorySlicingCardList extends StatelessWidget {
  CategorySlicingCardList({super.key, required this.monthlySalary});

  final Map<int, TextEditingController> controllers = {};
  final Map<int, int> _previousValues = {};
  final int monthlySalary;

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline,
                    size: 48,
                    color: Colors.red.shade300
                ),
                const SizedBox(height: 16),
                Text(
                  (state).errorMessage,
                  style: GoogleFonts.roboto(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        } else if (state is GetCategoryDataSuccessState ||
            state is AddSettingUpCategoryState ||
            state is UpdateRemainingSalaryState ||
            state is ChangeCategoryAppearanceState ||
            state is CategoryUpdatedState) {

          final currentCategory = categoryCubit.fetchedCategories;

          if (currentCategory.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.category_outlined,
                      size: 64,
                      color: AppColor.primaryColor.withOpacity(0.5)
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "No categories found.\nAdd categories using the + button below.",
                    style: GoogleFonts.poppins(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            itemCount: currentCategory.length,
            itemBuilder: (context, index) {
              if (!controllers.containsKey(index)) {
                controllers[index] = TextEditingController();
                _previousValues[index] = 0;
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: BuildSlicingCategoryCard(
                  categoryEntity: currentCategory[index],
                  controller: controllers[index]!,
                  index: index,
                  monthlySalary: monthlySalary,
                  previousValue: _previousValues,
                  onUpdateCategory: _updateCategory,
                ),
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }

  void _updateCategory(CategoryCubit categoryCubit, CategoryEntity oldCategory,
      int newAmount) {
    final updatedCategory = CategoryModel(
      categoryId: oldCategory.categoryId,
      name: oldCategory.name,
      icon: oldCategory.icon,
      color: oldCategory.color,
      allocatedAmount: newAmount.toDouble(),
      storedSpentAmount: oldCategory.storedSpentAmount,
    );

    final index = categoryCubit.fetchedCategories.indexWhere(
          (category) => category.categoryId == oldCategory.categoryId,
    );

    if (index != -1) {
      categoryCubit.fetchedCategories[index] = updatedCategory;
    }
  }
}