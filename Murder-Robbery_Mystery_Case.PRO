domains
	name, sex, occupation, object, vice, crime = symbol

predicates
  characters(name, sex, occupation)
  is_in_relationship_with(name, name)
  killed_with(name, object)
  victim(name)
  culprit(name, crime)
  reason(vice)
  owns(name, object)
  operates_identically(object, object)
  owns_probably(name, object)
  suspect(name)
  crime(crime)
  filterSuspect(name)
  filter2Suspect(name)
  suspectRobbery(name)
 /* culpritRobbery(name) */

/* * * Facts about the murder * * */
clauses
characters(alexander, m, banker).
characters(arthur, m, jobless).
characters(mary, f, cricketer).
characters(lucy, f, maid).

characters(francis, m, grocer).
characters(george, m, gambler).

crime(robbery).
crime(murder).

is_in_relationship_with(mary, george).
is_in_relationship_with(lucy, francis).

killed_with(lucy, blunt_weapon).
victim(lucy).

reason(money).
reason(jealousy).
reason(caught_by).
reason(righteousness).

owns(francis, wooden_leg).
owns(banker, pistol).
owns(arthur, knife).

/* * * Background knowledge * * */

operates_identically(wooden_leg, blunt_weapon).
operates_identically(bat, blunt_weapon).
operates_identically(knife, sharp_weapon).
operates_identically(pistol, firearm).
operates_identically(broom, blunt_weapon).

owns_probably(X, bat) :-
	characters(X, _, cricketer).
owns_probably(X, broom) :-
	characters(X, _, maid).
owns_probably(X, Object) :-
	owns(X, Object).

/* * * * * * * * * * * * * * * * * * * * * * *
* Suspect all those who own a weapon with *
* which Susan could have been killed. *
* * * * * * * * * * * * * * * * * * * * * * */

suspect(X) :-
  killed_with(lucy, Weapon) ,
  operates_identically(Object, Weapon) ,
  owns_probably(X, Object).

/* * * * * * * * * * * * * * * * * * * * * * * * * * *
* Suspect gamblers and jobless whose reason could be money. *
* * * * * * * * * * * * * * * * * * * * * * * * * * */

suspectRobbery(X) :-
	reason(money) , characters(X, _,  gambler); reason(money) , characters(X, _, jobless).

/* * * * * * * * * * * * * * * * * * * * * * * * * * *
* Unsuspect people who is lover of lucy as they will not kill her*
* * * * * * * * * * * * * * * * * * * * * * * * * * */

filterSuspect(X):-
	suspect(X),
	victim(Y),
	not(is_in_relationship_with(Y, X)).

/* * * * * * * * * * * * * * * * * * * * * * * * * * *
* Unsuspect people who didn’t own blunt weapon*
* * * * * * * * * * * * * * * * * * * * * * * * * * */

filter2Suspect(X):-
	filterSuspect(X),
	killed_with(lucy, Weapon) ,
	operates_identically(Object, Weapon) ,
	owns_probably(X, Object).
  
culprit(Culprit , murder):-
  characters(Culprit, _, _) ,
  victim(X) ,
  X <> Culprit , /* It is not a suicide */
  filter2Suspect(Culprit) ,
  crime(murder) .
  
  
culprit(Culprit, robbery):-
  characters(Culprit, _, _) ,
  suspectRobbery(Culprit) ,
  is_in_relationship_with(X,Culprit),
  culprit(X, murder) ,
  crime(robbery).
  
