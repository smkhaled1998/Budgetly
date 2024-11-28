import 'package:budget_buddy/features/category/presentation/cubit/category_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:gap/gap.dart';

import '../../../../../core/constances.dart';
import '../../cubit/category_cubit.dart';
import '../../../data/models/category_model.dart';
import '../../../domain/entities/category_entity.dart';
import 'color_icon_picker_dialog.dart';
class AddCategoryDialog extends StatelessWidget {
  AddCategoryDialog({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController budgetSliceController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: const Text("Add New Category"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder<CategoryCubit,CategoryStates>(
              builder: (context, state) {
                CategoryCubit categoryCubit = BlocProvider.of<CategoryCubit>(context);

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => ColorPickerDialog.show(context, categoryCubit),
                      child: Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: categoryCubit.categoryColor,
                            ),
                          ),
                          const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => IconPickerDialog.show(context, categoryCubit),
                      child: Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(categoryCubit.categoryIcon),
                          ),
                          const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ],
                );
              }
            ),
            const Gap(15),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: "Name",
              ),
            ),
            const Gap(10),
            TextField(
              controller: budgetSliceController,
              decoration: const InputDecoration(
                hintText: "Budget Slice",
              ),
            ),
            const Gap(10),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            final categoryCubit = BlocProvider.of<CategoryCubit>(context);
            _createCategory(context, categoryCubit);
          },
          child: const Text("Confirm"),
        ),
      ],
    );
  }

  void _pickColor(BuildContext context, CategoryCubit categoryCubit) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Pick a color!"),
          content: SingleChildScrollView(
            child: MaterialPicker(
              pickerColor: categoryCubit.categoryColor,
              onColorChanged: (color) {
                categoryCubit.changeCategoryColor(color);
                print(color);
                Navigator.of(context).pop();

              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void _pickIcon(BuildContext context, CategoryCubit categoryCubit) {

    showDialog(
      context: context,
      builder: (context) {
        return BlocProvider.value( // Use BlocProvider.value here
          value: categoryCubit,
          child: BlocBuilder<CategoryCubit, CategoryStates>(
            builder: (context, state) {
              return AlertDialog(
                title: const Text("Pick an Icon!"),
                content: SingleChildScrollView(
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: List.generate(
                      iconImages.length,
                          (index) => GestureDetector(
                        onTap: () {
                          BlocProvider.of<CategoryCubit>(context).changeCategoryIcon(index);
                        },
                        child: Container(
                          height: 60,
                          width: 60,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: categoryCubit.categoryIcon == iconImages[index]
                                  ? Colors.blue // Highlight if selected
                                  : Colors.transparent, // No border if not selected
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.asset(iconImages[index]),
                        ),
                      ),
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      CategoryCubit.get(context).changeCategoryIcon(0);
                      Navigator.pop(context); // Close the dialog without saving
                    },
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () {
                      // categoryCubit.changeCategoryIcon(iconImages.indexOf(tempIcon)); // Save the selected icon
                      Navigator.pop(context); // Close the dialog
                    },
                    child: const Text("Confirm"),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  void _createCategory(BuildContext context, CategoryCubit categoryCubit) {

    CategoryEntity newCategory = CategoryModel(
      name: nameController.text,
      allocatedAmount: double.parse(budgetSliceController.text),
      color: categoryCubit.categoryColor.toString(),
      icon: categoryCubit.categoryIcon,
    );

    categoryCubit.insertNewCategory(newCategory);
    Navigator.pop(context);
  }
}
