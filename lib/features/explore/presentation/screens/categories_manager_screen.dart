import 'package:budget_buddy/features/explore/data/datasources/category_local_datasource.dart';
import 'package:budget_buddy/features/explore/data/models/budget_model.dart';
import 'package:budget_buddy/features/explore/data/repositories/category_repository_imp.dart';
import 'package:budget_buddy/features/explore/domain/repositories/category_repository.dart';
import 'package:budget_buddy/features/explore/domain/usecases/insert_category_data_usecase.dart';
import 'package:budget_buddy/features/explore/presentation/screens/add_new_category.dart';
import 'package:budget_buddy/features/explore/presentation/screens/manage_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/themes/app_color.dart';
import '../cubit/explore_cubit.dart';
import '../cubit/explore_states.dart';

class CategoriesManager extends StatefulWidget {
  const CategoriesManager({super.key});

  @override
  _CategoriesManagerState createState() => _CategoriesManagerState();
}

class _CategoriesManagerState extends State<CategoriesManager> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _totalController = TextEditingController();
  final List<Map<String, String>> _categories = [
    {"name": "Naming", "total": "total=200"}
  ];




  void _saveCategory(int index) {
    if (_nameController.text.isNotEmpty && _totalController.text.isNotEmpty) {
      setState(() {
        _categories[index]['name'] = _nameController.text;
        _categories[index]['total'] = _totalController.text;

      });
    } else {
      // Show an error message or some validation feedback
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill out all fields')),
      );
    }
  }

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
                                    state.items[index].name,
                                    style: const TextStyle(
                                      color: AppColor.textBoldColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Budget Slice is \$${state.items[index].total} ",
                                    style: const TextStyle(
                                      color: AppColor.textLightColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(child: Container()),
                              IconButton(onPressed: () {

                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ManageCategoryScreen(item: state.items[index])));
                              }, icon: const Icon(Icons.edit_rounded))
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
          )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNewCategory()));
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
      )
    );
  }


}
