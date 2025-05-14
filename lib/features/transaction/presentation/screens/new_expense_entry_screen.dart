import 'dart:ui';
import 'package:budget_buddy/core/domain/entities/category_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/Widgets/pickers/picker_dialog_helpers.dart';
import '../../../../core/constances.dart';
import '../../../../core/themes/app_color.dart';
import '../../../category/presentation/screens/explore_screen.dart';
import '../../../category/presentation/widgets/selected_category_header.dart';
import '../../../subcategory/presentation/widgets/subcategories_widget.dart';
import '../cubit/transaction_cubit.dart';
import '../cubit/transaction_states.dart';


class NewExpenseEntryScreen extends StatelessWidget {
  final CategoryEntity categoryEntity;
  final List<Subcategory> subCategories;

  const NewExpenseEntryScreen({
    super.key,
    required this.subCategories,
    required this.categoryEntity,
  });

  @override
  Widget build(BuildContext context) {
    final Color categoryColor = parseColorFromString(categoryEntity.color ?? '#1E88E5');
    final double remainingAmount = categoryEntity.allocatedAmount! - categoryEntity.storedSpentAmount;

    return BlocProvider(
      create: (context) => TransactionCubit(),
      child: BlocBuilder<TransactionCubit, TransactionStates>(
        builder: (context, state) {
          final cubit = TransactionCubit.get(context);
          final bool isEditMode = state is TransactionEditModeState;

          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ExploreScreen()));
                  },
                  icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white)
              ),
              title: Text(
                categoryEntity.name!,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              elevation: 0,
              backgroundColor: AppColor.primaryColor,
              foregroundColor: Colors.black,
            ),
            backgroundColor: Colors.white,
            body: Column(
              children: [
                // Category Header Widget
                SelectedCategoryHeaderWidget(
                  categoryEntity: categoryEntity,
                  categoryColor: categoryColor,
                  remainingAmount: remainingAmount,
                  showPieChart: cubit.showPieChart,
                  onTogglePieChart: () => cubit.togglePieChart(),
                  onEditCategory: () {
                    // Edit category action
                  },
                ),

                // Subcategories Widget
                Expanded(
                  child: SubcategoriesWidget(
                    subcategories: subCategories,
                    isEditMode: isEditMode,
                    categoryColor: categoryColor,
                    onToggleEditMode: () {
                      if (isEditMode) {
                        cubit.emit(TransactionInitialState());
                      } else {
                        cubit.emit(TransactionEditModeState());
                      }
                    },
                    onEditSubcategory: (subCat, index) {
                      _showEditSubcategoryDialog(cubit, subCat, index, context, categoryColor);
                    },
                    onSubcategoryTap: (subCat) {
                      // Navigate to subcategory details or add transaction
                    },
                  ),
                ),
              ],
            ),
            floatingActionButton: isEditMode ? FloatingActionButton(
              onPressed: () => _showAddSubcategoryDialog(cubit, context, categoryColor),
              backgroundColor: categoryColor,
              child: const Icon(Icons.add),
            ) : null,
          );
        },
      ),
    );
  }

  void _showEditSubcategoryDialog(TransactionCubit cubit, Subcategory subCat, int index, BuildContext context, Color categoryColor) async {
    // final result = await PickerDialogHelpers.showEditPickerDialog(
    //   pickerFunction: (){},
    //   context: context,
    //   title: "Edit Subcategory",
    //   initialName: subCat.name,
    //   initialColor: subCat.color,
    //   initialIcon: subCat.icon,
    //   accentColor: categoryColor,
    // );
    //
    // if (result != null) {
    //   // Here you would update the subcategory in your data model
    //   // cubit.updateSubcategory(index, result['name'], result['color'], result['icon']);
    // }
  }

  void _showAddSubcategoryDialog(TransactionCubit cubit, BuildContext context, Color categoryColor) async {
    final result = await PickerDialogHelpers.showSubcategoryPickerDialog(
      context: context,
      title: "Add New Subcategory",
      parentCategory: categoryEntity,
      pickerFunction: (){},
    );

    if (result != null) {
      // Here you would add the subcategory to your data model
      // cubit.addSubcategory(result['name'], result['color'], result['icon']);
    }
  }
}