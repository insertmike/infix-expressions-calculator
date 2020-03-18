import 'dart:collection';
import 'package:stack/stack.dart';
import '../lib/constants.dart' as Constants;
import '../lib/operator.dart';

/**
 * Calculator able to evaluate postfix expressions.
 */
class Calculator {
  
  double calculateInfixExpression(String infixExpression){
    String postFixExpression = _convertInfixToPostfix(infixExpression);   
    return _calculatePostfixExpression(postFixExpression);
  } 

  double _calculatePostfixExpression(String postfixExpression) {
    var queue = Queue<String>();
    var stack = new Stack<double>();

    // Load queue
    for (var char in postfixExpression.split('')) {
      queue.add(char);
    }

    for (String token in queue) {
      if (_isNumeric(token))
        stack.push(double.parse(token));
      else {
        if (stack.isEmpty) continue;
        double right = stack.pop();
        double left = stack.pop();

        if (token == Constants.PLUS_SIGN) stack.push(left + right);
        if (token == Constants.MINUS_SIGN) stack.push(left - right);
        if (token == Constants.MULTIPLICATION_SIGN) stack.push(left * right);
        if (token == Constants.DIVISION_SIGN) stack.push(left / right);
      }
    }
    return stack.pop();
  }

  String _convertInfixToPostfix(String infixExpression) {
    final Queue expressionTokens = Queue<String>();
    final Stack operators = Stack<Operator>();
    final Queue output = Queue<String>();

    // Load characters in expressionTokens Queue
    for (var char in infixExpression.split('')) {
      expressionTokens.add(char);
    }

    // Load tokens into operators and output
    while (expressionTokens.isNotEmpty) {
      String token = expressionTokens.removeFirst();

      if (_isNumeric(token)) {
        output.add(token);
      } else if (_isOperator(token)) {
        var curr_operator = Operator(token);
        Operator top_operator;

        if (operators.isNotEmpty) {
          top_operator = operators.top();
        }

        if (token == Constants.CLOSING_BRACKET) {
          while (top_operator != null &&
              top_operator.operator != Constants.OPENING_BRACKET) {
            output.add(top_operator.operator);
            operators.pop();
            top_operator = null;
            if (operators.isNotEmpty) {
              top_operator = operators.top();
            }
          }
          if (operators.isNotEmpty) {
            operators.pop();
          }
        } else if (token == Constants.OPENING_BRACKET) {
          operators.push(curr_operator);
        } else {
          while (top_operator != null &&
              top_operator.getPrecedence() > curr_operator.getPrecedence()) {
            output.add(top_operator.operator);
            operators.pop();
            top_operator = null;
            if (operators.isNotEmpty) {
              top_operator = operators.top();
            }
          }
          operators.push(curr_operator);
        }
      }
    }

    while (operators.isNotEmpty) {
      Operator operator = operators.pop();
      output.add(operator.operator);
    }

    return output.toList().join('');
  }

  bool _isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }

  bool _isOperator(String token) {
    if (token == null) {
      return false;
    }
    return Constants.SUPPORTED_OPERATORS.contains(token);
  }
}
