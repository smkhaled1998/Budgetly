import 'package:budget_buddy/core/util/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../cubit/category_cubit.dart';
import '../widgets/category_card_explore_screen.dart';
import '../widgets/category_edit_action_row.dart';
import '../widgets/header_widget.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoryCubit>(
      create: (context)=>CategoryCubit()..fetchBudgetCategories(),
      child:  const Scaffold(
        backgroundColor: Color(0xFFF5F7F8),
        body: Column(
          // padding: EdgeInsets.zero,
          children:   [
            HeaderWidget(),
            Expanded(
              child: SingleChildScrollView(
              
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal:20),
                  child: Column(
                    children: [
                      CategoryEditActionRow(),
                    Gap(15),
                      BudgetCategoriesListExploreScreen(),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
