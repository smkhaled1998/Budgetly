import 'package:budget_buddy/features/explore/presentation/screens/edit_category_card.dart';
import 'package:flutter/material.dart';

import '../../../../core/themes/app_color.dart';

class EditCategoryRow extends StatelessWidget {
  const EditCategoryRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Budgets",style: TextStyle(fontWeight: FontWeight.bold)),
        MaterialButton(
          onPressed: () {
            print("EditCategoryRow is pressed");
            Navigator.push(context, MaterialPageRoute(builder: (context)=>EditCategoryCard()));
          },
          color: AppColor.accentColor,
          child: const Text("Edit Category",style: TextStyle(color: Colors.white),),
        )
      ],
    );
  }
}
