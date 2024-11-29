import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cubit/category_cubit.dart';
import '../cubit/category_states.dart';
import '../../../../../core/themes/app_color.dart';
import '../widgets/category_manager/add_category_dialog.dart';
import '../widgets/category_manager/category_manager_list_item.dart';

class CategoriesManagerScreen extends StatelessWidget {
  const CategoriesManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Category Manager",
          style: GoogleFonts.abhayaLibre(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocBuilder<CategoryCubit, CategoryStates>(
          builder: (context, state) {
            if (state is GetCategoryDataSuccessState) {
              final categories = state.items;

              return ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];

                  return Dismissible(
                    key: ValueKey(category.categoryId), // مفتاح فريد لكل عنصر
                    direction: DismissDirection.endToStart, // السحب لليسار فقط
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      margin: const EdgeInsets.only(bottom: 15), // نفس Margin العنصر
                      decoration: BoxDecoration(
                        color: Colors.red.shade400,
                        borderRadius: BorderRadius.circular(15), // نفس BorderRadius العنصر
                      ),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    onDismissed: (direction) {
                      BlocProvider.of<CategoryCubit>(context).deleteCategoryData(category.categoryId!);
                      print("Deleted Test Done");
                    },
                    child: CategoryManagerListItem(category: category),
                  );
                },
              );
            }
            // Check for other states
            else if (state is ChangeIconState ) {
              final categories = state.items;
              return ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return CategoryManagerListItem(category: category);
                },
              );
            }
            else if (state is ChangeColorState ) {
              final categories = state.items;
              return ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return CategoryManagerListItem(category: category);
                },
              );
            }
            else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddCategoryDialog(context),
        label: Text(
          "Add New Category",
          style: GoogleFonts.abel(
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
            color: AppColor.primaryColor,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }

  void _showAddCategoryDialog(BuildContext context) {
    final categoryCubit = BlocProvider.of<CategoryCubit>(context);
    showDialog(
      context: context,
      builder: (context) => BlocProvider.value(
        value: categoryCubit,
        child: AddCategoryDialog(),
      ),
    );
  }
}
