import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:expressions/expressions.dart';

import '../../../../../core/themes/app_color.dart';

class CalculatorWidget extends StatefulWidget {
  final Function(String) onValueSelected;

  const CalculatorWidget({super.key, required this.onValueSelected});

  @override
  _CalculatorWidgetState createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {
  String _display = '';
  bool _isResultDisplayed = false;

  static const List<String> numbers = [
    '7', '8', '9', '4', '5', '6', '1', '2', '3', '.', '0', 'Del',
  ];
  static const List<String> operationButtons = ['=', '+', '-', '*', '/'];

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
            widget.onValueSelected(_display); // Pass the value back
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
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
          ),
          Container(
            color: Colors.grey,
            height: 2,
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
                        color: Colors.grey[200],
                        child: TextButton(
                          onPressed: () => _onOperationButtonPressed(button),
                          child: Text(
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
                  width: 2,
                  color: Colors.grey,
                ),
                Column(
                  children: [
                    _operationButtonUI(0),
                    _operationButtonUI(1),
                    _operationButtonUI(2),
                    _operationButtonUI(3),
                    _operationButtonUI(4),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _operationButtonUI(int num) {
    return Container(
      color: Colors.grey,
      child: TextButton(
        onPressed: () => _onOperationButtonPressed(operationButtons[num]),
        child: Text(
          operationButtons[num],
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColor.accentColor,
          ),
        ),
      ),
    );
  }
}
