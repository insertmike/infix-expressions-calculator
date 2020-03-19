# Infix Expressions Calculator

## Abstract

Infix Expression calculator, which evaluates mathematical expression while respecting the order of operations and the precedence of the different operands. The calculator also detects unbalanced brackets.

**Supported Operators**: Addition ( + ), Subtraction ( - ) , Multiplication ( * ), Divison ( * ) 

**Usage Example**

```
InfixCalculator infixCalculator = new InfixCalculator();

infixCalculator.calculate("4 / 2") 
=> 2.0

infixCalculator.calculate("(5 * (2 + 5) * 3) 
=> 105.0

infixCalculator.calculate("1.00000001 * (2.093198 + 5.3232234) - 9.24 / 7") 
=> 6.096421474164213

infixCalculator.calculate("2") 
=> 2.0

infixCalculator.calculate("2 + 5) 
=> Format Exception: Unbalanced brackets. Missing: ( paranthesis.

infixCalculator.calculate(null) 
=> Argument Error: Empty Expression
```

## How does it work
In order to evaluate the infix expressions accurately, the calculator parses the infix notation to a notation, which can be parsed i-order. The notation used for this is the Postfix Notation or the Reverse Polish Notation. 

**Parsing to Reverse Polish Notation**
The Reverse polish notation puts the operations after the operands rather than before them:

```
Infix Notation: 1 * 2 + 3 * 4    // (1 * 2) + (3 * 4) 
Postfix Notation: 1 2 * 3 4 * +  // (1 2 * ) (3 4 * ) + 
```
This is all done by using the [shaunting-yard algorithm](https://en.wikipedia.org/wiki/Shunting-yard_algorithm)
The calculator can 
1. Preserve the [PEMDAS](https://study.com/academy/lesson/what-is-pemdas-definition-rule-examples.html) in the output via a loop invariant. 

    As a loop invariant any operations present in the queue, will be in the order of operations from the highest precedence ( paranthesis ) to the lowest ( addiction and subtraction ) 
    
2. Preserve the [PEMDAS](https://study.com/academy/lesson/what-is-pemdas-definition-rule-examples.html) in the Operation Stack via a Loop Invariant

    The calculator keeps track of the operations in a stack. Every time it parses a new token, the stack will be in the oorder of operations with the highest precedence at the top, and the lowest at the bottom. When run out of tokens, the calculator pops the operations in order and adds them to the output.

3. Maintains the Invariants

    The calculator maintains the loops invariants with the operations stack. When operation with lower precedence than the topmost operation on the operation stack is parsed the operators preserves both invariants by popping off operations from the operations stack and enqueing it onto the output queue until the topmost operation on the operations stack has the same or lower precedence than the current operation.

Shaunting-Yard Pseudo Code from Wikipedia:
```
while there are tokens to be read do:
    read a token.
    if the token is a number, then:
        push it to the output queue.
    if the token is a function then:
        push it onto the operator stack 
    if the token is an operator, then:
        while ((there is a function at the top of the operator stack)
               or (there is an operator at the top of the operator stack with greater precedence)
               or (the operator at the top of the operator stack has equal precedence and the token is left associative))
              and (the operator at the top of the operator stack is not a left parenthesis):
            pop operators from the operator stack onto the output queue.
        push it onto the operator stack.
    if the token is a left paren (i.e. "("), then:
        push it onto the operator stack.
    if the token is a right paren (i.e. ")"), then:
        while the operator at the top of the operator stack is not a left paren:
            pop the operator from the operator stack onto the output queue.
        /* If the stack runs out without finding a left paren, then there are mismatched parentheses. */
        if there is a left paren at the top of the operator stack, then:
            pop the operator from the operator stack and discard it
/* After while loop, if operator stack not null, pop everything to output queue */
if there are no more tokens to read then:
    while there are still operator tokens on the stack:
        /* If the operator token on the top of the stack is a paren, then there are mismatched parentheses. */
        pop the operator from the operator stack onto the output queue.
exit.
```


