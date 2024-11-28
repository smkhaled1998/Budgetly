import 'package:budget_buddy/core/themes/app_color.dart';
import 'package:budget_buddy/features/debt/debt_screen.dart';
import 'package:budget_buddy/features/user_info/presentation/settings/screens/settings_screen.dart';
import 'package:budget_buddy/features/statistics/statistics_screen.dart';
import 'package:flutter/material.dart';
import 'package:spincircle_bottom_bar/modals.dart';
import 'package:spincircle_bottom_bar/spincircle_bottom_bar.dart';

import '../../../expense_entry/presentation/screens/expense_entry_screen.dart';
import 'explore_screen.dart';

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  _MainNavigatorState createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int touchedIndex = -1;
  int screenIndex = 0;

  List<Widget> screens = [
    ExploreScreen(),
    const StatisticsScreen(),
    const DebtScreen(),
    SettingsScreen()
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
                  title: "Settings",
                  onPressed: () {
                    setState(() {
                      screenIndex = 3;
                    });
                  }),
            ],
            circleItems: [
              SCItem(
                  icon: const Icon(Icons.attach_money),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ExpenseEntryScreen()));
                  }),
              SCItem(icon: const Icon(Icons.money_off), onPressed: () {}),
            ],
            bnbHeight: 70 // Suggested Height 80
            ),
        child: Center(
          child: screens[screenIndex],
        ),
      ),
    );
  }
}
