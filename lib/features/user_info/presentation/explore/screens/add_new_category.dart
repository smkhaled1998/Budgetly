
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:budget_buddy/core/themes/app_color.dart';

import '../cubit/explore_cubit.dart';
import '../cubit/explore_states.dart';

class AddNewCategory extends StatelessWidget {
  AddNewCategory({Key? key}) : super(key: key);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _budgetSliceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ExploreCubit cubit = ExploreCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: Text(
          "Add New Category",
          style: GoogleFonts.abhayaLibre(),
        ),
        actions: [
          IconButton(
            onPressed: () {
              cubit.insertCategoryData(cubit.newCategory!);
              print("Insert Data To DataBase Button is pressed");
            },
            icon: const Icon(Icons.done),
          ),
          const Gap(5),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: cubit.categoryBackgroundColor,
                  ),
                  child: Center(
                    child: Image.asset(
                      cubit.categoryIcon,
                      width: 30,
                      height: 30,
                    ),
                  ),
                ),
                Gap(15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                  Text("Name",style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColor.textBoldColor,
                  ),),
                  Text("Budget Slice",style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColor.textBoldColor,
                  ),)
                ],),
                Expanded(child: Container()),
                IconButton(
                  onPressed: () {
                    _showDialog(context, cubit);
                  },
                  icon: const Icon(Icons.edit),
                ),
              ],
            ),
            const Divider(),
            // _buildTextRow("Name", "Food & Drink", context),
            // const Divider(),
            _buildSwitchRow("Show", true),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              width: double.infinity,
              color: Colors.grey[300],
              child: Text(
                "SUBCATEGORIES",
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColor.textBoldColor,
                ),
              ),
            ),
            // TODO: Add the ListView for subcategories here
          ],
        ),
      ),
    );
  }

  Widget _buildTextRow(String label, String value, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColor.textBoldColor,
            ),
          ),
          Expanded(
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: value,
                hintStyle: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColor.textLightColor,
                ),
                border: InputBorder.none,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchRow(String label, bool value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColor.textBoldColor,
            ),
          ),
          Switch(
            value: value,
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }

  void _showDialog(BuildContext context, ExploreCubit cubit) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Define Properties"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocBuilder<ExploreCubit, ExploreStates>(
                    builder: (context, state) {
                      return GestureDetector(
                        onTap: () {
                          _pickColor(context, cubit);
                        },
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: cubit.categoryBackgroundColor,
                              ),
                            ),
                            const Icon(Icons.arrow_drop_down)
                          ],
                        ),
                      );
                    },
                  ),
                  BlocBuilder<ExploreCubit, ExploreStates>(
                    builder: (context, state) {
                      return GestureDetector(
                        onTap: () {
                          _pickIcon(context, cubit);
                        },
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(cubit.categoryIcon),
                            ),
                            const Icon(Icons.arrow_drop_down)
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: "Name",
                ),
              ),
              TextFormField(
                controller: _budgetSliceController,
                decoration: const InputDecoration(
                  hintText: "Budget Slice",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                cubit.categoryName = _nameController.text;
                cubit.categorySlice = _budgetSliceController.text;
                cubit.spent = 0;
                cubit.leftToSpend = 0;
                cubit.addNewCategory();
                print("Changing prop is done");
                Navigator.pop(context);
              },
              child: const Text("Confirm"),
            ),
          ],
        );
      },
    );
  }

  void _pickColor(BuildContext context, ExploreCubit cubit) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Pick a color"),
          content: BlockPicker(
            pickerColor: cubit.categoryBackgroundColor,
            onColorChanged: (color) {
              cubit.changeCategoryColor(color);
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Confirm"),
            ),
          ],
        );
      },
    );
  }

  void _pickIcon(BuildContext context, ExploreCubit cubit) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Pick an Icon"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.maxFinite,
                  height: 150,
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: cubit.iconImages.length,
                    itemBuilder: (context, index) {
                      return BlocBuilder<ExploreCubit, ExploreStates>(
                        builder: (context, state) {
                          return GestureDetector(
                            onTap: () {
                              cubit.changeCategoryIcon(index);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: cubit.categoryIcon == cubit.iconImages[index]
                                    ? Border.all(
                                  color: Colors.grey,
                                  width: 3,
                                )
                                    : null,
                                shape: BoxShape.rectangle,
                              ),
                              child: SizedBox(
                                height: 50,
                                width: 50,
                                child: Image.asset(cubit.iconImages[index]),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Confirm"),
            ),
          ],
        );
      },
    );
  }
}
