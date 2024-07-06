import 'package:budget_buddy/core/themes/app_color.dart';
import 'package:budget_buddy/features/debt/debt_screen.dart';
import 'package:budget_buddy/features/explore/presentation/screens/expense_entry_screen.dart';
import 'package:budget_buddy/features/explore/presentation/widgets/calculator_widget.dart';
import 'package:budget_buddy/features/settings/settings_screen.dart';
import 'package:budget_buddy/features/statistics/statistics_screen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:spincircle_bottom_bar/modals.dart';
import 'package:spincircle_bottom_bar/spincircle_bottom_bar.dart';

import 'explore_screen.dart';

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
                  title: "settings",
                  onPressed: () {
                    setState(() {
                      screenIndex = 3;
                    });
                  }),
            ],
            circleItems: [
              SCItem(icon: const Icon(Icons.attach_money), onPressed: () {
                Navigator.push(context,      MaterialPageRoute(builder: (context)=>ExpenseEntryScreen()));
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

  // void _showModalBottomSheet(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     builder: (BuildContext context) {
  //       return Container(
  //         padding: EdgeInsets.zero,
  //         height: MediaQuery.of(context).size.height*.85 ,
  //         child: Column(
  //           children: [
  //
  //
  //             // Container(
  //             //   height: MediaQuery.of(context).size.height * 0.3,
  //             //   padding: EdgeInsets.all(16.0),
  //             //   color: Colors.grey[200],
  //             //   child: Column(
  //             //     children: [
  //             //       Row(
  //             //         children: [
  //             //           _buildCalculatorButton('1'),
  //             //           _buildCalculatorButton('2'),
  //             //           _buildCalculatorButton('3'),
  //             //         ],
  //             //       ),
  //             //       Row(
  //             //         children: [
  //             //           _buildCalculatorButton('4'),
  //             //           _buildCalculatorButton('5'),
  //             //           _buildCalculatorButton('6'),
  //             //         ],
  //             //       ),
  //             //       Row(
  //             //         children: [
  //             //           _buildCalculatorButton('7'),
  //             //           _buildCalculatorButton('8'),
  //             //           _buildCalculatorButton('9'),
  //             //         ],
  //             //       ),
  //             //       Row(
  //             //         children: [
  //             //           _buildCalculatorButton('0'),
  //             //           _buildCalculatorButton('.'),
  //             //           _buildCalculatorButton('='),
  //             //         ],
  //             //       ),
  //             //     ],
  //             //   ),
  //             // ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  // Widget _buildCalculatorButton(String text) {
  //   return Expanded(
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: ElevatedButton(
  //         onPressed: () {
  //           // Handle calculator button press
  //         },
  //         child: Text(text),
  //       ),
  //     ),
  //   );
  // }

}
