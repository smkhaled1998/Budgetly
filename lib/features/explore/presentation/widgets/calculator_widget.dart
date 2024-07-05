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

  static const List<String> operationButtons = [
    '7', '8', '9', '+',
    '4', '5', '6', '-',
    '1', '2', '3', 'x',
    '0', '.', '00', '/',
  ];
  static const List<String> buttons = [
    'C', 'Del', '='
  ];

  void _onButtonPressed(String button) {
    setState(() {
      if (button == 'C') {
        _display = '';
      } else if (button == 'Del') {
        if (_display.isNotEmpty) {
          _display = _display.substring(0, _display.length - 1);
        }
      } else if (button == '=') {
        try {
          _display = _evaluate(_display);
        } catch (e) {
          _display = 'Error';
        }
      } else {
        _display += button;
      }
    });
  }

  String _evaluate(String expression) {
    expression = expression.replaceAll('x', '*');
    final parsedExpression = Expression.parse(expression);
    const evaluator = ExpressionEvaluator();
    final result = evaluator.eval(parsedExpression, {});
    return result.toString();
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
          Gap(5),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.5,
            ),
            itemCount: buttons.length,
            itemBuilder: (context, index) {
              final button = buttons[index];
              return ElevatedButton(
                onPressed: () => _onButtonPressed(button),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _getButtonColor(button),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  button,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColor.backgroundColor,
                  ),
                ),
              );
            },
          ),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1.5,
            ),
            itemCount: operationButtons.length,
            itemBuilder: (context, index) {
              final button = operationButtons[index];
              return ElevatedButton(
                onPressed: () => _onButtonPressed(button),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _getButtonColor(button),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  button,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColor.backgroundColor,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Color _getButtonColor(String button) {
    if (button == 'C' || button == 'Del') {
      return AppColor.lightGray;
    } else if (button == '=' || button == '/' || button == 'x' || button == '-' || button == '+') {
      return AppColor.secondaryColor;
    } else {
      return AppColor.primaryColor;
    }
  }
}
