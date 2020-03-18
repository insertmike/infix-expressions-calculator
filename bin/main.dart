import '../lib/infix_calculator.dart';

void main() {

  InfixCalculator infixCalculator = new InfixCalculator();
  
  try{
    print(infixCalculator.calculate("2 + 2")); // 4.0 
    print(infixCalculator.calculate("8.65468 - 6.65465 - 2.65654")); // -0.6565099999999995
    print(infixCalculator.calculate("5 * (2 + 2)")); // 20.0
    print(infixCalculator.calculate("4 * 2")); // 8.0
    print(infixCalculator.calculate("1.00000001 * (2.093198 + 5.3232234) - 9.24 / 7")); // 6.096421474164213
  } catch(exception) {
    print(exception);
  }
  
}
