
import 'package:budget_buddy/core/themes/app_color.dart';
import 'package:budget_buddy/core/util/responsive.dart';
import 'package:budget_buddy/features/category/presentation/widgets/explore_screen/pie_chart_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Responsive.height(40),
      child: Stack(
        children: [
          Container(
            height: Responsive.height(30), // 30% من ارتفاع الشاشة
            decoration:  BoxDecoration(
              color: Color(0xFF9BBEC8),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(Responsive.width(7)),
                bottomRight: Radius.circular(Responsive.width(7)),
              ),
            ),
          ),
          Positioned(
            top: Responsive.height(3), // 3% من ارتفاع الشاشة
            right: Responsive.width(2), // 2% من عرض الشاشة
            left: Responsive.width(2), // 2% من عرض الشاشة
            child: const AppBarRow(),
          ),
          Positioned(
            top: Responsive.height(12), // 12% من ارتفاع الشاشة
            right: Responsive.width(5), // 5% من عرض الشاشة
            left: Responsive.width(5), // 5% من عرض الشاشة
            child: const PieChartCardWidget(),
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

