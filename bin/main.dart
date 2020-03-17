import 'dart:collection';

import 'package:stack/stack.dart';
import '../lib/operator.dart';
import '../lib/constants.dart' as Constants;

bool isNumeric(String s) {
  if(s == null) {
    return false;
  }
  return double.parse(s, (e) => null) != null;
}

bool isOperator(String token){
  if(token == null){
    return false;
  }
  return Constants.SUPPORTED_OPERATORS.contains(token);
}

void main(){
  final String mathInfixExpression = "2 * ( 3 - 4 ) - 3";

  final Queue<String> expressionTokens = new Queue<String>();
  final Stack<Operator> operators = new Stack<Operator>();
  final Queue<String> output = new Queue<String>();

  // Load characters in expressionTokens Queue
  for (var char in mathInfixExpression.split("")) {
    expressionTokens.add(char);  
  }

  // Load tokens into operators and output
  while (expressionTokens.isNotEmpty) {
    String token =expressionTokens.removeFirst();

    if(isNumeric(token)){
      output.add(token);
    }

    else if(isOperator(token)){
        Operator operator = new Operator(token);
        Operator top_operator = null;
        if(operators.isNotEmpty){
          Operator top_operator = operators.top();
        }
        

        if(token == Constants.CLOSING_BRACKET){
          while(top_operator != null && top_operator != Constants.OPENING_BRACKET ){
            output.add(top_operator.operator);
            operators.pop();
            top_operator = operators.top();
          }
          operators.push(operator);
        }
        else if(token ==Constants.OPENING_BRACKET){
          operators.push(operator);
        } else {
          while(top_operator != null && top_operator.getPrecedence() > operator.getPrecedence()){
            output.add(top_operator.operator);
            operators.pop();
            top_operator =operators.top();
          }
          operators.push(operator);
        }
    }
  }
  
  while (operators.isNotEmpty) {
        Operator operator = operators.pop();
        output.add(operator.operator);
  }

  
}