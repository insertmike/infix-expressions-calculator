import '../lib/infix_calculator.dart';

void main() {
  final String infixExpression = "3-2*5";
  InfixCalculator postfixCalculator = new InfixCalculator();
  print(postfixCalculator.calculateInfixExpression(infixExpression));
}
