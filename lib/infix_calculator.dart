
import 'dart:collection';
import 'dart:core';
import 'package:stack/stack.dart';
import '../lib/constants.dart' as Constants;

///
/// Infix Expressions Calculator
/// 
/// The calculator operates using the shunting-yard algorithm to 
/// parse the infix expression to a postfix expression and then
/// evaluate it using a stack
/// 
class InfixCalculator {
  
  /// Calculates infix expression by parsing it to a postfix 
  /// and evaluating the postfix expression.
  double calculate(String infixExpression){

    if(infixExpression == null || infixExpression.isEmpty){
      throw new ArgumentError("Empty Expression");
    }

    String postFixExpression = _convertInfixToPostfix(infixExpression);   
    return _calculatePostfixExpression(postFixExpression);
  } 
  
  /// Calculates infix expression by parsing it to a postfix 
  /// and evaluating the postfix expression
  double _calculatePostfixExpression(String postfixExpression){
    if(postfixExpression == null || postfixExpression.isEmpty){
      throw new ArgumentError("Infix Expression is empty");
    }
    var output = new Stack<double>();
       
    for (var token in postfixExpression.split(' ')) {
      if(_isOperator(token)){
        try{
          double rightOperand =output.pop(); 
          double leftOperand = output.pop();
          
          switch (token) {
            case Constants.MINUS_SIGN:
              output.push(leftOperand - rightOperand);
              break;
            case Constants.PLUS_SIGN:
              output.push(leftOperand + rightOperand);
              break;
            case Constants.DIVISION_SIGN:
              output.push(leftOperand / rightOperand);
              break;
            case Constants.MULTIPLICATION_SIGN:
              output.push(leftOperand * rightOperand);
              break;
            default:
              throw new FormatException("Unsupported operator: " + token);
          }
        }catch(e){
          throw new FormatException("Too many operators. Exception: " + e.toString());
        }
      } else {
          if(!_isNumeric(token)){
            throw new FormatException("Token is not a valid number: " + token);      
          }
          output.push(double.parse(token));
      }
    }

    return output.pop();
  }

  ///  Pops the operators having greater or equal precedence to token.
  ///  Appends operators to output and pushes token to operators stack.
  void _handleOperatorCase(String token, Stack<String> operators, List<String> output){

    // Pop operators off operatorStack having greater or equal precedence to operatorToken.
    // Note that a left parenthesis on the stack will stop the loop.
    while(operators.isNotEmpty && _isOperator(operators.top()) && _getOperatorPrecedence(operators.top()) >= _getOperatorPrecedence(token))  
    {
       output.add(" ");
       output.add(operators.pop());
    }
    output.add(" ");
    operators.push(token);
  }

  /// Parses infix expression and converts it to postfix expression using the Shunting-Yard Algorithm 
  String _convertInfixToPostfix(String infixExpression) {

    if(infixExpression == null || infixExpression.isEmpty){
      throw new ArgumentError("Empty Expression");
    }

    final Queue expressionTokens = Queue<String>();
    //The shunting-yard algorithm's operator stack.
    final Stack operators = Stack<String>();
    // Using List as Strings in Dart are immutable.        
    final List output = List<String>();
    infixExpression =infixExpression.replaceAll(' ','');
    
    // Load characters in expressionTokens Queue
    for (var char in infixExpression.split('')) {
      expressionTokens.add(char);
    }

    while (expressionTokens.isNotEmpty) {
      String token = expressionTokens.removeFirst();

      if(_isOperator(token)){
        _handleOperatorCase(token, operators, output);
      } else{
          switch (token) {
            case Constants.OPENING_BRACKET:
              operators.push(token);
              break;
            case Constants.CLOSING_BRACKET:
              _handleRightParenthesisCase(operators, output);
              break;
            default:              
              // It doesn't append a space since numbers may have multiple digits.
              output.add(token);
              break;
          }
        }
      }
    
    _emptyOperatorStack(operators, output);
    return output.join('');
  }
  
  void _emptyOperatorStack(Stack<String> operators, List<String> output){
    while (operators.isNotEmpty) {
      if(operators.top() == Constants.OPENING_BRACKET){
        throw new FormatException("Unbalanced brackets. Missing: "+ Constants.CLOSING_BRACKET + " paranthesis.");
      }
      output.add(" ");
      output.add(operators.pop());
    }
  }

  /// Until a matching left paranthesis is not found, it pops operators off operators stack and appends them to the output list.
  /// Matching left paranthesis is then popped off operators stack and is not appended to the output.
  void _handleRightParenthesisCase(Stack<String> operators, List<String> output){
    while(operators.isNotEmpty && operators.top() != Constants.OPENING_BRACKET){
      output.add(" ");
      output.add(operators.pop());
    }
    if(operators.isEmpty){
      throw new FormatException("Unbalanced brackets. Missing: " + Constants.OPENING_BRACKET + " paranthesis.");
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

  /// Returns operator precedence
  int _getOperatorPrecedence(String operator) {
      if(operator ==null){
        throw new ArgumentError("Operator is empty.");
      }
      if(!_isOperator(operator)){
        throw new ArgumentError("Parameter is not operator:" + operator);
      }
      if (operator == Constants.OPENING_BRACKET )  return 1;
      else if (operator == "+" || operator == "-" )  return 2;
      else if (operator == "+" || operator == "-")   return 2;
      else if (operator == "*" || operator == "/")   return 3;
      else return -1;
  }  
}
