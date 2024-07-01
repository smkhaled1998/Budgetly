import 'package:budget_buddy/core/themes/app_color.dart';
import 'package:budget_buddy/features/debt/debt_screen.dart';
import 'package:budget_buddy/features/settings/settings_screen.dart';
import 'package:budget_buddy/features/statistics/statistics_screen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:spincircle_bottom_bar/modals.dart';
import 'package:spincircle_bottom_bar/spincircle_bottom_bar.dart';

import '../screens/explore_screen.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  @override
  _BottomNavigationBarWidgetState createState() => _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int touchedIndex = -1;
  int screenIndex = 0;
  List<Widget> screens = [
    ExploreScreen(),
    const StatisticsScreen(),
    const DebtScreen(),
    const SettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SpinCircleBottomBarHolder(
        bottomNavigationBar: SCBottomBarDetails(
            circleColors: [
              AppColor.primaryColor,
              AppColor.accentColor,
              AppColor.textColor
            ],
            iconTheme: const IconThemeData(color: Colors.black45),
            activeIconTheme: const IconThemeData(color: AppColor.accentColor),
            backgroundColor: AppColor.backgroundColor,
            titleStyle:
                const TextStyle(color: AppColor.textBoldColor, fontSize: 12),
            activeTitleStyle: const TextStyle(
                color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
            actionButtonDetails: SCActionButtonDetails(
                color: AppColor.accentColor,
                icon: const Icon(
                  Icons.expand_less,
                  color: Colors.white,
                ),
                elevation: 2),
            elevation: 2.0,
            items: [
              SCBottomBarItem(
                  icon: Icons.home_filled,
                  title: "Explore",
                  onPressed: () {
                    setState(() {
                      screenIndex = 0;
                    });
                  }),
              SCBottomBarItem(
                  icon: Icons.pie_chart,
                  title: "Statistics",
                  onPressed: () {
                    setState(() {
                      screenIndex = 1;
                    });
                  }),
              SCBottomBarItem(
                  icon: Icons.category,
                  title: "Debt",
                  onPressed: () {
                    setState(() {
                      screenIndex = 2;
                    });
                  }),
              SCBottomBarItem(
                  icon: Icons.settings,
                  title: "settings",
                  onPressed: () {
                    setState(() {
                      screenIndex = 3;
                    });
                  }),
            ],
            circleItems: [
              SCItem(icon: const Icon(Icons.attach_money), onPressed: () {

              }),
              SCItem(icon: const Icon(Icons.money_off), onPressed: () {}),

            ],
            bnbHeight: 70 // Suggested Height 80
            ),
        child:Center(
          child: screens[screenIndex],
        ),
      ),
    );
  }

  List<PieChartSectionData> _generateSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 20 : 16;
      final double radius = isTouched ? 80 : 60;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: AppColor.primaryColor,
            value: 30,
            title: 'Expenses',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColor.backgroundColor,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: AppColor.secondaryColor,
            value: 20,
            title: 'Income',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColor.backgroundColor,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: AppColor.accentColor,
            value: 15,
            title: 'Savings',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColor.backgroundColor,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: AppColor.textColor,
            value: 35,
            title: 'Investments',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColor.backgroundColor,
            ),
          );
        default:
          return PieChartSectionData(
            color: Colors.transparent,
            value: 0,
            title: '',
            radius: 0,
          );
      }
    });
  }
}
