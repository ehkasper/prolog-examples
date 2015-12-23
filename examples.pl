/* 3 */

/* Creating the database */
student(einstein, 3.9, physics).
student(godfrey, 3.8, physics).
student(ford, 4.0, physics).
student(cooper, 4.1, physics).
student(heinzemberg, 4.2, physics).
student(pythagoras, 4.4, math).
student(archymedes, 4.3, math).
student(nash, 3.6, math).
student(lovelace, 3.2, math).
student(lincoln, 2.0, english).
student(jackson, 4.8, english).
student(guevara, 3.7, english).
professor(newton, 85000, physics).
professor(feynmann, 96000, physics).
professor(hofstadter, 58000, physics).
professor(pascal, 55000, math).
professor(turing, 105000, math).
professor(hawking, 135000, physics).
professor(churchill, 100000, english).
course(phy250, 1998, newton).
course(phy250, 1999, newton).
course(phy451, 2000, hawking).
course(phy452, 2000, hawking).
course(phy251, 1999, feynmann).
course(phy450, 2001, feynmann).
course(phy350, 1999, hofstadter).
course(mat107, 1998, pascal).
course(csc324, 2000, turing).
course(mat207, 2000, turing).
course(eng408, 2000, churchill).
enrollment(phy250, 1998, einstein).
enrollment(phy451, 2000, cooper).
enrollment(phy452, 2000, cooper).
enrollment(phy450, 2001, einstein).
enrollment(phy251, 1999, einstein).
enrollment(phy251, 1999, godfrey).
enrollment(phy450, 2001, godfrey).
enrollment(phy250, 1998, godfrey).
enrollment(phy250, 1999, godfrey).
enrollment(phy250, 1998, ford).
enrollment(phy350, 1999, ford).
enrollment(phy350, 1999, cooper).
enrollment(phy251, 1999, cooper).
enrollment(phy250, 1998, heinzemberg).
enrollment(phy350, 1999, heinzemberg).
enrollment(csc324, 2000, pythagoras).
enrollment(mat107, 1998, pythagoras).
enrollment(mat207, 2000, pythagoras).
enrollment(mat107, 1998, archymedes).
enrollment(mat207, 2000, archymedes).
enrollment(mat207, 2000, einstein).
enrollment(mat207, 2000, nash).
enrollment(mat207, 2000, nash).
enrollment(mat107, 1998, lovelace).
enrollment(mat207, 2000, lovelace).
enrollment(eng408, 2000, lincoln).
enrollment(eng408, 2000, jackson).
enrollment(eng408, 2000, guevara).

/* 4 */
/* Exercise 4 can be found in transcript file */

/* 5 */
/* Looking for all students with GDP (X) bigger than 3.8 */
hotshot(Student) :- student(Student, X, _), X > 3.8.

/* Looking for all students with GDP (X) bigger than 3.8 */
taught(Professor, Student) :- enrollment(Course, Y, Student), course(Course, Y, Professor).

/* Looking for offered courses depending on the year and department */
offered(Course, Year, Department) :- course(Course, Year, N), professor(N, _, Department).

/* Tests whether any student in Department1 took a couse in Department2 */
taken(Department1, Department2) :- student(Student, _, Department1),
    enrollment(Course, _, Student),
    course(Course, _, Professor),
    professor(Professor, _, Department2).

/* Never Taken is the opposite of taken */
neverTaken(Department1, Department2) :- not(taken(Department1, Department2)).

/* 6 */
/* Database */
male(romulus).
male(remus).
male(cicero).
male(scipio).
male(julius).
male(jake).
male(augustus).
male(mark).
male(caligula).
male(drussus).
male(nero).
male(germanicus).
male(claudius).

female(linda).
female(debora).
female(christine).
female(sarah).
female(livia).
female(lindsay).
female(anna).
female(agripina).
female(messalina).

parent(romulus, cicero).
parent(linda, cicero).
parent(romulus, scipio).
parent(debora, scipio).
parent(remus, gee).
parent(messalina, gee).

parent(scipio, julius).
parent(christine, julius).
parent(scipio, augustus).
parent(christine, augustus).
parent(sarah, livia).
parent(cicero, livia).

parent(julius, caligula).
parent(lindsay, caligula).
parent(julius, drussus).
parent(agripina, drussus).
parent(augustus, nero).
parent(agripina, nero).
parent(livia, germanicus).
parent(mark, germanicus).
parent(livia, claudius).
parent(mark, claudius).

/* b) */
/* Sibling is any person with same parents or at least one equal parent (half sibling) */
sibling(X,Y) :- parent(Z, X), parent(Z, Y), X\=Y.
/* Brother is any male sibling */
brother(X,Y) :- (sibling(X, Y), male(X)).

/* Testing grandparents in common for cousin1 */
cousin1(X, Y) :- parent(Parent1, X), sibling(Parent1, Ancle1), parent(Ancle1, Y).

/* Testing great grandparents in common for cousin2 */
cousin2(X,Y) :- parent(Parent1, X), parent(Grandparent1, Parent1), sibling(Grandparent1, Grandparent2), parent(Grandparent2, Parent2), parent(Parent2, Y).

/* Testing grandparents in common for grandchild */
grandchild(X,Y) :- parent(Y, Z), parent(Z, X).

/* c) The inputs for i. ii. iii. and iv can be found in the transcript file */
descendant(X, Y) :- parent(Y, X).
descendant(X, Y) :- parent(Z, X), descendant(Z, Y).

/* 7 */
/* Pattern matching for leaf, red and black trees. Does the recursiveness and sums values up */
/* Returns N with that value */
treeSum(leaf(Y),N) :- N is Y.
treeSum(red(Y,C1,C2),N) :- treeSum(C1,X),treeSum(C2,XX), N is Y + X + XX.
treeSum(black(Y,C1,C2,C3),N) :- treeSum(C1,X),treeSum(C2,XX),treeSum(C3,XXX), N is Y + X + XX + XXX.

/* 8 */
/* 
    Does pattern matching for empty lists
    Does pattern matching for first item in list and returns whether X is an atom (or ML symbol) 
    Tests if first element isnt number nor atom so call leftmost again
    When X is a number call leftmost with cdr so it can 'walk' through the list
*/
leftmost([],[]).
leftmost([X|_],X):- atom(X).
leftmost([Y|_],X):- not(number(Y)),not(atom(Y)),leftmost(Y,X).
leftmost([X|Cdr],Y):- number(X),leftmost(Cdr,Y).

