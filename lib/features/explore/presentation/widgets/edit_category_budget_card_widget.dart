import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/themes/app_color.dart';

class EditCategoryBudgetCardWidget extends StatelessWidget {
  const EditCategoryBudgetCardWidget({super.key, required this.budgetDataItem});
  final Map<String, dynamic> budgetDataItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 15),

      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black12,
              blurRadius: 0,
              spreadRadius: .8,
              offset: Offset(0, 4))
        ],
        color: AppColor.backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                budgetDataItem["icon"],
                width: 30,
                height: 30,
              ),
              const Gap(15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    budgetDataItem["name"],
                    style: const TextStyle(
                      color: AppColor.textBoldColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Budget = \$${budgetDataItem["total_amount"]}",
                    style: const TextStyle(
                      color: AppColor.textLightColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Expanded(child: Container()),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end, // Adjusted to end alignment
                children: [
                    IconButton(onPressed: (){}, icon: const Icon(Icons.delete),color: Colors.red,),
                  IconButton(onPressed: (){}, icon: const Icon(Icons.edit),color: Colors.blueAccent,),


                ],
              ),
            ],
          ),

        ],
      ),
    );
  }
}
