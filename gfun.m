%Funkcja wyliczaj¹ca g(p,pj):
function [ y ] = gfun( p,pj )
if pj>p
    y=pj*(pj-p)/(1.13*pj-p);
else
    y=p*(pj-p)/(1.13*p-pj);
end
