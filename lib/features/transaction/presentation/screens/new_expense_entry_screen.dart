import 'dart:ui';
import 'package:budget_buddy/core/domain/entities/category_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/Widgets/pickers/picker_dialog_helpers.dart';
import '../../../../core/constances.dart';
import '../../../../core/domain/entities/sub_category-entity.dart';
import '../../../../core/themes/app_color.dart';
import '../../../category/presentation/screens/explore_screen.dart';
import '../../../category/presentation/widgets/selected_category_header.dart';
import '../../../subcategory/presentation/cubit/subcategory_cubit.dart';
import '../../../subcategory/presentation/cubit/subcategory_states.dart';
import '../../../subcategory/presentation/widgets/subcategories_widget.dart';
import '../cubit/transaction_cubit.dart';
import '../cubit/transaction_states.dart';

class NewExpenseEntryScreen extends StatelessWidget {
  final CategoryEntity categoryEntity;

  const NewExpenseEntryScreen({
    super.key,
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
              onPressed: () => _showAddSubcategoryDialog(context),
              backgroundColor: categoryColor,
              child: const Icon(Icons.add),
            ) : null,
          );
        },
      ),
    );
  }

  // FIXED: Fixed the edit dialog function to prevent emitting after cubit closed
  void _showEditSubcategoryDialog(
      TransactionCubit cubit, SubcategoryEntity subCat, int index, BuildContext context, Color categoryColor) async {
    // إنشاء نسخة جديدة من SubcategoryCubit
    final subcategoryCubit = SubcategoryCubit();

    // تهيئة قيم Cubit بناءً على البيانات الحالية للفئة الفرعية
    subcategoryCubit.updateSubcategoryColor(parseColorFromString(subCat.subcategoryColor ?? '#1E88E5'));
    subcategoryCubit.updateSubcategoryIcon(subCat.subcategoryIcon ?? Icons.category.codePoint.toString());

    try {
      final result = await PickerDialogHelpers.showSubcategoryPickerDialog(
        context: context,
        title: "Edit Subcategory",
        parentCategory: categoryEntity.categoryId!,
        subcategoryCubit: subcategoryCubit,
        pickerFunction: (updatedSubcategory) {
          // Instead of calling the method directly, trigger an event that will be handled
          // after the dialog is dismissed and we check that the cubit is still active
          Navigator.pop(context, {
            'action': 'update',
            'subcategory': updatedSubcategory,
            'id': subCat.parentCategoryId,
          });
        },
      );

      // Handle the result after the dialog closes and before the cubit is disposed
      if (result != null && result['action'] == 'update') {
        await subcategoryCubit.updateSubcategoryData(
            result['subcategory'],
            result['id']
        );
      }
    } finally {
      // التأكد من التخلص من الـ cubit بعد الانتهاء
      subcategoryCubit.close();
    }
  }

  // FIXED: Fixed the add dialog function to prevent emitting after cubit closed
  void _showAddSubcategoryDialog(BuildContext context) async {
    final subcategoryCubit = SubcategoryCubit();

    try {
      final result = await PickerDialogHelpers.showSubcategoryPickerDialog(
        context: context,
        title: "Add New Subcategory",
        parentCategory: categoryEntity.categoryId!,
        subcategoryCubit: subcategoryCubit,
        pickerFunction: (subCategory) {
          // Instead of directly inserting, return the data to be processed after dialog closes
          Navigator.pop(context, {
            'action': 'insert',
            'subcategory': subCategory
          });
        },
      );

      // Process the result after dialog closes and before cubit disposal
      if (result != null && result['action'] == 'insert') {
        await subcategoryCubit.insertNewSubcategory(result['subcategory']);
      }
    } finally {
      // التأكد من التخلص من الـ cubit بعد الانتهاء
      subcategoryCubit.close();
    }
  }
}