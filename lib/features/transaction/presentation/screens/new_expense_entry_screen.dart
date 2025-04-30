import 'dart:ui';
import 'package:budget_buddy/core/domain/entities/category_entity.dart';
import 'package:budget_buddy/features/category_managment/presentation/screens/explore_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/Widgets/pickers/picker_dialog_helpers.dart';
import '../../../../core/constances.dart';
import '../../../../core/themes/app_color.dart';
import '../../../expense_entry/presentation/cubit/expense_entry_states.dart';
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
    final percentSpent = categoryEntity.storedSpentAmount / categoryEntity.allocatedAmount!;
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
               leading: IconButton(onPressed: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>ExploreScreen()));
               }, icon: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,)),
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
                _buildHeader(context, percentSpent, cubit.showPieChart, categoryColor, remainingAmount),
                _buildSubcategoriesHeader(context, isEditMode),
                _buildSubcategoriesList(context, isEditMode, categoryColor),
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

  Widget _buildHeader(BuildContext context, double percentSpent, bool showPieChart, Color categoryColor, double remainingAmount) {
    final double progressValue = percentSpent.clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Top row: Icon and Category name
          Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(
                      value: progressValue,
                      strokeWidth: 5,
                      backgroundColor: Colors.grey.withOpacity(0.15),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        progressValue >= 1 ? Colors.red : categoryColor,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: categoryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      IconData(
                        int.parse(categoryEntity.icon!),
                        fontFamily: 'MaterialIcons',
                      ),
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          categoryEntity.name!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: remainingAmount < 0
                                ? Colors.red.withOpacity(0.15)
                                : categoryColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child:  Text(
                            "\$${remainingAmount.toStringAsFixed(0)} ${remainingAmount < 0 ? 'over' : 'left'}",
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.9),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () => TransactionCubit.get(context).togglePieChart(),
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.pie_chart,
                              color: categoryColor,
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        InkWell(
                          onTap: () {
                            // Edit category action
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.edit,
                              color: Colors.grey[600],
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Optional pie chart
          if (showPieChart)
            Container(
              height: 180,
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                child: Text(
                  "Pie Chart Here",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSubcategoriesHeader(BuildContext context, bool isEditMode) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      width: double.infinity,
      color: Colors.grey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "SUBCATEGORIES",
            style: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColor.textWhite,
            ),
          ),
          IconButton(
            icon: Icon(
              isEditMode ? Icons.close : Icons.settings,
              color: Colors.blueGrey[700],
              size: 20,
            ),
            onPressed: () {
              // Toggle edit mode
              final cubit = TransactionCubit.get(context);
              if (isEditMode) {
                cubit.emit(TransactionInitialState());
              } else {
                cubit.emit(TransactionEditModeState());
              }
            },
            tooltip: isEditMode ? "Exit Settings" : "Settings",
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
///****************
  Widget _buildSubcategoriesList(BuildContext context, bool isEditMode, Color categoryColor) {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: isEditMode ? _buildEditModeList(context, categoryColor) : _buildViewModeList(context, categoryColor),
      ),
    );
  }

  Widget _buildViewModeList(BuildContext context, Color categoryColor) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: subCategories.length,
      separatorBuilder: (context, index) => Divider(
        color: Colors.grey[200],
        height: 1,
        indent: 16,
        endIndent: 16,
      ),
      itemBuilder: (context, index) {
        final subCat = subCategories[index];
        return _buildSubcategoryItem(context, subCat, false, index, categoryColor);
      },
    );
  }

  Widget _buildEditModeList(BuildContext context, Color categoryColor) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: subCategories.length,
      separatorBuilder: (context, index) => Divider(
        color: Colors.grey[200],
        height: 1,
        indent: 16,
        endIndent: 16,
      ),
      itemBuilder: (context, index) {
        final subCat = subCategories[index];
        return _buildSubcategoryItem(context, subCat, true, index, categoryColor);
      },
    );
  }

  Widget _buildSubcategoryItem(BuildContext context, Subcategory subCat, bool isEditMode, int index, Color categoryColor) {
    return InkWell(
      onTap: () {
        if (isEditMode) {
          _showEditSubcategoryDialog(TransactionCubit.get(context), subCat, index, context, categoryColor);
        } else {
          // Navigate to subcategory details or add transaction
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // Subcategory Icon with Background
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: subCat.color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(subCat.icon, color: subCat.color, size: 24),
            ),
            const SizedBox(width: 16),
            // Subcategory Name
            Expanded(
              child: Text(
                subCat.name,
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            // Edit Icon (Only in Edit Mode)
            if (isEditMode)
              Tooltip(
                message: "Edit",
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Icon(Icons.edit_outlined, color: Colors.blueGrey, size: 18),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
  ///****************
  // Refactored methods for NewExpenseEntryScreen class

// Replace the existing methods in your NewExpenseEntryScreen class with these:

  void _showEditSubcategoryDialog(TransactionCubit cubit, Subcategory subCat, int index, context, Color categoryColor) async {
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

  void _showAddSubcategoryDialog(TransactionCubit cubit, context, Color categoryColor) async {
    // final result = await PickerDialogHelpers.showSubcategoryPickerDialog(
    //   context: context,
    //   title: "Add New Subcategory",
    //   initialName: "",
    //   initialColor: categoryColor,
    //   initialIcon: Icons.category,
    //   accentColor: categoryColor,
    //   parentCategory: null,
    //   pickerFunction: (CategoryEntity ) {  },
    // );

    // if (result != null) {
    //   // Here you would add the subcategory to your data model
    //   // cubit.addSubcategory(result['name'], result['color'], result['icon']);
    // }
  }


}

class Subcategory {
  final String name;
  final IconData icon;
  final Color color;

  Subcategory({
    required this.name,
    required this.icon,
    required this.color,
  });
}