
domains
name, sex, occupation, object, vice = symbol
age=integer

predicates
person(name, age, sex, occupation)
had_affair(name, name)
killed_with(name, object)
killed(name)
killer(name)
motive(vice)
owns(name, object)
suspect(name)
works_with(name, name)


/* * * Facts about the murder * * */
clauses
person(stevenson, 51, m, businessman).
person(alexander_holder, 50, m, businessman).
person(burnwell, 24, m, vendor).
person(mary, 22, f, doctor).
person(albert, 48, m, manager).
person(arthur, 23, m, football_player).
person(lucy, 22, f, maid).


had_affair(mary, burnwell).

killed_with(stevenson, gun).
killed_with(albert, knife).
killed(stevenson).
killed(arthur).

motive(revenge).
motive(jealousy).

owns(alexander_holder, pistol).
owns(burnwell, knife).
owns(albert, pistol).

works_with(stevenson, albert) .
works_with(stevenson, alexander_holder) .


/* * * * * * * * * * * * * * * * * * * * * * *
* Suspect all those who own a weapon with *
* which Susan could have been killed. *
* * * * * * * * * * * * * * * * * * * * * * */

suspect(X) :-
killed_with(stevenson, weapon) ,
motive(jealousy) ,
person(X, _, _, businessman) ,
owns(X, pistol) ,
works_with(stevenson, X) .

/* * * * * * * * * * * * * * * * * * * * * * * * * *
* Suspect men who would have killed stevenson. *
* * * * * * * * * * * * * * * * * * * * * * * * * */


/* * * * * * * * * * * * * * * * * * * * *
* Suspect males who have had an *
* affair with mary. *
* * * * * * * * * * * * * * * * * * * * */

suspect(X) :-
motive(revenge) ,
person(X, _, m, _) ,
had_affair(mary, X).

suspect(X) :-
motive(revenge) ,
person(X, _, f, _) ,
had_affair(X, burnwell).

/* * * * * * * * * * * * * * * * * * * * * * * * * * *
* Suspect pickpockets whose motive could be money. *
* * * * * * * * * * * * * * * * * * * * * * * * * * */

killer(Killer) :-
person(Killer, _, _, _) ,
killed(Killed) ,
Killed <> Killer ,
suspect(Killer) .