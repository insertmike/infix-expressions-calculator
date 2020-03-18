
import 'dart:collection';
import 'dart:core';
import 'package:stack/stack.dart';
import '../lib/constants.dart' as Constants;
import '../lib/operator.dart';


///
/// Infix Expressions Calculator
/// 
/// The calculator operates using the shunting-yard algorithm to 
/// parse the infix expression to a postfix expression and then
/// evaluate it using a stack
/// 
class InfixCalculator {
  
  /// Calculates infix expression by parsing it to a postfix 
  /// and evaluating the postfix expression
  double calculateInfixExpression(String infixExpression){

    if(infixExpression == null || infixExpression.isEmpty){
      throw new ArgumentError("Infix Expression is empty");
    }

    String postFixExpression = _convertInfixToPostfix(infixExpression);   
    return _calculatePostfixExpression(postFixExpression);
  } 

  /// Calculates infix expression by parsing it to a postfix 
  /// and evaluating the postfix expression
  double _calculatePostfixExpression(String postfixExpression) {

    if(postfixExpression == null || postfixExpression.isEmpty){
      throw new ArgumentError("Infix Expression is empty");
    }

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

  /// Pops operators off operatorStack having greater or equal precedence to operatorToken, appends the operators
  ///  to the output string, then pushes operatorToken onto operatorStack.
  void _handleOperatorCase(String token, Stack<Operator> operators, Queue<String> output){

    // Pop operators off operatorStack having greater or equal precedence to operatorToken.
    // Note that a left parenthesis on the stack will stop the loop.
    while(operators.isNotEmpty && _isOperator(operators.top().operator) && Operator.getPrecedence(operators.top().operator) >= Operator.getPrecedence(token))  
    {
       output.add(" ");
       output.add(operators.pop().operator);
    }
    output.add(" ");
    operators.push(Operator(token));
  }

  /// Converts Infix expression to Postfix using the Shunting-Yard Algorithm 
  String _convertInfixToPostfix(String infixExpression) {

    if(infixExpression == null || infixExpression.isEmpty){
      throw new ArgumentError("Infix Expression is empty");
    }

    final Queue expressionTokens = Queue<String>();
    //The shunting-yard algorithm's operator stack.
    final Stack operators = Stack<Operator>();
    final Queue output = Queue<String>();
    infixExpression =infixExpression.replaceAll(' ','');
    
    // Load characters in expressionTokens Queue
    for (var char in infixExpression.split('')) {
      expressionTokens.add(char);
    }

    // Load tokens into operators and output
    while (expressionTokens.isNotEmpty) {
      String token = expressionTokens.removeFirst();

      if(_isOperator(token)){
        _handleOperatorCase(token, operators, output);
      } else{
          switch (token) {
            case Constants.OPENING_BRACKET:
              operators.push(Operator(token));
              break;
            case Constants.CLOSING_BRACKET:
              handleRightParenthesisCase(operators, output);
              break;
            default:
              // Token must be a number. Don't append a space since the number may have multiple digits.
              output.add(token);
              break;
          }
        }
      }
    
    emptyOperatorStack(operators, output);
    return output.toList().join('');
  }
  
  void emptyOperatorStack(Stack<Operator> operators, Queue<String> output){
    while (operators.isNotEmpty) {
      if(operators.top().operator == Constants.OPENING_BRACKET){
        throw new Exception("Missing: "+ Constants.CLOSING_BRACKET + " paranthesis");
      }
      output.add(" ");
      output.add(operators.pop().operator);
    }
  }
  /// Pops operators off operatorStack and appends them to the output string until a matching left parenthesis
  /// is found. The matching left parenthesis is then popped off operatorStack but is not appended to the output
  /// string.
  void handleRightParenthesisCase(Stack<Operator> operators, Queue<String> output){
    while(operators.isNotEmpty && operators.top().operator != Constants.OPENING_BRACKET){
      output.add(" ");
      output.add(operators.pop().operator);
    }
    if(operators.isEmpty){
      throw new Exception("Missing " + Constants.OPENING_BRACKET + " paranthesis");
    }
    operators.pop();
  }

  /// Checks if a string value by attempting to parse 
  /// it to a double data type.
  bool _isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }

  /// Checks if string value is operator by checking
  /// if it is contained in supported operators.
  bool _isOperator(String token) {
    if (token == null) {
      return false;
    }
    return Constants.SUPPORTED_OPERATORS.contains(token);
  }
}
