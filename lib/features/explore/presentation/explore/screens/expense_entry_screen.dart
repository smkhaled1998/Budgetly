import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/themes/app_color.dart';
import '../cubit/explore_cubit.dart';
import '../cubit/explore_states.dart';
import '../widgets/calculator_widget.dart';

class ExpenseEntryScreen extends StatelessWidget {
  ExpenseEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              ExploreCubit.get(context).addExpenseToCategory();
              print("ExpenseUpdated is Done");
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            color: Colors.grey,
            child: Text(
              "All Categories",
              style: GoogleFonts.abel(
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
                color: AppColor.accentColor,
                letterSpacing: 1.5,
              ),
            ),
          ),
          const Gap(5),
          Expanded(
            child: BlocBuilder<ExploreCubit, ExploreStates>(
              builder: (context, state) {

                if (state is GetCategoryDataSuccessState) {
                  return ListView.separated(
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      ExploreCubit cubit = ExploreCubit.get(context);
                      return InkWell(
                        onTap: () {
                          cubit.defineSelectedCategory(state.items[index].name);
                          cubit.spent = _parseDouble(state.items[index].spent);
                          cubit.leftToSpend = _parseDouble(state.items[index].leftToSpend);
                          cubit.categorySlice = state.items[index].categorySlice;
                          _showCalculator(context);
                          print(state.items[index].name);
                        },
                        child: Container(
                          color: cubit.selectedExpenseCategoryName ==
                                  state.items[index].name
                              ? AppColor.lightGray
                              : AppColor.backgroundColor,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Image.asset(
                                  state.items[index].icon!,
                                  width: 30,
                                  height: 30,
                                ),
                                const Gap(15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(state.items[index].name),
                                    Text(
                                      "\$${_parseDouble(state.items[index].categorySlice) - _parseDouble(state.items[index].spent)} left to spend",
                                      style: const TextStyle(
                                        color: AppColor.textLightColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                  );
                } else {
                  return Center(child: Container());
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCalculator(context),
        backgroundColor: AppColor.lightGray,
        tooltip: 'Show Calculator',
        child: const Icon(Icons.calculate),
      ),
      bottomNavigationBar: _bottomNavBar(),
    );
  }

  double _parseDouble(String value) {
    try {
      return double.parse(value);
    } catch (e) {
      print("Can't parsed it: error>> $e");
      return 0.0;
    }
  }

  void _showCalculator(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        ExploreCubit cubit = ExploreCubit.get(context);
        return BlocBuilder<ExploreCubit, ExploreStates>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: CalculatorWidget(
                onValueSelected: (value) {
                  cubit.defineCalculatedValue(value);
                  print("Calculated value is $value");
                  Navigator.pop(context);
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _bottomNavBar() {
    return Container(
      height: 75,
      decoration: BoxDecoration(
        color: AppColor.primaryColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, -3), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: BlocBuilder<ExploreCubit, ExploreStates>(
        builder: (context, state) {
          ExploreCubit cubit = ExploreCubit.get(context);
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Category',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    cubit.selectedExpenseCategoryName,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Value',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '\$ ${cubit.expenseAmount}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
