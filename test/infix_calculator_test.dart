import '../lib/infix_calculator.dart';
import 'package:test/test.dart';


void main() {

  InfixCalculator infixCalculator = new InfixCalculator();

  test('Test for null expression', () {
    try {
      infixCalculator.calculate(null);
    } on ArgumentError catch(e) {
      expect(e.message, 'Empty Expression');
      return;
    }
    throw new Exception("Expected Empty Expression Exception");  
  });

  test('Test for missing left bracket', () {
    try {
      infixCalculator.calculate("2 + 5)");
    } on FormatException catch(e) {
      expect(e.message, 'Unbalanced brackets. Missing: ( paranthesis.');
      return;
    }
    throw new Exception("Expected Unbalanced Brackets Exception");  
  });

  test('Test for missing right bracket', () {
    try {
      infixCalculator.calculate("(2 + 5");
    } on FormatException catch(e) {
      expect(e.message, 'Unbalanced brackets. Missing: ) paranthesis.');
      return;
    }
    throw new Exception("Expected Unbalanced Brackets Exception");  
  });

  test('Test calculate for single value', () {
    expect(infixCalculator.calculate("2"), 2.0);
  });
  
  test('Test calculate for addition', () {
    expect(infixCalculator.calculate("2 + 2"), 4.0);
  });

  test('Test calculate for subtraction', () {
    expect(infixCalculator.calculate("4 - 2"), 2.0);
  });

  test('Test calculate for multiplication', () {
    expect(infixCalculator.calculate("4 * 2"), 8.0);
  });

  test('Test calculate for division', () {
    expect(infixCalculator.calculate("4 / 2"), 2.0);
  });

  test('Test calculate for mixed operators', () {
    expect(infixCalculator.calculate("(5 * 2) + 2"), 12.0);
  });

  test('Test calculate for mixed operators', () {
    expect(infixCalculator.calculate("5 * (2 + 2)"), 20.0);
  });

  test('Test calculate for mixed operators', () {
    expect(infixCalculator.calculate("(5 * (2 + 5) * 3)"), 105.0);
  });

  test('Test calculate for mixed operators', () {
    expect(infixCalculator.calculate("1.00000001 * (2.093198 + 5.3232234) - 9.24 / 7"), 6.096421474164213);
  });
  
  test('Test calculate for mixed operators', () {
    expect(infixCalculator.calculate("8.65468 - 6.65465 - 2.65654"),-0.6565099999999995);
  });
}
