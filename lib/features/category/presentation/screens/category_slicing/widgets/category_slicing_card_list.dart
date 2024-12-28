import 'package:budget_buddy/core/constances.dart';
import 'package:budget_buddy/features/category/domain/entities/category_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../core/themes/app_color.dart';
import '../../../cubit/category_cubit.dart';
import '../../../cubit/category_states.dart';


class CategorySlicingCardList extends StatelessWidget {
  CategorySlicingCardList({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryCubit = CategoryCubit.get(context);
    final state = categoryCubit.state;



    return BlocBuilder<CategoryCubit,CategoryStates>(
      builder: (context,state) {
        if (state is GetCategoryDataLoadingState) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColor.primaryColor),
            ),
          );
        }
        else if (state is GetCategoryDataErrorState) {
          return Center(
            child: Text(
              (state as GetCategoryDataErrorState).errorMessage,
              style: GoogleFonts.roboto(color: Colors.red),
            ),
          );
        }
        else if (state is GetCategoryDataSuccessState||state is AddSettingUpCategoryState) {
          final categories = categoryCubit.fetchedCategories;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return _buildCategoryCard(categories[index]);
            },
          );
        }
        return const SizedBox(

        );
      }
    );
  }

  Widget _buildCategoryCard(CategoryEntity category) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppColor.backgroundColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: AppColor.lightGray,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColor.secondaryColor.withOpacity(0.1),
          child: Image.asset(
            category.icon!,
            width: 25,
            height: 25,
          ),
        ),
        title: Text(
          category.name!,
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w600,
            color: AppColor.textColor,
          ),
        ),
        trailing: SizedBox(
          width: 80,
          child: TextField(
            textAlign: TextAlign.end,
            decoration: InputDecoration(
              prefixText: '\$ ',
              prefixStyle: GoogleFonts.roboto(
                color: AppColor.accentColor,
                fontWeight: FontWeight.w600,
              ),
              hintText: '0.00',
              hintStyle: GoogleFonts.roboto(color: AppColor.textLightColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: AppColor.lightGray,
            ),
            keyboardType: TextInputType.number,
            style: GoogleFonts.roboto(
              color: AppColor.textColor,
              fontWeight: FontWeight.w600,
            ),
            onChanged: (value) {
              // هنا يمكنك التعامل مع التغيير
            },
          ),
        ),
      ),
    );
  }
}
