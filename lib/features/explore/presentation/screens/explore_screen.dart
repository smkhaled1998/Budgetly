import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/themes/app_color.dart';
import '../widgets/category_budget_card_widget.dart';
import '../widgets/edit_category_row.dart';
import '../widgets/header_widget.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({Key? key}) : super(key: key);

  List<Map<String, dynamic>> budgetData = [
    {
      "name": "Housing",
      "spent_amount": 20,
      "total_amount": 200,
      "left_to_spend": 180,
      "icon": "assets/housing.png"
    },
    // Add more data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children:  [
          const HeaderWidget(),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [const EditCategoryRow(),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: budgetData.length,
                  itemBuilder: (context, index) {
                    return CategoryBudgetCardWidget(budgetDataItem: budgetData[index]);
                  },
                ),],
            ),
          )



        ],
      ),
    );
  }
}
