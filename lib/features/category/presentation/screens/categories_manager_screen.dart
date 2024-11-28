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
        // child: ListView.builder(
        //   itemCount:BlocProvider.of<CategoryCubit>(context).categories.length,
        //   itemBuilder: (context, index) {
        //     final category = BlocProvider.of<CategoryCubit>(context).categories[index];
        //     return CategoryManagerCardItem(category: category);
        //   },
        // )
       child: BlocBuilder<CategoryCubit, CategoryStates>(
         builder: (context, state) {
           // Check for GetCategoryDataSuccessState
           if (state is GetCategoryDataSuccessState) {
             final categories = state.items;
             return ListView.builder(
               itemCount: categories.length,
               itemBuilder: (context, index) {
                 final category = categories[index];
                 return CategoryManagerListItem(category: category);
               },
             );
           }
           // Check for ChangeIconState
           else if (state is ChangeIconState) {
             final categories = state.items;
             return ListView.builder(
               itemCount: categories.length,
               itemBuilder: (context, index) {
                 final category = categories[index];
                 return CategoryManagerListItem(category: category);
               },
             );
           }
           // Check for ChangeColorState
           else if (state is ChangeColorState) {
             final categories = state.items;
             return ListView.builder(
               itemCount: categories.length,
               itemBuilder: (context, index) {
                 final category = categories[index];
                 return CategoryManagerListItem(category: category);
               },
             );
           }
           // Fallback for other states or loading state
           else {
             return const Center(child: CircularProgressIndicator());
           }
         },
       )

        ,
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
