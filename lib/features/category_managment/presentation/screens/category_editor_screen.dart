
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../../core/themes/app_color.dart';

import '../../../../core/data/models/category_model.dart';
import '../../../../core/domain/entities/category_management_entity.dart';
import '../../../../core/Widgets/color_icon_picker_dialog.dart';
import '../cubit/category_management_cubit.dart';
import '../cubit/category_management_states.dart';
import '../widgets/editable_category_card.dart';

class CategoryEditorScreen extends StatelessWidget {
  CategoryEditorScreen({Key? key, required this.item}) : super(key: key);
  final CategoryManagementEntity item;

  TextEditingController nameController = TextEditingController();
  TextEditingController budgetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CategoryManagementCubit categoryManagementCubit = BlocProvider.of<CategoryManagementCubit>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 4,
        backgroundColor: AppColor.primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          "Edit Category",
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),

      ),
      body: SingleChildScrollView(
        child: BlocBuilder<CategoryManagementCubit, CategoryManagementStates>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(15),
                EditableCategoryCard(
                  item: item,
                  budgetController: budgetController,
                  isEditing: categoryManagementCubit.isEditModeActive,
                  nameController: nameController,
                  categoryCubit: categoryManagementCubit,
                  selectedColor: categoryManagementCubit.categoryColor.toString(),
                  selectedIcon: categoryManagementCubit.categoryIcon ?? item.icon!,
                  onEditToggle: () {
                    categoryManagementCubit.toggleEditMode();
                    categoryManagementCubit.updatedCategoryName = nameController.text==""?item.name:nameController.text;
                    categoryManagementCubit.updatedAllocatedAmount =
                        double.tryParse(budgetController.text) ?? item.allocatedAmount;
                    categoryManagementCubit.saveUpdatedCategory(nameController.text, item, budgetController.text);

                  },

                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildActionButton(
                        icon: Icons.color_lens,
                        label: "Change Color",
                        onPressed: () {
                          return ColorPickerDialog.show(context, categoryManagementCubit,item);
                        },
                      ),
                      const SizedBox(width: 16),
                      _buildActionButton(
                        icon: Icons.image,
                        label: "Change Icon",
                        onPressed: () {
                          return IconPickerDialog.show(context, categoryManagementCubit,item);
                        },
                      ),
                    ],
                  ),
                ),
                const Gap(15),
                if (!categoryManagementCubit.isEditModeActive) ...[
                  const Divider(height: 5),
                  _buildCategoryVisibilityWidget(),
                ],
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: Text(
                    "SUBCATEGORIES",
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColor.textColor,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return TextButton.icon(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: Colors.grey[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      icon: Icon(icon, size: 20, color: AppColor.primaryColor),
      label: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 14,
          color: AppColor.primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildCategoryVisibilityWidget() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Show Category",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Switch.adaptive(
              value: true,
              activeColor: AppColor.primaryColor,
              onChanged: (value) {},
            ),
          ],
        ),
      ),
    );
  }

  void saveUpdatedCategory(CategoryManagementCubit categoryCubit) {
    categoryCubit.isEditModeActive = false;

    final updatedName = nameController.text.isEmpty ? item.name : nameController.text;
    final updatedAmount = budgetController.text.isEmpty
        ? item.allocatedAmount
        : double.tryParse(budgetController.text) ?? item.allocatedAmount;

    CategoryManagementEntity updatedItem = CategoryManagementModel(
      name: updatedName,
      allocatedAmount: updatedAmount,
      color: categoryCubit.categoryColor.toString(),
      icon: categoryCubit.categoryIcon,
    );

    categoryCubit.updateCategoryData(updatedItem, item.categoryId!);
  }
}