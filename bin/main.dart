import '../lib/calculator.dart';


void main() {
  final String infixExpression = "3*(5-1)-2";
  Calculator postfixCalculator = new Calculator();
  print(postfixCalculator.calculateInfixExpression(infixExpression));
}
