import 'package:budget_buddy/core/themes/app_color.dart';
import 'package:budget_buddy/features/category_managment/presentation/cubit/category_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/Widgets/pickers/picker_dialog_helpers.dart';
import '../../../../core/data/models/category_model.dart';
import '../widgets/slicing_screen/build_header_section.dart';
import '../widgets/slicing_screen/category_slicing_card_list.dart';
import '../widgets/slicing_screen/custom_bottom_nav_bar.dart';


class CategorySlicingScreen extends StatelessWidget {
  final int monthlySalary;
  final String currency;

  const CategorySlicingScreen({super.key, required this.monthlySalary, required this.currency});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoryCubit>(
      create: (BuildContext context)=>CategoryCubit()..fetchCategories()..remainingBudget=monthlySalary,
      child: Scaffold(

        backgroundColor: AppColor.backgroundColor,
        body: SafeArea(
          child: Column(
            children: [
               BuildHeaderSection(
                monthlySalary: monthlySalary,
                currency: currency,
              ),
              Expanded(
                child: CategorySlicingCardList(monthlySalary: monthlySalary),
              ),
            ],
          ),
        ),
        bottomNavigationBar:  CustomSetUpBottomBar(categoriesList: [], categoryCubit: context.read<CategoryCubit>(),),
      ),

    );
  }


}

