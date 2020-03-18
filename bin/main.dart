import 'dart:collection';

import 'package:stack/stack.dart';
import '../lib/operator.dart';
import '../lib/constants.dart' as Constants;
import '../lib/postfix_calculator.dart';

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

// Uses Shaunting-Yard algorithm
String getPostfixExpression(String infixExpression){

  final Queue expressionTokens =  Queue<String>();
  final Stack operators =  Stack<Operator>();
  final Queue output =  Queue<String>();
  
  // Load characters in expressionTokens Queue
  for (var char in infixExpression.split('')) {
    expressionTokens.add(char);  
  }

  // Load tokens into operators and output
  while (expressionTokens.isNotEmpty) {
    String token = expressionTokens.removeFirst();

    if(isNumeric(token)){
      output.add(token);
    }

    else if(isOperator(token)){
        var curr_operator = Operator(token);
        Operator top_operator;

        if(operators.isNotEmpty){
          top_operator = operators.top();
        }
        

        if(token == Constants.CLOSING_BRACKET){
          while(top_operator != null && top_operator.operator != Constants.OPENING_BRACKET ){
            output.add(top_operator.operator);
            operators.pop();
            top_operator = null;
            if(operators.isNotEmpty){
              top_operator =operators.top();
            }
          }
          if(operators.isNotEmpty){
            operators.pop();
          }
          
        }
        else if(token ==Constants.OPENING_BRACKET){
          operators.push(curr_operator);
        } else {
          while(top_operator != null && top_operator.getPrecedence() > curr_operator.getPrecedence()){
            output.add(top_operator.operator);
            operators.pop();
            top_operator = null;
            if(operators.isNotEmpty){
              top_operator =operators.top();
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

void main(){
  final String mathInfixExpression = "2*(3-4)-3";

  print(getPostfixExpression(mathInfixExpression));

  PostfixCalculator postfixCalculator = new PostfixCalculator();
  
}