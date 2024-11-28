import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:expressions/expressions.dart';

import '../../../../../core/themes/app_color.dart';
import '../cubit/expense_entery_cubit.dart';

class CalculatorWidget extends StatefulWidget {
  final Function(String) onValueSelected;
  final String selectedCategory;

  const CalculatorWidget({super.key, required this.selectedCategory, required this.onValueSelected});

  @override
  _CalculatorWidgetState createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {
  String _display = '';
  bool _isResultDisplayed = false;

  static const List<String> numbers = [
    '7', '8', '9', '4', '5', '6', '1', '2', '3', '.', '0', 'Del',
  ];
  static const List<String> operationButtons = ['+', '-', '*', '÷', '='];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: const Color(0xFFEEF7FF),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                _display,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: AppColor.accentColor,
                ),
                textAlign: TextAlign.right,
              ),
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF9BBEC8),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    children: [
                      SizedBox(height: 30, width: 30, child: Image.asset("assets/healthcare.png")),
                      const Gap(5),
                      Text(
                        widget.selectedCategory, // [معدل] عرض اسم الفئة المختارة
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColor.primaryColor,
                        ),
                      )
                    ],
                  ),
                ),
                const Gap(10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFB5C0D0),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    children: [
                      SizedBox(height: 30, width: 30, child: Image.asset("assets/note.png")),
                      const Gap(5),
                      const Text(
                        "Note",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColor.primaryColor,
                        ),
                      )
                    ],
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFB5C0D0),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(child: _operationButtonUI(4)),
                  ),
                ),
              ],
            ),
            const Gap(5),
            SingleChildScrollView(
              child: Row(
                children: [
                  Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.5,
                      ),
                      itemCount: numbers.length,
                      itemBuilder: (context, index) {
                        final button = numbers[index];
                        return Container(
                          child: TextButton(
                            onPressed: () => _onOperationButtonPressed(button),
                            child: button == 'Del'
                                ? Image.asset('assets/delete.png', height: 40, width: 40)
                                : Text(
                              button,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColor.primaryColor,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF9BBEC8),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    margin: const EdgeInsets.only(right: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _operationButtonUI(0),
                        _operationButtonUI(1),
                        _operationButtonUI(2),
                        _operationButtonUI(3),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onOperationButtonPressed(String button) {
    setState(() {
      if (button == 'Del') {
        if (_display.isNotEmpty) {
          _display = _display.substring(0, _display.length - 1);
        }
      } else if (button == '=') {
        try {
          if (_display.isNotEmpty) {
            final expression = Expression.parse(_display);
            const evaluator = ExpressionEvaluator();
            final result = evaluator.eval(expression, {});
            _display = result.toString();
            _isResultDisplayed = true;
            widget.onValueSelected(_display);

          }
        } catch (e) {
          _display = "Error";
          print(e.toString());
          _isResultDisplayed = true;
        }
      } else {
        if (_isResultDisplayed) {
          _display = button;
          _isResultDisplayed = false;
        } else {
          _display += button;
        }
      }
    });
  }

  Widget _operationButtonUI(int num) {
    return Container(
      margin: num == 4 ? const EdgeInsets.symmetric(vertical: 0) : const EdgeInsets.symmetric(vertical: 6),
      child: TextButton(
        onPressed: () => _onOperationButtonPressed(operationButtons[num]),
        child: Text(
          operationButtons[num],
          style: num == 4
              ? const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColor.accentColor,
          )
              : const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColor.accentColor,
          ),
        ),
      ),
    );
  }
}
