import 'package:budget_buddy/core/constances.dart';
import 'package:budget_buddy/features/category/data/models/category_model.dart';
import 'package:budget_buddy/features/category/domain/entities/category_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../core/themes/app_color.dart';
import '../../../cubit/category_cubit.dart';
import '../../../cubit/category_states.dart';
import '../../../widgets/color_icon_picker_dialog.dart';

class CategorySlicingCardList extends StatelessWidget {
  CategorySlicingCardList({super.key});

  final Map<int, TextEditingController> _controllers = {};
  final Map<int, double> _previousValues = {};

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
              if (!_controllers.containsKey(index)) {
                _controllers[index] = TextEditingController();
                _previousValues[index] = 0.0;
              }
              return _buildCategoryCard(categories[index], _controllers[index]!, index, context);
            },
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildCategoryCard(
      CategoryEntity categoryEntity, TextEditingController controller, int index, BuildContext context) {
    CategoryCubit categoryCubit = CategoryCubit.get(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppColor.backgroundColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: AppColor.lightGray,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColor.secondaryColor.withOpacity(0.1),
          child: Image.asset(
            categoryEntity.icon!,
            width: 25,
            height: 25,
          ),
        ),
        title: Text(
          categoryEntity.name!,
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w600,
            color: AppColor.textColor,
          ),
        ),
        trailing: SizedBox(
          width: 80,
          child: TextField(
            controller: controller,
            textAlign: TextAlign.end,
            decoration: InputDecoration(
              prefixText: '\$ ',
              prefixStyle: GoogleFonts.roboto(
                color: AppColor.accentColor,
                fontWeight: FontWeight.w600,
              ),
              hintText: '0.00',
              hintStyle: GoogleFonts.roboto(color: AppColor.textLightColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: AppColor.lightGray,
            ),
            keyboardType: TextInputType.number,
            style: GoogleFonts.roboto(
              color: AppColor.textColor,
              fontWeight: FontWeight.w600,
            ),
            onChanged: (value) {
              if (value.isEmpty) {
                double difference = _previousValues[index] ?? 0.0;
                categoryCubit.addToRemainingSalary(difference);
                _previousValues[index] = 0.0;

                _updateCategory(categoryCubit, categoryEntity, 0.0);
                return;
              }

              try {
                double newValue = double.parse(value);
                double oldValue = _previousValues[index] ?? 0.0;
                double difference = oldValue - newValue;

                if (categoryCubit.remainingSalary + difference < 0) {
                  _validateRemainingSalary(context, "Try again",categoryCubit.remainingSalary);
                }

                categoryCubit.addToRemainingSalary(difference);

                _previousValues[index] = newValue;

                _updateCategory(categoryCubit, categoryEntity, newValue);
              } catch (e) {
                print('Invalid number format');
              }
            },
          ),
        ),
      ),
    );
  }

  void _validateRemainingSalary(BuildContext context, String message, double remaining) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          message,
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.bold,
            color: message == "You Do not have enough money" ? Colors.red : Colors.green,
          ),
        ),
        content: Text(
          message == "You Do not have enough money"
              ? "Your remaining salary is \$${remaining.toStringAsFixed(2)}."
              : "Good",
          style: GoogleFonts.roboto(
            color: AppColor.textColor,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Logic for setting the remaining amount
              Navigator.of(context).pop();
            },
            child: Text("Set \$${remaining.toStringAsFixed(2)}"),
          ),
          TextButton(
            onPressed: () {
              // Logic for updating other categories
              Navigator.of(context).pop();
            },
            child: const Text("Update other Categories"),
          ),
        ],
      ),
    );
  }

  void _updateCategory(CategoryCubit categoryCubit, CategoryEntity oldCategory, double newAmount) {
    final updatedCategory = CategoryModel(
      categoryId: oldCategory.categoryId,
      name: oldCategory.name,
      icon: oldCategory.icon,
      color: oldCategory.color,
      allocatedAmount: newAmount,
      spentAmount: oldCategory.spentAmount,
    );

    final index = categoryCubit.fetchedCategories.indexWhere(
            (category) => category.categoryId == oldCategory.categoryId);

    if (index != -1) {
      categoryCubit.fetchedCategories[index] = updatedCategory;
    }
  }
}
