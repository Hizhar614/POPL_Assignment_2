:- use_module(library(lists), [append/3]).

expression_value([Number], num(Number), Number) :-
    integer(Number),
    Number >= 0.
expression_value(Numbers, expr(Operator, LeftExpression, RightExpression), Value) :-
    append(LeftNumbers, RightNumbers, Numbers),
    LeftNumbers = [_|_],
    RightNumbers = [_|_],
    expression_value(LeftNumbers, LeftExpression, LeftValue),
    expression_value(RightNumbers, RightExpression, RightValue),
    (   Operator = add,
        Value is LeftValue + RightValue
    ;   Operator = subtract,
        Value is LeftValue - RightValue
    ;   Operator = multiply,
        Value is LeftValue * RightValue
    ;   Operator = divide,
        RightValue =\= 0,
        0 is LeftValue mod RightValue,
        Value is LeftValue // RightValue
    ).

format_expression(num(Number), String) :-
    number_string(Number, String).
format_expression(expr(Operator, Left, Right), String) :-
    operator_symbol(Operator, Symbol),
    format_operand(Left, Operator, left, LeftString),
    format_operand(Right, Operator, right, RightString),
    string_concat(LeftString, Symbol, Prefix),
    string_concat(Prefix, RightString, String).

format_operand(num(Number), _ParentOperator, _Side, String) :-
    number_string(Number, String).
format_operand(expr(Operator, Left, Right), ParentOperator, Side, String) :-
    format_expression(expr(Operator, Left, Right), ExpressionString),
    (   operand_needs_parentheses(Operator, ParentOperator, Side)
    ->  string_concat("(", ExpressionString, Prefix),
        string_concat(Prefix, ")", String)
    ;   String = ExpressionString
    ).

operand_needs_parentheses(ChildOperator, ParentOperator, left) :-
    operator_precedence(ChildOperator, ChildPrecedence),
    operator_precedence(ParentOperator, ParentPrecedence),
    ChildPrecedence < ParentPrecedence.
operand_needs_parentheses(ChildOperator, ParentOperator, right) :-
    operator_precedence(ChildOperator, ChildPrecedence),
    operator_precedence(ParentOperator, ParentPrecedence),
    ChildPrecedence =< ParentPrecedence.

operator_symbol(add, "+").
operator_symbol(subtract, "-").
operator_symbol(multiply, "*").
operator_symbol(divide, "/").

operator_precedence(add, 1).
operator_precedence(subtract, 1).
operator_precedence(multiply, 2).
operator_precedence(divide, 2).

generate_equation(List, Equation) :-
    append(LeftNumbers, RightNumbers, List),
    LeftNumbers = [_|_],
    RightNumbers = [_|_],
    expression_value(LeftNumbers, LeftExpression, LeftValue),
    expression_value(RightNumbers, RightExpression, RightValue),
    LeftValue =:= RightValue,
    format_expression(LeftExpression, LeftString),
    format_expression(RightExpression, RightString),
    string_concat(LeftString, "=", Prefix),
    string_concat(Prefix, RightString, Equation).

all_equations(List, Equations) :-
    findall(Equation, generate_equation(List, Equation), GeneratedEquations),
    sort(GeneratedEquations, Equations).
