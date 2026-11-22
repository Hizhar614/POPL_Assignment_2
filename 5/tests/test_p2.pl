% From the repository root, load the implementation before this file with:
% swipl -q -s 5/code/5_q2.pl -s 5/tests/test_p2.pl -g run_tests -t halt
% This file does not consult the implementation, so its source path can be
% selected independently by the test runner.

:- begin_tests(p2).

test(all_equations_four_numbers) :-
    all_equations([4, 2, 5, 3],
                  ["4*2-5=3", "4*2=5+3", "4-2=5-3", "4/2=5-3",
                   "4=2*(5-3)", "4=2+(5-3)", "4=2+5-3"]).

test(all_equations_no_solution_example) :-
    all_equations([2, 3, 4], []).

test(all_equations_multiplication_example) :-
    all_equations([2, 4, 8], ["2*4=8"]).

test(all_equations_empty_input) :-
    all_equations([], []).

test(all_equations_singleton_input) :-
    all_equations([7], []).

test(generate_equation_four_numbers) :-
    once(generate_equation([4, 2, 5, 3], Equation)),
    string(Equation).

test(generate_equation_exact_division_example) :-
    generate_equation([4, 2, 5, 3], "4/2=5-3").

test(generate_equation_multiplication_example) :-
    generate_equation([2, 4, 8], "2*4=8").

test(generate_equation_no_solution_example, [fail]) :-
    generate_equation([2, 3, 4], _Equation).

test(generate_equation_empty_input, [fail]) :-
    generate_equation([], _Equation).

test(generate_equation_singleton_input, [fail]) :-
    generate_equation([7], _Equation).

test(count_equations_four_numbers) :-
    count_equations([4, 2, 5, 3], 7).

test(count_equations_no_solution_example) :-
    count_equations([2, 3, 4], 0).

test(count_equations_multiplication_example) :-
    count_equations([2, 4, 8], 1).

test(count_equations_empty_input) :-
    count_equations([], 0).

test(count_equations_singleton_input) :-
    count_equations([7], 0).

:- end_tests(p2).

:- begin_tests(expression_value).

test(singleton) :-
    once(expression_value([5], num(5), 5)).

test(addition) :-
    once(expression_value([4, 2], expr(add, num(4), num(2)), 6)).

test(subtraction) :-
    once(expression_value([4, 7], expr(subtract, num(4), num(7)), -3)).

test(multiplication) :-
    once(expression_value([4, 2], expr(multiply, num(4), num(2)), 8)).

test(exact_division) :-
    once(expression_value([8, 4], expr(divide, num(8), num(4)), 2)).

test(inexact_direct_division_fails, [fail]) :-
    expression_value([5, 2], expr(divide, num(5), num(2)), 2).

test(division_by_zero_fails, [fail]) :-
    expression_value([5, 0], expr(divide, num(5), num(0)), _Value).

test(nested_expression_preserves_order_and_exact_division) :-
    once(expression_value([8, 4, 2],
                          expr(add, expr(divide, num(8), num(4)), num(2)),
                          4)).

test(nested_inexact_division_fails, [fail]) :-
    expression_value([5, 2, 1],
                     expr(subtract, expr(divide, num(5), num(2)), num(1)),
                     1).

test(empty_list_fails, [fail]) :-
    expression_value([], _Expression, _Value).

test(negative_number_fails, [fail]) :-
    expression_value([-1], num(-1), -1).

:- end_tests(expression_value).

:- begin_tests(format_expression).

test(single_number) :-
    once(format_expression(num(42), String)),
    string(String),
    String == "42".

test(addition) :-
    once(format_expression(expr(add, num(2), num(3)), String)),
    string(String),
    String == "2+3".

test(subtraction) :-
    once(format_expression(expr(subtract, num(7), num(2)), String)),
    string(String),
    String == "7-2".

test(multiplication) :-
    once(format_expression(expr(multiply, num(4), num(2)), String)),
    string(String),
    String == "4*2".

test(division) :-
    once(format_expression(expr(divide, num(8), num(4)), String)),
    string(String),
    String == "8/4".

test(multiplication_nested_under_addition) :-
    once(format_expression(expr(add, num(4), expr(multiply, num(2), num(3))), String)),
    string(String),
    String == "4+2*3".

test(lower_precedence_left_operand) :-
    once(format_expression(expr(multiply, expr(add, num(4), num(2)), num(3)), String)),
    string(String),
    String == "(4+2)*3".

test(equal_precedence_right_operand) :-
    once(format_expression(expr(subtract, num(4), expr(subtract, num(2), num(3))), String)),
    string(String),
    String == "4-(2-3)".

test(equal_precedence_left_operand) :-
    once(format_expression(expr(subtract, expr(subtract, num(4), num(2)), num(3)), String)),
    string(String),
    String == "4-2-3".

test(mixed_addition_and_subtraction) :-
    once(format_expression(expr(add, expr(subtract, num(4), num(2)), num(3)), String)),
    string(String),
    String == "4-2+3".

test(mixed_division_and_multiplication) :-
    once(format_expression(expr(multiply, expr(divide, num(8), num(4)), num(2)), String)),
    string(String),
    String == "8/4*2".

test(right_operand_with_lower_precedence) :-
    once(format_expression(expr(multiply, num(4), expr(add, num(2), num(3))), String)),
    string(String),
    String == "4*(2+3)".

test(nested_multiple_precedence_levels) :-
    once(format_expression(
             expr(multiply,
                  expr(add, num(4), num(2)),
                  expr(subtract, num(8), expr(divide, num(6), num(3)))),
             String)),
    string(String),
    String == "(4+2)*(8-6/3)".

:- end_tests(format_expression).
