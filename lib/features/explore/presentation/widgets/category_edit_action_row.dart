import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/themes/app_color.dart';

class CategoryEditActionRow extends StatelessWidget {
  const CategoryEditActionRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Budgets",
          style: GoogleFonts.abel(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            color: AppColor.accentColor,
            letterSpacing: 1.5,
          ),
        ),
        MaterialButton(
          onPressed: () {
            print("BudgetCategoryManager is pressed");

          },
          color: AppColor.accentColor,
          child:  Text("Edit Category", style:GoogleFonts.abel( fontWeight: FontWeight.bold,
            fontSize: 15.0,
            color: Colors.white,
            letterSpacing: 1.5,)),
        )
      ],
    );
  }
}
