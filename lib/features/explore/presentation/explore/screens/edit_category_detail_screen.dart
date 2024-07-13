import 'package:budget_buddy/features/explore/domain/entities/category_entity.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/themes/app_color.dart';


class EditCategoryDetailScreen extends StatelessWidget {
  EditCategoryDetailScreen({Key? key, required this.item}) : super(key: key);
  final CategoryEntity item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: Text(
          "Manage Category Detail",
          style: GoogleFonts.abhayaLibre(),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 160,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Gap(50),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: Center(
                      child: Image.asset(
                        "assets/housing.png",
                        width: 45,
                        height: 45,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit),
                  ),
                ],
              ),
            ),
          ), // icon & color
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name",
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColor.textBoldColor,
                      ),
                    ),
                    Text(
                      "Food & Drink",
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColor.textLightColor,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                ),
              ],
            ),
          ), // Naming
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Budget Slice",
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColor.textBoldColor,
                      ),
                    ),
                    Text(
                      "200",
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColor.textLightColor,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                ),
              ],
            ),
          ), // Naming
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Show",
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColor.textBoldColor,
                  ),
                ),
                Switch(
                  value: true,
                  onChanged: (value) {},
                ),
              ],
            ),
          ), // Show
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            width: double.infinity,
            color: Colors.grey[300],
            child: Text(
              "SUBCATEGORIES",
              style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColor.textBoldColor,
              ),
            ),
          ), // "SUBCATEGORIES"
          // LISTVIEW
        ],
      ),
    );
  }
}
