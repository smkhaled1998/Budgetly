import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/themes/app_color.dart';
import '../../../../domain/entities/category_entity.dart';
import '../../../cubit/category_cubit.dart';
import '../../category_manager/screens/categories_manager_screen.dart';


class CategoryEditActionRow extends StatelessWidget {
  const CategoryEditActionRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: (){
            CategoryCubit categoryCubit=CategoryCubit.get(context);
            for(CategoryEntity categoryEntity in categoryCubit.fetchedCategories)
            {
              print("name before is ${categoryEntity.name}");
            }
          },
          child: Text(
            "Budgets",
            style: GoogleFonts.abel(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: AppColor.accentColor,
              letterSpacing: 1.5,
            ),
          ),
        ),
        MaterialButton(
          onPressed: () {
            final exploreCubit = BlocProvider.of<CategoryCubit>(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider.value(
                  value: exploreCubit,
                  child: const CategoriesManagerScreen(),
                ),
              ),
            );
          },
          color: AppColor.accentColor,
          child: Text(
            "Edit Category",
            style: GoogleFonts.abel(
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
              color: Colors.white,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
