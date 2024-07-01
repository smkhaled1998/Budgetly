import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/themes/app_color.dart';
import '../../../../core/themes/app_theme.dart';

class PieChartCardWidget extends StatefulWidget {
  const PieChartCardWidget({Key? key}) : super(key: key);

  @override
  _PieChartCardWidgetState createState() => _PieChartCardWidgetState();
}

class _PieChartCardWidgetState extends State<PieChartCardWidget> {
  int? touchedIndex;

  final List<String> sectionNames = [
    "Housing",
    "Education & Family & Health",
    "Family",
    "Health"
  ];
  final List<String> sectionAmount = ["\$35", "\$15", "\$45", "\$5"];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: AppColor.backgroundColor,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            spreadRadius: 1.0,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "\$498.57",
                  style: cardAmountTextStyle,
                ),
                const SizedBox(height: 4),
                const Text(
                  "Available Balance",
                  style: TextStyle(color: AppColor.textLightColor, fontSize: 13),
                ),
                const SizedBox(height: 16),
                const TransactionWidget(
                  amount: "50.99",
                  isIncome: false,
                  label: "Expenses",
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (pieTouchResponse?.touchedSection != null) {
                            touchedIndex = pieTouchResponse!
                                .touchedSection!.touchedSectionIndex;
                          } else {
                            touchedIndex = null;
                          }
                        });
                      },
                    ),
                    centerSpaceRadius: 45,
                    startDegreeOffset: -120,
                    sectionsSpace: 0,
                    borderData: FlBorderData(show: false),
                    sections: _showingSections(),
                  ),
                ),
                if (touchedIndex != null && touchedIndex! >= 0)
                  SizedBox(
                    height: 80,
                    width: 80,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            sectionNames[touchedIndex!],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                              color: AppColor.accentColor,
                            ),
                          ),
                          Text(
                            sectionAmount[touchedIndex!],
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColor.accentColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  const SizedBox(
                    height: 80,
                    width: 80,
                    child: Center(
                      child: Text(
                        "Tap on a section",
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColor.accentColor,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )


              ],
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 18 : 14;
      final double radius = isTouched ? 45 : 40;

      return PieChartSectionData(
        borderSide: const BorderSide(
          width: .5,
          strokeAlign: 0.5,
          color: AppColor.textLightColor,
        ),
        color: [Colors.red, Colors.blue, Colors.teal, Colors.yellowAccent][i],
        value: [35, 15, 45, 5][i].toDouble(),
        title: "${[35, 15, 45, 5][i]}%",
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    });
  }
}

class TransactionWidget extends StatelessWidget {
  final String label;
  final String amount;
  final bool isIncome;

  const TransactionWidget({
    Key? key,
    required this.label,
    required this.amount,
    required this.isIncome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: isIncome ? color3 : color2,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(color: AppColor.textLightColor, fontSize: 13),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Text(
            "\$ $amount",
            style: transactionAmountTextStyle,
          ),
        ),
      ],
    );
  }
}
