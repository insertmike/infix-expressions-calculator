
import './constants.dart' as Constants;

class Operator {
  String operator;

  Operator(String op) {
      operator = op;
  }

  static int getPrecedence(String operator) {
      if (operator == Constants.OPENING_BRACKET )  return 1;
      else if (operator == "+" || operator == "-" )  return 2;
      else if (operator == "+" || operator == "-")   return 2;
      else if (operator == "*" || operator == "/")   return 3;
      else return -1;
  }
}