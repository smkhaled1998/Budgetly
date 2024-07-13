import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../core/themes/app_color.dart';
import '../cubit/explore_cubit.dart';
import '../cubit/explore_states.dart';

class CategoryCardWidget extends StatelessWidget {
  const CategoryCardWidget({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreCubit, ExploreStates>(
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
                    Row(
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
                            Text(
                              state.items[index].name,
                              style: const TextStyle(
                                color: AppColor.textBoldColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "\$${double.parse(state.items[index].categorySlice) -
                                  double.parse(state
                                      .items[index].spent)} left to spend",
                              style: const TextStyle(
                                color: AppColor.textLightColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Expanded(child: Container()),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          // Adjusted to end alignment
                          children: [
                            Text(
                              "\$${state.items[index].spent} spent",
                              style: const TextStyle(
                                color: AppColor.textBoldColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "of \$${state.items[index].categorySlice} total",
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
                    const Gap(5),
                    LinearProgressIndicator(
                      borderRadius: BorderRadius.circular(15),
                      backgroundColor: Colors.grey,
                      valueColor:
                  //state.items[index].color!
                       AlwaysStoppedAnimation(AppColor.accentColor),
                      minHeight: 10,
                      value: double.parse(state.items[index].spent) /
                          double.parse(state
                              .items[index].categorySlice), // Dynamically calculated
                    ),
                  ],
                ),
              );
            },
          );
        } else if (state is GetCategoryDataErrorState){
          return Center(child: Text(state.errorMessage),);
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
