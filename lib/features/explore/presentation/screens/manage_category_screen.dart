import 'package:budget_buddy/features/explore/domain/entities/category_entity.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/themes/app_color.dart';

class ManageCategoryScreen extends StatelessWidget {
  ManageCategoryScreen({Key? key, required this.item}) : super(key: key);
  CategoryEntity item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Manage Category Detail",
          style: GoogleFonts.abhayaLibre(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: 95,
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
              const Gap(5),
              Row(
                children: [
                  Image.asset(
                    "assets/housing.png",
                    width: 30,
                    height: 30,
                  ),
                  const Gap(15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(
                          color: AppColor.textBoldColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Budget Slice is \$${item.total} ",
                        style: const TextStyle(
                          color: AppColor.textLightColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: Container()),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.edit_rounded))
                ],
              ),
              const Gap(5),
            ],
          ),
        ),
      ),
      // floatingActionButton: _isAdding
      //     ? null
      //     : FloatingActionButton.extended(
      //         onPressed: _addCategory,
      //         label: Text(
      //           "Add New Category",
      //           style: GoogleFonts.abel(
      //             fontWeight: FontWeight.bold,
      //             fontSize: 15.0,
      //             color: AppColor.primaryColor,
      //             letterSpacing: 1.5,
      //           ),
      //         ),
      //       ),
    );
  }
}
