import 'package:budget_buddy/core/themes/app_color.dart';
import 'package:budget_buddy/features/category/presentation/cubit/category_cubit.dart';
import 'package:budget_buddy/features/user_info/presentation/cubit/setting_up_cubit.dart';
import 'package:budget_buddy/features/user_info/presentation/cubit/setting_up_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../widgets/new_category_modal_bottom_sheet.dart';
import '../widgets/category_slicing_card_list.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class CategorySlicingScreen extends StatelessWidget {
  final double remainingBudget = 1800;
  final double? monthlySalary;

  const CategorySlicingScreen({super.key, required this.monthlySalary});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider( create: (context) => CategoryCubit()..getBudgetCategories(),),
        BlocProvider( create: (context) => SettingCubit()),


      ],
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              BlocBuilder<SettingCubit,SettingStates>(
               builder: (context,state) {
                 SettingCubit settingCubit=SettingCubit.get(context);
                 settingCubit.monthlySalary=monthlySalary!;
                  return _buildHeaderSection(settingCubit);
                }
              ),
              Expanded(
                child: CategorySlicingCardList(),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const CustomSetUpBottomBar(),
      ),
    );
  }

  Widget _buildHeaderSection(SettingCubit settingCubit) {
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
                    "\$${settingCubit.monthlySalary.toStringAsFixed(2)}",
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
                child: Icon(
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
            child: Column(
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
                      "\$${remainingBudget.toStringAsFixed(2)}",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: remainingBudget > 0 ? AppColor.primaryColor : Colors.red,
                      ),
                    ),
                  ],
                ),
                const Gap(10),
                LinearProgressIndicator(
                  value: (settingCubit.monthlySalary - remainingBudget) / settingCubit.monthlySalary!,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    remainingBudget > 0 ? AppColor.primaryColor : Colors.red,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  minHeight: 8,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}

