import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/themes/app_color.dart';
import '../cubit/explore_cubit.dart';
import '../cubit/explore_states.dart';
import 'add_new_category.dart';
import 'edit_category_detail_screen.dart';

class CategoriesManager extends StatelessWidget {
  const CategoriesManager({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Category Manager",
          style: GoogleFonts.abhayaLibre(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocBuilder<ExploreCubit, ExploreStates>(
          builder: (context, state) {
            if (state is GetCategoryDataSuccessState) {
              return ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 0,
                          spreadRadius: .8,
                          offset: Offset(0, 4),
                        ),
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
                                  state.items[index].name,
                                  style: const TextStyle(
                                    color: AppColor.textBoldColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Budget Slice is \$${state.items[index].categorySlice} ",
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
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditCategoryDetailScreen(item: state.items[index]),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.edit_rounded),
                            ),
                          ],
                        ),
                        const Gap(5),
                      ],
                    ),
                  );
                },
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNewCategory(),
            ),
          );
        },
        label: Text(
          "Add New Category",
          style: GoogleFonts.abel(
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
            color: AppColor.primaryColor,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }
}
