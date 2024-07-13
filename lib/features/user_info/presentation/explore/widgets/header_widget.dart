import 'dart:math';

import 'package:budget_buddy/core/themes/app_color.dart';
import 'package:budget_buddy/features/explore/presentation/explore/widgets/pie_chart_card_widget.dart';
import 'package:fl_chart/fl_chart.dart';
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
            height: 200,
            decoration: const BoxDecoration(
                // gradient: LinearGradient(
                //   colors: [
                //     AppColor.primaryColor,
                //     AppColor.accentColor,
                //   ],
                //   begin: Alignment.topLeft,
                //   end: Alignment.bottomRight,
                // ),
                color: Color(0xFF9BBEC8),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
          ),
          const Positioned(
              top: 30,
              right: 10,
              left: 10,
              child: AppBarRow()),
          const Positioned(
              top: 120,
              right: 20,
              left: 20,
              child: PieChartCardWidget())

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

