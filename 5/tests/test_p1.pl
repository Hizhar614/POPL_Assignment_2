:- prolog_load_context(directory, TestDirectory),
   atom_concat(TestDirectory, '/../code/5_q1.pl', SolutionFile),
   consult(SolutionFile).
:- use_module(library(lists), [permutation/2]).
:- use_module(library(apply), [maplist/2]).

% Candidate generator tests

test_candidate_generator :-
    findall(Solution, candidate_solution(Solution), Solutions),
    require_test(length(Solutions, 13824), generated_solution_count),
    require_test(maplist(valid_structure, Solutions), every_solution_is_valid),
    sort(Solutions, UniqueSolutions),
    require_test(length(UniqueSolutions, 13824), no_duplicate_solutions).

valid_structure([
    p('Alex', Dept1, Lang1, Project1),
    p('Ben', Dept2, Lang2, Project2),
    p('Carla', Dept3, Lang3, Project3),
    p('Dana', Dept4, Lang4, Project4)
]) :-
    permutation([research, development, design, testing],
                [Dept1, Dept2, Dept3, Dept4]),
    permutation([python, java, 'c++', javascript],
                [Lang1, Lang2, Lang3, Lang4]),
    permutation(['AI', web, embedded, data],
                [Project1, Project2, Project3, Project4]).

% Individual clue tests

test_clue1 :-
    require_test(
        clue(1, [
            p('Alex', design, python, 'AI'),
            p('Ben', development, java, web),
            p('Carla', testing, 'c++', embedded),
            p('Dana', research, javascript, data)
        ]),
        valid_ai_preference_succeeds),
    require_test(
        \+ clue(1, [
            p('Alex', development, python, web),
            p('Ben', research, java, 'AI'),
            p('Carla', design, 'c++', embedded),
            p('Dana', testing, javascript, data)
        ]),
        ai_preference_in_research_fails),
    require_test(
        \+ clue(1, [
            p('Alex', research, python, web),
            p('Ben', development, java, embedded),
            p('Carla', design, 'c++', data),
            p('Dana', testing, javascript, 'AI')
        ]),
        dana_preferring_ai_fails).

test_clue2 :-
    require_test(
        clue(2, [
            p('Alex', design, python, web),
            p('Ben', development, java, 'AI'),
            p('Carla', testing, 'c++', embedded),
            p('Dana', research, javascript, data)
        ]),
        alex_conditions_satisfied),
    require_test(
        \+ clue(2, [
            p('Alex', development, python, web),
            p('Ben', research, java, 'AI'),
            p('Carla', design, 'c++', embedded),
            p('Dana', testing, javascript, data)
        ]),
        alex_in_development_fails),
    require_test(
        \+ clue(2, [
            p('Alex', design, 'c++', web),
            p('Ben', development, java, 'AI'),
            p('Carla', testing, python, embedded),
            p('Dana', research, javascript, data)
        ]),
        alex_prefers_cpp_fails).

test_clue3 :-
    require_test(
        clue(3, [
            p('Alex', research, java, web),
            p('Ben', development, javascript, 'AI'),
            p('Carla', testing, python, embedded),
            p('Dana', design, 'c++', data)
        ]),
        testing_department_likes_python_succeeds),
    require_test(
        \+ clue(3, [
            p('Alex', research, python, web),
            p('Ben', development, javascript, 'AI'),
            p('Carla', testing, java, embedded),
            p('Dana', design, 'c++', data)
        ]),
        testing_department_likes_java_fails),
    require_test(
        \+ clue(3, [
            p('Alex', research, python, web),
            p('Ben', development, java, 'AI'),
            p('Carla', testing, 'c++', embedded),
            p('Dana', design, javascript, data)
        ]),
        python_outside_testing_fails).

test_clue4 :-
    require_test(
        clue(4, [
            p('Alex', research, python, 'AI'),
            p('Ben', development, java, web),
            p('Carla', design, 'c++', embedded),
            p('Dana', testing, javascript, data)
        ]),
        ben_web_outside_testing_succeeds),
    require_test(
        \+ clue(4, [
            p('Alex', research, python, 'AI'),
            p('Ben', testing, java, web),
            p('Carla', design, 'c++', embedded),
            p('Dana', development, javascript, data)
        ]),
        ben_web_in_testing_fails),
    require_test(
        \+ clue(4, [
            p('Alex', research, python, 'AI'),
            p('Ben', development, java, embedded),
            p('Carla', testing, 'c++', web),
            p('Dana', design, javascript, data)
        ]),
        ben_not_preferring_web_fails).

test_clue5 :-
    require_test(
        clue(5, [
            p('Alex', research, python, 'AI'),
            p('Ben', development, javascript, web),
            p('Carla', design, java, embedded),
            p('Dana', testing, 'c++', data)
        ]),
        java_in_design_succeeds),
    require_test(
        \+ clue(5, [
            p('Alex', development, python, 'AI'),
            p('Ben', research, java, web),
            p('Carla', design, 'c++', embedded),
            p('Dana', testing, javascript, data)
        ]),
        java_in_research_fails),
    require_test(
        \+ clue(5, [
            p('Alex', research, python, 'AI'),
            p('Ben', development, java, web),
            p('Carla', design, 'c++', embedded),
            p('Dana', testing, javascript, data)
        ]),
        design_without_java_fails).

test_clue6 :-
    require_test(
        clue(6, [
            p('Alex', research, python, 'AI'),
            p('Ben', development, java, web),
            p('Carla', design, 'c++', data),
            p('Dana', testing, javascript, embedded)
        ]),
        carla_allowed_department_and_project_succeeds),
    require_test(
        \+ clue(6, [
            p('Alex', research, python, 'AI'),
            p('Ben', development, java, web),
            p('Carla', design, 'c++', embedded),
            p('Dana', testing, javascript, data)
        ]),
        carla_embedded_project_fails),
    require_test(
        \+ clue(6, [
            p('Alex', research, python, 'AI'),
            p('Ben', testing, java, web),
            p('Carla', development, 'c++', data),
            p('Dana', design, javascript, embedded)
        ]),
        carla_development_department_fails).

test_clue7 :-
    require_test(
        clue(7, [
            p('Alex', development, python, 'AI'),
            p('Ben', design, java, web),
            p('Carla', testing, 'c++', embedded),
            p('Dana', research, javascript, data)
        ]),
        dana_research_non_java_succeeds),
    require_test(
        clue(7, [
            p('Alex', research, python, 'AI'),
            p('Ben', development, java, web),
            p('Carla', design, 'c++', embedded),
            p('Dana', testing, javascript, data)
        ]),
        dana_testing_non_java_succeeds),
    require_test(
        \+ clue(7, [
            p('Alex', research, python, 'AI'),
            p('Ben', development, java, web),
            p('Carla', testing, 'c++', embedded),
            p('Dana', design, javascript, data)
        ]),
        dana_design_non_java_fails),
    require_test(
        \+ clue(7, [
            p('Alex', development, python, 'AI'),
            p('Ben', design, javascript, web),
            p('Carla', testing, 'c++', embedded),
            p('Dana', research, java, data)
        ]),
        dana_research_java_fails).

test_clue8 :-
    require_test(
        clue(8, [
            p('Alex', development, java, 'AI'),
            p('Ben', design, 'c++', web),
            p('Carla', testing, javascript, embedded),
            p('Dana', research, python, data)
        ]),
        data_in_research_non_javascript_succeeds),
    require_test(
        \+ clue(8, [
            p('Alex', research, python, 'AI'),
            p('Ben', testing, java, web),
            p('Carla', design, 'c++', embedded),
            p('Dana', development, javascript, data)
        ]),
        data_in_development_fails),
    require_test(
        \+ clue(8, [
            p('Alex', development, python, 'AI'),
            p('Ben', design, java, web),
            p('Carla', testing, 'c++', embedded),
            p('Dana', research, javascript, data)
        ]),
        data_in_research_javascript_fails).

test_clue9 :-
    require_test(
        clue(9, [
            p('Alex', research, python, web),
            p('Ben', development, java, embedded),
            p('Carla', testing, 'c++', 'AI'),
            p('Dana', design, javascript, data)
        ]),
        ai_in_testing_succeeds),
    require_test(
        \+ clue(9, [
            p('Alex', research, python, web),
            p('Ben', design, java, 'AI'),
            p('Carla', testing, 'c++', embedded),
            p('Dana', development, javascript, data)
        ]),
        ai_in_design_fails),
    require_test(
        \+ clue(9, [
            p('Alex', research, python, 'AI'),
            p('Ben', development, java, web),
            p('Carla', design, 'c++', embedded),
            p('Dana', testing, javascript, data)
        ]),
        ai_in_research_fails).

% Candidate solution count tests

test_count_solutions :-
    require_test(count_solutions([], 13824), empty_active_counts_every_candidate),
    require_test(count_solutions([1], 7776), clue_1_solution_count),
    require_test(count_solutions([2], 7776), clue_2_solution_count),
    require_test(count_solutions([1, 2, 3, 4, 5, 6, 7, 8], 3),
                  all_clues_solution_count).

% Single entry point for the P1 suite

run_p1_tests :-
    test_candidate_generator,
    test_clue1,
    test_clue2,
    test_clue3,
    test_clue4,
    test_clue5,
    test_clue6,
    test_clue7,
    test_clue8,
    test_clue9,
    test_count_solutions.

require_test(Goal, TestName) :-
    (   call(Goal)
    ->  true
    ;   throw(error(test_failed(TestName), _))
    ).
