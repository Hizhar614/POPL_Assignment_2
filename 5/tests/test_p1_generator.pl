:- prolog_load_context(directory, TestDirectory),
   atom_concat(TestDirectory, '/../code/5_q1.pl', SolutionFile),
   consult(SolutionFile).
:- use_module(library(lists), [permutation/2]).
:- use_module(library(apply), [maplist/2]).

run_generator_tests :-
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

require_test(Goal, TestName) :-
    (   call(Goal)
    ->  true
    ;   throw(error(test_failed(TestName), _))
    ).
