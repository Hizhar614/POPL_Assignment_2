:- use_module(library(lists), [permutation/2, member/2]).

candidate_solution([
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

clue(1, Solution) :-
    Solution = [
        p('Alex', _, _, _),
        p('Ben', _, _, _),
        p('Carla', _, _, _),
        p('Dana', _, _, _)
    ],
    member(p(Name, Department, _, 'AI'), Solution),
    dif(Department, research),
    dif(Name, 'Dana').

clue(2, [
    p('Alex', Department, Language, _),
    p('Ben', _, _, _),
    p('Carla', _, _, _),
    p('Dana', _, _, _)
]) :-
    dif(Department, development),
    dif(Language, 'c++').

clue(3, Solution) :-
    Solution = [
        p('Alex', _, _, _),
        p('Ben', _, _, _),
        p('Carla', _, _, _),
        p('Dana', _, _, _)
    ],
    member(p(_, testing, python, _), Solution).

clue(4, [
    p('Alex', _, _, _),
    p('Ben', Department, _, web),
    p('Carla', _, _, _),
    p('Dana', _, _, _)
]) :-
    dif(Department, testing).

clue(5, Solution) :-
    Solution = [
        p('Alex', _, _, _),
        p('Ben', _, _, _),
        p('Carla', _, _, _),
        p('Dana', _, _, _)
    ],
    member(p(_, design, java, _), Solution).

clue(6, [
    p('Alex', _, _, _),
    p('Ben', _, _, _),
    p('Carla', Department, _, Project),
    p('Dana', _, _, _)
]) :-
    dif(Project, embedded),
    dif(Department, development).

clue(7, [
    p('Alex', _, _, _),
    p('Ben', _, _, _),
    p('Carla', _, _, _),
    p('Dana', Department, Language, _)
]) :-
    dif(Language, java),
    (Department = research ; Department = testing).

clue(8, Solution) :-
    Solution = [
        p('Alex', _, _, _),
        p('Ben', _, _, _),
        p('Carla', _, _, _),
        p('Dana', _, _, _)
    ],
    member(p(_, research, Language, data), Solution),
    dif(Language, javascript).

% CLUE 9: The friend who prefers the AI project works in the testing department.
clue(9, Solution) :-
    Solution = [
        p('Alex', _, _, _),
        p('Ben', _, _, _),
        p('Carla', _, _, _),
        p('Dana', _, _, _)
    ],
    member(p(_, testing, _, 'AI'), Solution).

main :-
    candidate_solution(Solution),
    clue(1, Solution),
    clue(2, Solution),
    clue(3, Solution),
    clue(4, Solution),
    clue(5, Solution),
    clue(6, Solution),
    clue(7, Solution),
    clue(8, Solution),
    Solution = [
        p('Alex', AlexDepartment, AlexLanguage, AlexProject),
        p('Ben', BenDepartment, BenLanguage, BenProject),
        p('Carla', CarlaDepartment, CarlaLanguage, CarlaProject),
        p('Dana', DanaDepartment, DanaLanguage, DanaProject)
    ],
    format('Alex = [~a, ~a, ~a]~n',
           [AlexDepartment, AlexLanguage, AlexProject]),
    format('Ben = [~a, ~a, ~a]~n',
           [BenDepartment, BenLanguage, BenProject]),
    format('Carla = [~a, ~a, ~a]~n',
           [CarlaDepartment, CarlaLanguage, CarlaProject]),
    format('Dana = [~a, ~a, ~a]~n',
           [DanaDepartment, DanaLanguage, DanaProject]).

count_solutions(Active, N) :-
    findall(Solution,
            (   candidate_solution(Solution),
                forall(member(ClueNumber, Active),
                       call(clue(ClueNumber, Solution)))
            ),
            Solutions),
    length(Solutions, N).
