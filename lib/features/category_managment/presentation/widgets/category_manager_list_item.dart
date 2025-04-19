import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../../../core/themes/app_color.dart';
import '../../../../core/domain/entities/category_management_entity.dart';
import '../cubit/category_management_cubit.dart';

class CategoryManagerListItem extends StatelessWidget {
  final CategoryManagementEntity category;
  const CategoryManagerListItem({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 15),
      decoration:  BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 0,
            spreadRadius: .8,
            offset: Offset(0, 4),
          ),
        ],
        color: AppColor.backgroundGlass,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        children: [
          const Gap(5),
          Row(
            children: [
              Image.asset(
                category.icon!,
                width: 30,
                height: 30,
              ),
              const Gap(15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.name!,
                    style: const TextStyle(
                      color: AppColor.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Budget Slice is \$${category.allocatedAmount} ",
                    style:  TextStyle(
                      color: AppColor.textColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Expanded(child: Container()),
              IconButton(
                onPressed: () {
                  final categoryCubit = BlocProvider.of<CategoryManagementCubit>(context);

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) {
                  //         categoryCubit.categoryIcon=category.icon!;
                  //         categoryCubit.updatedCategoryName=category.name!;
                  //         categoryCubit.updatedAllocatedAmount=category.allocatedAmount!;
                  //         categoryCubit.categoryColor=parseColorFromString(category.color!);
                  //         return BlocProvider.value(
                  //           value: categoryCubit,
                  //           child: CategoryEditorScreen(
                  //               item: category),
                  //         );
                  //       }
                  // ));
                },
                icon: const Icon(Icons.edit_rounded),
              ),
            ],
          ),
          const Gap(5),
        ],
      ),
    );
  }
}
