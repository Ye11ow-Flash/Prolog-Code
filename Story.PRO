

person(arthur).
person(burnwell).
person(sam).
person(mary).
person(holder).
person(kylie).
person(lucy).
related_to(kylie,holder,handmaiden).
related_to(lucy,holder,handmaiden).
related_to(mary,holder,daughter).
related_to(arthur,holder,son).
related_to(sam,arthur,friend).
renowned_for(sam,thief).
renowned_for(arthur,gambler).
renowned_for(burnwell,casanova).
has_affair(arthur,kylie).
has_affair(burnwell,mary).

killed_with(kylie,knife).
motive(money,sam).
motive(money,burnwell).
motive(disgrace,arthur).
smeared_in(kylie,blood).
smeared_in(arthur,blood).
smeared_in(burnwell,snow).
smeared_in(coronet,blood).
owns(arthur,gun).
owns(burnwell,knife).
owns(holder,coronet).
wounded_by(arthur,knife).
neutral(holder).
accuses(holder,arthur).
accuses(arthur,sam).
accuses(arthur,burnwell).

suspect(X) :-

person(X),person(Y),X<>Y,
not(neutral(X)),
not(neutral(Y)),
related_to(X,Y,_).

suspect(X) :-

person(X), person(Y),X<>Y,
not(neutral(X)),
not(neutral(Y)),
has_affair(Y,X),suspect(Y).

suspect(X) :-

person(X),
motive(_,X).

suspect(X) :-

person(X),
neutral(Y),
accuses(Y,X).

neutral(X) :-

person(X),
killed_with(X,_).

killer(X) :-

suspect(X),
killed_with(_,Z),
owns(X,Z).

thief(X) :-

suspect(X),
smeared_in(coronet,Z),
smeared_in(X,Z).

thief(X) :-

suspect(X),
renowned_for(X,thief).
