import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../../core/themes/app_color.dart';
import '../../cubit/category_cubit.dart';
import '../../cubit/category_states.dart';

class CategorySlicingCardList extends StatelessWidget {
  const CategorySlicingCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryStates>(
      builder: (context, state) {
        if (state is GetCategoryDataSuccessState) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                return Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.only(bottom: 10, top: 10),
                    decoration: const BoxDecoration(
                      color: AppColor.backgroundColor,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Row(children: [
                      Image.asset(
                        state.items[index].icon!,
                        width: 30,
                        height: 30,
                      ),
                      const Gap(15),
                      Text(
                        state.items[index].name!,
                        style: const TextStyle(
                          color: AppColor.textBoldColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(child: Container()),
                      SizedBox(
                        width: 80,
                        child: TextField(
                          decoration: InputDecoration(

                            prefixText: '\$',
                            prefixStyle: const TextStyle(
                              color: AppColor.textBoldColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            hintText: '00',
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          ),
                          keyboardType: TextInputType.number,
                          onSubmitted: (value) {
                            // Handle the slice value submission here
                          },
                        ),
                      ),

                    ]));
              },
            ),
          );
        } else if (state is GetCategoryDataErrorState) {
          return Center(child: Text(state.errorMessage));
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
// GestureDetector(
//   onTap: () {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Add Slice'),
//           content: TextField(
//             keyboardType: TextInputType.number,
//             onSubmitted: (value) {
//               // Handle the slice value submission here
//               Navigator.of(context).pop();
//             },
//             decoration: InputDecoration(
//               hintText: 'Enter slice value',
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 // Handle the slice value submission here
//                 Navigator.of(context).pop();
//               },
//               child: Text('Add'),
//             ),
//           ],
//         );
//       },
//     );
//   },
//   child: Container(
//     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//     decoration: BoxDecoration(
//       color: AppColor.primaryColor,
//       borderRadius: BorderRadius.circular(5),
//     ),
//     child: const Text(
//       'Add Slice',
//       style: TextStyle(
//         color: Colors.white,
//         fontSize: 14,
//       ),
//     ),
//   ),
// ),