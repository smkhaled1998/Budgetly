import 'package:flutter/material.dart';

import '../widgets/category_budget_card_widget.dart';
import '../widgets/edit_category_budget_card_widget.dart';

class EditCategoryCard extends StatelessWidget {
   EditCategoryCard({Key? key}) : super(key: key);
  List<Map<String, dynamic>> budgetData = [
    {
      "name": "Housing",
      "spent_amount": 20,
      "total_amount": 200,
      "left_to_spend": 180,
      "icon": "assets/housing.png"
    },
    {
      "name": "Housing",
      "spent_amount": 20,
      "total_amount": 200,
      "left_to_spend": 180,
      "icon": "assets/housing.png"
    },
    {
      "name": "Housing",
      "spent_amount": 20,
      "total_amount": 200,
      "left_to_spend": 180,
      "icon": "assets/housing.png"
    },
    {
      "name": "Housing",
      "spent_amount": 20,
      "total_amount": 200,
      "left_to_spend": 180,
      "icon": "assets/housing.png"
    },
    {
      "name": "Housing",
      "spent_amount": 20,
      "total_amount": 200,
      "left_to_spend": 180,
      "icon": "assets/housing.png"
    },
    {
      "name": "Housing",
      "spent_amount": 20,
      "total_amount": 200,
      "left_to_spend": 180,
      "icon": "assets/housing.png"
    },
    {
      "name": "Housing",
      "spent_amount": 20,
      "total_amount": 200,
      "left_to_spend": 180,
      "icon": "assets/housing.png"
    },

    {
      "name": "Housing",
      "spent_amount": 20,
      "total_amount": 200,
      "left_to_spend": 180,
      "icon": "assets/housing.png"
    },

    {
      "name": "Housing",
      "spent_amount": 20,
      "total_amount": 200,
      "left_to_spend": 180,
      "icon": "assets/housing.png"
    },

    {
      "name": "Housing",
      "spent_amount": 20,
      "total_amount": 200,
      "left_to_spend": 180,
      "icon": "assets/housing.png"
    },

    {
      "name": "Housing",
      "spent_amount": 20,
      "total_amount": 200,
      "left_to_spend": 180,
      "icon": "assets/housing.png"
    },
    {
      "name": "Housing",
      "spent_amount": 20,
      "total_amount": 200,
      "left_to_spend": 180,
      "icon": "assets/housing.png"
    },

    {
      "name": "Housing",
      "spent_amount": 20,
      "total_amount": 200,
      "left_to_spend": 180,
      "icon": "assets/housing.png"
    },

    {
      "name": "Housing",
      "spent_amount": 20,
      "total_amount": 200,
      "left_to_spend": 180,
      "icon": "assets/housing.png"
    },

    


  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Category Card"),),
      body:Padding(
        padding: const EdgeInsets.all(20),

        child: ListView.builder(
          // shrinkWrap: true,
          // physics: const NeverScrollableScrollPhysics(),
          itemCount: budgetData.length,
          itemBuilder: (context, index) {
            return EditCategoryBudgetCardWidget(budgetDataItem: budgetData[index]);
          },
        ),
      ),
      floatingActionButton:FloatingActionButton.extended(

        onPressed: () {

        },
        label: const Text("Add New Category"),
        tooltip: 'Add New Category',
      ) ,
    );
  }
}
