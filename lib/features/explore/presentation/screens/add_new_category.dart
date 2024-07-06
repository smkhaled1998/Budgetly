import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/themes/app_color.dart';

class AddNewCategory extends StatefulWidget {
  const AddNewCategory({Key? key}) : super(key: key);

  @override
  State<AddNewCategory> createState() => _AddNewCategoryState();
}

class _AddNewCategoryState extends State<AddNewCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add New Category",
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
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'name',
                        style: TextStyle(
                          color: AppColor.textBoldColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Budget Slice is  ",
                        style: TextStyle(
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

// CategoryModel item = CategoryModel(
//             total: _totalController.text, name: _nameController.text);
//         InsertCategoryDataUseCase(
//                 categoryRepository: CategoryRepositoryImpl(
//                     localDataSource: CategoryLocalDataSource()))
//             .call(item);