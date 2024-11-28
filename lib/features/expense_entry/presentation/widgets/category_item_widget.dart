import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../../core/themes/app_color.dart';
import '../../../category/domain/entities/category_entity.dart';

class CategoryItemWidget extends StatelessWidget {
  final CategoryEntity category;
  final VoidCallback onTap;

  const CategoryItemWidget({
    required this.category,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: AppColor.backgroundColor,
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
             Image.asset(category.icon!,width: 40,height: 40,),
            const Gap(15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(category.name!, style: const TextStyle(fontSize: 16)),
                Text(
                  "Left To Spend: \$${category.allocatedAmount!-category.spentAmount}",
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
