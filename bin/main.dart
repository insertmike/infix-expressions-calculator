import '../lib/infix_calculator.dart';
import 'package:test/test.dart';

void main() {
  final String infixExpression = "5 * (2 + 2)";
  InfixCalculator postfixCalculator = new InfixCalculator();

  print(postfixCalculator.calculateInfixExpression(infixExpression));

  test('0Test calculateInfixExpression for single value', () {
    expect(postfixCalculator.calculateInfixExpression("2"), 2.0);
  });
  
  test('1Test calculateInfixExpression for addition', () {
    expect(postfixCalculator.calculateInfixExpression("2 + 2"), 4.0);
  });

  test('2Test calculateInfixExpression for addition and subtraction', () {
    expect(postfixCalculator.calculateInfixExpression("5 + 5 - 2"), 8.0);
  });

  test('3Test calculateInfixExpression for expression with additon, subtraction, division and multiplication', () {
    expect(postfixCalculator.calculateInfixExpression("(5 * 2) + 2"), 12.0);
  });

  test('4Test calculateInfixExpression for expression with additon, subtraction, division and multiplication', () {
    expect(postfixCalculator.calculateInfixExpression("5 * (2 + 2)"), 20.0);
  });

  test('5Test calculateInfixExpression for expression with additon, subtraction, division and multiplication', () {
    expect(postfixCalculator.calculateInfixExpression("((5 * 2) + (5 * 3))"), 25.0);
  });

  test('6Test calculateInfixExpression for expression with additon, subtraction, division and multiplication', () {
    expect(postfixCalculator.calculateInfixExpression("(5 * (2 + 5) * 3)"), 105.0);
  });  

  
  test('7Test calculateInfixExpression for expression with additon, subtraction, division and multiplication', () {
    expect(postfixCalculator.calculateInfixExpression("4.47 + 1.02 * 3"), 7.53);
  });  

  test('8Test calculateInfixExpression for expression with additon, subtraction, division and multiplication', () {
    expect(postfixCalculator.calculateInfixExpression("5.0214 / 6.2033"), .8095);
  });    


  test('9Test calculateInfixExpression for expression with additon, subtraction, division and multiplication', () {
    expect(postfixCalculator.calculateInfixExpression("1.00000001 * (2.093198 + 5.3232234) - 9.24 / 7"), .8095);
  });     
  // test('Test calculateInfixExpression for null argument', () {
  //   expect(postfixCalculator.calculateInfixExpression(null), throwsA(TypeMatcher<ArgumentError>()));
  // });

  
}
