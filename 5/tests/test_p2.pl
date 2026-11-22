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
