
import './constants.dart' as Constants;

class Operator {
  String operator;

  Operator(String op) {
      operator = op;
  }

  int getPrecedence() {
      if (operator == Constants.OPENING_BRACKET )  return 1;
      else if (this.operator == "+" || this.operator == "-" )  return 2;
      else if (this.operator == "+" || this.operator == "-")   return 2;
      else if (this.operator == "*" || this.operator == "/")   return 3;
      else return -1;
  }
}