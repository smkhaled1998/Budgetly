import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../settings_screen.dart';


class ExpressHeaderWidget extends StatelessWidget {
   ExpressHeaderWidget({Key? key}) : super(key: key);
  final double spentAmount = 550;
  final double totalBudget = 1000;

  @override
  Widget build(BuildContext context) {
    double remainingBalance = totalBudget - spentAmount;
    double progressPercentage = spentAmount / totalBudget;
    return Stack(
      // fit: StackFit.expand,
      children: [
        // خلفية مع نمط تموج عصري
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF2E4F8A), Color(0xFF172B4D)],
            ),
          ),
        ),
        // أنماط زخرفية للخلفية
        Positioned(
          right: -50,
          top: -20,
          child: Opacity(
            opacity: 0.1,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ),
        ),
        Positioned(
          left: -30,
          bottom: -30,
          child: Opacity(
            opacity: 0.1,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ),
        ),
        // محتوى الرصيد مع تأثير الزجاج (Glassmorphism)
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
          child: SingleChildScrollView( // Added to handle potential overflow
            child: Column(
              mainAxisSize: MainAxisSize.min, // Added to prevent expansion
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(5),
                Row(
                  children: [
                    GestureDetector(
                        onTap:(){

                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsScreen()));
                        } ,
                                child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.account_balance_wallet,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                    const Gap(5),
                    const Text(
                      'Budget Overview',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                const Gap(10),
                // Reduced spacing

                // بطاقة الرصيد الزجاجية
                Container(
                  padding: const EdgeInsets.all(15), // Reduced padding
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // عرض الرصيد المتبقي
                      const Text(
                        'Remaining Balance',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          letterSpacing: 0.5,
                        ),
                      ),

                      const Gap(6),

                      Row(
                        children: [
                          Text(
                            '\$${remainingBalance.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28, // Reduced font size
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const Spacer(),
                          // عرض دائري للنسبة المئوية
                          SizedBox(
                            width:45, // Slightly smaller
                            height: 45, // Slightly smaller
                            child: Stack(
                              children: [
                                CircularProgressIndicator(
                                  value: 1 - progressPercentage,
                                  strokeWidth: 4,
                                  backgroundColor: Colors.white.withOpacity(0.2),
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    progressPercentage > 0.9 ? Colors.redAccent : Colors.greenAccent,
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    '${((1 - progressPercentage) * 100).toStringAsFixed(0)}%',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const Gap(12), // Reduced spacing

                      // شريط التقدم بتصميم عصري
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildBudgetInfo(
                                label: 'Spent',
                                amount: spentAmount,
                                iconData: Icons.arrow_downward,
                                iconColor: Colors.redAccent,
                              ),
                              _buildBudgetInfo(
                                label: 'Total',
                                amount: totalBudget,
                                iconData: Icons.account_balance,
                                iconColor: Colors.blueAccent,
                              ),
                            ],
                          ),

                          const Gap(12), // Reduced spacing

                          // شريط تقدم مخصص
                          Container(
                            height: 8,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white.withOpacity(0.1),
                            ),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return Row(
                                  children: [
                                    Container(
                                      width: constraints.maxWidth * progressPercentage,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: LinearGradient(
                                          colors: progressPercentage > 0.9
                                              ? [Colors.redAccent, Colors.orangeAccent]
                                              : [Colors.greenAccent, Colors.cyanAccent],
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: (progressPercentage > 0.9 ? Colors.redAccent : Colors.greenAccent).withOpacity(0.5),
                                            blurRadius: 10,
                                            spreadRadius: -5,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildBudgetInfo({
    required String label,
    required double amount,
    required IconData iconData,
    required Color iconColor,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            iconData,
            color: iconColor,
            size: 14,
          ),
        ),
        const Gap(8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 12,
              ),
            ),
            Text(
              '\$${amount.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

}
