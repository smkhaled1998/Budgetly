import 'package:budget_buddy/features/explore/presentation/cubit/explore_cubit.dart';
import 'package:budget_buddy/features/explore/presentation/cubit/explore_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/themes/app_color.dart';
import '../widgets/calculator_widget.dart';

class AddExpenseScreen extends StatelessWidget {
  const AddExpenseScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Icon(Icons.search),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
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
          Gap(5),
          Expanded(
            child: BlocBuilder<ExploreCubit, ExploreStates>(
              builder: (context, state) {
                if (state is GetCategoryDataSuccessState) {
                  return ListView.separated(
                    itemCount: state.items.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(top: 1.0, left: 15, right: 15),
                      child: Row(
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
                              Text(state.items[index].name),
                              Text("\$${state.items[index].spent} left"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    separatorBuilder: (context, index) => Divider(),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
              onPressed: () => _showCalculator(context),
              child: const Text("Show Calculator"),
            ),
          ),
        ],
      ),
    );
  }
  void _showCalculator(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: CalculatorWidget(),
        );
      },
    );
  }

}
