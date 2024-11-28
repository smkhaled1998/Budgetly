import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../../../../core/constances.dart';
import '../../cubit/category_cubit.dart';
import '../../cubit/category_states.dart';

class ColorPickerDialog {
  static void show(BuildContext context, CategoryCubit categoryCubit) {
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
}

class IconPickerDialog {
  static void show(BuildContext context, CategoryCubit categoryCubit) {
    showDialog(
      context: context,
      builder: (context) {
        return BlocProvider.value(
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
                                  ? Colors.blue
                                  : Colors.transparent,
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
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
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
}