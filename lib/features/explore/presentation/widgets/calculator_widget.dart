import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:expressions/expressions.dart';
import '../../../../core/themes/app_color.dart';

class CalculatorWidget extends StatefulWidget {
  const CalculatorWidget({super.key});

  @override
  _CalculatorWidgetState createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {
  String _display = '';
  bool _isResultDisplayed = false;

  static const List<String> operationButtons = [
    '7', '8', '9', '4', '5', '6', '1', '2', '3', '.', '0', 'Del',
  ];
  static const List<String> buttons = ['=', '+', '-', '*', '/'];

  void _onButtonPressed(String button) {
    setState(() {
      if (button == 'Del') {
        if (_display.isNotEmpty) {
          _display = _display.substring(0, _display.length - 1);
        }
      } else if (button == '=') {
        try {
          if (_display.isNotEmpty) {
            final expression = Expression.parse(_display);
            final evaluator = const ExpressionEvaluator();
            final result = evaluator.eval(expression, {});
            _display = result.toString();
            _isResultDisplayed = true;
          }
        } catch (e) {
          _display = 'Error';
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
                    itemCount: operationButtons.length,
                    itemBuilder: (context, index) {
                      final button = operationButtons[index];
                      return Container(
                        color: Colors.grey[200],
                        child: TextButton(
                          onPressed: () => _onButtonPressed(button),
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
                    _operationButton(0),
                    _operationButton(1),
                    _operationButton(2),
                    _operationButton(3),
                    _operationButton(4),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _operationButton(int num) {
    return Container(
      color: Colors.grey,
      child: TextButton(
        onPressed: () => _onButtonPressed(buttons[num]),
        child: Text(
          buttons[num],
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
