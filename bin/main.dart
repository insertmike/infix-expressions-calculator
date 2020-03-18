import '../lib/infix_calculator.dart';
import 'package:test/test.dart';

void main() {
  final String infixExpression = "5 * (2 + 2)";
  InfixCalculator postfixCalculator = new InfixCalculator();

  print(postfixCalculator.calculateInfixExpression(infixExpression));

  test('Test calculateInfixExpression for single value', () {
    expect(postfixCalculator.calculateInfixExpression("2"), 2.0);
  });
  
  test('Test calculateInfixExpression for addition', () {
    expect(postfixCalculator.calculateInfixExpression("2 + 2"), 4.0);
  });

  test('Test calculateInfixExpression for subtraction', () {
    expect(postfixCalculator.calculateInfixExpression("4 - 2"), 2.0);
  });

  test('Test calculateInfixExpression for multiplication', () {
    expect(postfixCalculator.calculateInfixExpression("4 * 2"), 8.0);
  });

  test('Test calculateInfixExpression for division', () {
    expect(postfixCalculator.calculateInfixExpression("4 / 2"), 2.0);
  });

  test('Test calculateInfixExpression for mixed operators', () {
    expect(postfixCalculator.calculateInfixExpression("(5 * 2) + 2"), 12.0);
  });

  test('Test calculateInfixExpression for mixed operators', () {
    expect(postfixCalculator.calculateInfixExpression("5 * (2 + 2)"), 20.0);
  });

  test('Test calculateInfixExpression for mixed operators', () {
    expect(postfixCalculator.calculateInfixExpression("(5 * (2 + 5) * 3)"), 105.0);
  });

  test('Test calculateInfixExpression for mixed operators', () {
    expect(postfixCalculator.calculateInfixExpression("1.00000001 * (2.093198 + 5.3232234) - 9.24 / 7"), 6.096421474164213);
  });
  
  test('Test calculateInfixExpression for mixed operators', () {
    expect(postfixCalculator.calculateInfixExpression("8.65468 - 6.65465 - 2.65654"),-0.6565099999999995);
  });

  test('when start > stop', () {
    try {
      postfixCalculator.calculateInfixExpression(null);
    } on ArgumentError catch(e) {
      expect(e.message, 'Empty Expression');
      return;
    }
    throw new Exception("Expected Empty Expression Exception");  
  });


  
}
