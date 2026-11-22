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
