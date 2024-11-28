
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/themes/app_color.dart';
import '../cubit/category_cubit.dart';
import '../widgets/category_slicing/bottom_nav_bar.dart';
import '../widgets/category_slicing/category_slicing_card_list.dart';

class CategorySlicing extends StatefulWidget {
  const CategorySlicing({super.key});

  @override
  _CategorySlicingState createState() => _CategorySlicingState();
}

class _CategorySlicingState extends State<CategorySlicing> {
  double monthlySalary = 3000.0;


  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoryCubit>(
      create: (context)=>CategoryCubit()..getBudgetCategories(),
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 200 ,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  )),
              child: SafeArea(
                child: Column(
                    children: [
      
                  Text(
                            "One more step",
                            style: GoogleFonts.abel(
                              textStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColor.backgroundColor,
                              ),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const Gap(15),
                      Text(
                        "Slice Your Budget into category",
                        style: GoogleFonts.abel(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColor.backgroundColor,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Gap(15),
                          Text(
                            "Monthly Salary:$monthlySalary",
                            style: GoogleFonts.abel(
                                textStyle: const TextStyle(
                                    fontSize: 20, color: AppColor.backgroundColor)),
                            textAlign: TextAlign.center,
      
                          ),
      
                ],),
              ),
            ),
            const Expanded(
              child: CategorySlicingCardList()
            ),

          ],
        ),
        bottomNavigationBar: const BottomNavBar(),
      ),
    );
  }
}

