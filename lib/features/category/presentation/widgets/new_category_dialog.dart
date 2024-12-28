import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../cubit/category_cubit.dart';
import '../cubit/category_states.dart';
import '../../data/models/category_model.dart';
import '../../domain/entities/category_entity.dart';
import 'color_icon_picker_dialog.dart';

class CategoryCreationSheet {
  static void show(BuildContext context, {required bool isSetting}) {
    final categoryCubit = BlocProvider.of<CategoryCubit>(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BlocProvider.value(
        value: categoryCubit,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: CategoryCreationForm(isSetting: isSetting),
        ),
      ),
    );
  }
}

class CategoryCreationForm extends StatelessWidget {
  CategoryCreationForm({Key? key, required this.isSetting}) : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController budgetSliceController = TextEditingController();
  final bool isSetting;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with drag handle
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Create Category",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(24),
                  BlocBuilder<CategoryCubit, CategoryStates>(
                    builder: (context, state) {
                      CategoryCubit categoryCubit = BlocProvider.of<CategoryCubit>(context);
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildPickerButton(
                            context: context,
                            onTap: () => ColorPickerDialog.show(context, categoryCubit),
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: categoryCubit.categoryColor,
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.2),
                                  width: 2,
                                ),
                              ),
                            ),
                            label: "Color",
                          ),
                          _buildPickerButton(
                            context: context,
                            onTap: () => IconPickerDialog.show(context, categoryCubit),
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.2),
                                  width: 2,
                                ),
                              ),
                              child: Image.asset(
                                categoryCubit.categoryIcon ?? "assets/category.png",
                                width: 32,
                              ),
                            ),
                            label: "Icon",
                          ),
                        ],
                      );
                    },
                  ),
                  const Gap(24),
                  _buildTextField(
                    controller: nameController,
                    label: "Category Name",
                    hintText: "e.g., Groceries",
                  ),
                  const Gap(16),
                  _buildTextField(
                    controller: budgetSliceController,
                    label: "Budget Amount",
                    hintText: "Enter amount",
                    keyboardType: TextInputType.number,
                  ),
                  const Gap(32),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text("Cancel"),
                        ),
                      ),
                      const Gap(16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            final categoryCubit = CategoryCubit.get(context);
                            _createCategory(context, categoryCubit, isSetting);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text("Create"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPickerButton({
    required BuildContext context,
    required VoidCallback onTap,
    required Widget child,
    required String label,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey.withOpacity(0.1),
            ),
            padding: const EdgeInsets.all(16),
            child: child,
          ),
          const Gap(8),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        const Gap(8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[400]),
            filled: true,
            fillColor: Colors.grey.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }

  void _createCategory(
      BuildContext context,
      CategoryCubit categoryCubit,
      bool isSetting,
      ) {
    if (nameController.text.isEmpty || budgetSliceController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in all fields"),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    CategoryEntity newCategory = CategoryModel(
      name: nameController.text,
      allocatedAmount: double.parse(budgetSliceController.text),
      color: categoryCubit.categoryColor.toString(),
      icon: categoryCubit.categoryIcon,
    );

    isSetting
        ? categoryCubit.addAndGetCategoriesList(newCategory)
        : categoryCubit.insertNewCategory(newCategory);
    Navigator.pop(context);
  }
}