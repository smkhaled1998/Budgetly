import 'package:budget_buddy/core/themes/app_color.dart';
import 'package:budget_buddy/features/category/presentation/cubit/category_cubit.dart';
import 'package:budget_buddy/features/category/presentation/cubit/category_states.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../core/constances.dart';
import '../widgets/category_slicing_card_list.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class CategorySlicingScreen extends StatelessWidget {
  final double? monthlySalary;
  final String? currency;

  const CategorySlicingScreen({super.key, required this.monthlySalary, required this.currency});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeaderSection(context),
            Expanded(
              child: CategorySlicingCardList(monthlySalary: monthlySalary!,),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomSetUpBottomBar(categoriesList: [],),
    );
  }

  Widget _buildHeaderSection(context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColor.primaryColor,
            AppColor.primaryColor.withOpacity(0.8),
          ],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryColor.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Monthly Budget",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  const Gap(4),
                  Text(
                    "${currencies[currency]!['currencySymbol']}$monthlySalary",
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.account_balance_wallet,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ],
          ),
          const Gap(20),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                ),
              ],
            ),
            child: BlocBuilder<CategoryCubit,CategoryStates>(
              builder: (context,state) {
                CategoryCubit categoryCubit=CategoryCubit.get(context);

                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Remaining",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          "${currencies[currency]!['currencySymbol']}${categoryCubit.remainingBudget.toStringAsFixed(2)}",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: categoryCubit.remainingBudget > 0 ? AppColor.primaryColor : Colors.red,
                          ),
                        ),
                      ],
                    ),
                    const Gap(10),
                    LinearProgressIndicator(
                      value: (monthlySalary! - categoryCubit.remainingBudget) / monthlySalary!,
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        categoryCubit.remainingBudget > 0 ? AppColor.primaryColor : Colors.red,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      minHeight: 8,
                    ),
                  ],
                );
              }
            ),
          ),
        ],
      ),
    );
  }

}

