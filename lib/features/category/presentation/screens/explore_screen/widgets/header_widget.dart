
import 'package:budget_buddy/core/themes/app_color.dart';
import 'package:budget_buddy/features/category/presentation/screens/explore_screen/widgets/pie_chart_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 340,
      child: Stack(
        children: [
          Container(
            height: 200, // 30% من ارتفاع الشاشة
            decoration:  const BoxDecoration(
              color: Color(0xFF9BBEC8),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
          ),
          const Positioned(
            top: 20,
            right: 15,
            left: 15,
            child: AppBarRow(),
          ),
          const Positioned(
            top: 110,
            right: 15,
            left: 15,
            child: PieChartCardWidget(),
          ),
        ],
      ),
    );
  }
}

class AppBarRow extends StatelessWidget {
  const AppBarRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello",
                style: TextStyle(
                  color: AppColor.backgroundColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "Khaled Said",
                style: TextStyle(

                  color: AppColor.textBoldColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,

                image: DecorationImage(image: AssetImage("assets/person.png"))),
          ),
        ],
      ),
    );
  }
}

