import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/themes/app_color.dart';

class CategoryBudgetCardWidget extends StatelessWidget {
  const CategoryBudgetCardWidget({super.key, required this.budgetDataItem});

  final Map<String, dynamic> budgetDataItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      // margin: const EdgeInsets.only(bottom: 10),
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
                    "\$${budgetDataItem["left_to_spend"]} left to spend",
                    style: const TextStyle(
                      color: AppColor.textLightColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Expanded(child: Container()),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end, // Adjusted to end alignment
                children: [
                  Text(
                    "\$${budgetDataItem["spent_amount"]} spent",
                    style: const TextStyle(
                      color: AppColor.textBoldColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "of \$${budgetDataItem["total_amount"]} total",
                    style: const TextStyle(
                      color: AppColor.textLightColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Gap(5),
          LinearProgressIndicator(
            borderRadius: BorderRadius.circular(15),
            backgroundColor: AppColor.lightGray,
            valueColor: const AlwaysStoppedAnimation(AppColor.accentColor),
            minHeight: 10,
            value: budgetDataItem["spent_amount"] / budgetDataItem["total_amount"], // Dynamically calculated
          ),
        ],
      ),
    );
  }
}
 