import '../lib/infix_calculator.dart';
import 'package:test/test.dart';


void main() {

  test('Test for single value', () {
    expect(InfixCalculator().calculateInfixExpression("2"), 23.0);
  });

  print('wohoo');
}
