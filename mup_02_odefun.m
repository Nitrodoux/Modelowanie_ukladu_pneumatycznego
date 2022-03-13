function [xd] = mup_02_odefun( t, x, a, V, V0k,Fe,Fe2,Pconst,m,c,s,cs,bs,Pconst2,m2,c2,s2,cs2,bs2, Vz,Vw1,Vw2,Vw3,pa,kap)
%zbiornik Zb1
xd(1,1)=(a(1)*hd(t)*gfun(x(1),x(2))+a(6)*hd(t)*gfun(x(1),x(11)))/Vz(1);
%przewod l1 i zawór 1
xd(2,1)=a(1)*(hd(t)*gfun(x(2),x(1))+ho(t)*gfun(x(2),pa)+gfun(x(2),x(3)))/V(1);
xd(3,1)=a(1)*(gfun(x(3),x(2))+gfun(x(3),x(4)))/V(1);
xd(4,1)=a(1)*(gfun(x(4),x(3))+gfun(x(4),x(5)))/V(1);
%rozgaleziacz w1
xd(5,1)=(a(1)*gfun(x(5),x(4))+a(2)*gfun(x(5),x(6))+a(3)*gfun(x(5),x(7)))/Vw1;
%przewod l2
xd(6,1)=a(2)*(gfun(x(6),x(5))+gfun(x(6),x(8)))/V(2);
%przewod l3
xd(7,1)=a(3)*(gfun(x(7),x(5))+gfun(x(7),x(22)))/V(3);
%rozgaleziacz w2
xd(8,1)=(a(2)*gfun(x(8),x(6))+a(4)*gfun(x(8),x(9))+a(5)*gfun(x(8),x(10)))/Vw2;
%przewod l4
xd(9,1)=a(4)*(gfun(x(9),x(8))+gfun(x(9),x(20)))/V(4);
%przewod l5 
xd(10,1)=a(5)*(gfun(x(10),x(8))+gfun(x(10),x(21)))/V(5);
%przewód l6
xd(11,1) =a(6)*(gfun(x(11),x(1))+gfun(x(12),x(11)))/V(6);
%zbiornik zb2
xd(12,1)=(a(7)*hd(t)*gfun(x(12),x(13))+a(6)*ho(t)*gfun(x(1),x(11)))/Vz(2);
%Przewod l7 i zawór 1
xd(13,1)=a(7)*(hd(t)*gfun(x(13),x(12))+ho(t)*gfun(x(13),pa)+gfun(x(13),x(14)))/V(7);
xd(14,1)=a(7)*(gfun(x(14),x(13))+gfun(x(14),x(15)))/V(7);
xd(15,1)=a(7)*(gfun(x(15),x(14))+gfun(x(15),x(16)))/V(7);
%rozgaleziacz w3
xd(16,1)=(a(7)*gfun(x(16),x(15))+a(9)*gfun(x(16),x(17))+a(8)*gfun(x(16),x(28)))/Vw3;
%przewód  l9
xd(17,1)=a(9)*(gfun(x(17),x(16))+gfun(x(16),x(18)))/V(9);
xd(18,1)=a(9)*(gfun(x(18),x(17))+gfun(x(18),x(29)))/V(9);
%przewód l8
xd(19,1)=0;
%si³owniki
xd(20,1)=(a(4)*gfun(x(20),x(9))-Fe*kap*x(20)*x(30))/(Fe*x(25)+V0k(1));
xd(21,1)=(a(5)*gfun(x(21),x(10))-Fe*kap*x(21)*x(31))/(Fe*x(26)+V0k(2));
xd(22,1)=(a(3)*gfun(x(22),x(7))-Fe*kap*x(22)*x(32))/(Fe*x(27)+V0k(3));
xd(23,1)=(a(8)*gfun(x(23),x(19))-Fe2*kap*x(23)*x(33))/(Fe2*x(28)+V0k(4));
xd(24,1)=(a(9)*gfun(x(24),x(18))-Fe2*kap*x(24)*x(34))/(Fe2*x(29)+V0k(5));
% Prêdkoœci trzpieni
xd(25,1)=x(30);
xd(26,1)=x(31);
xd(27,1)=x(32);
xd(28,1)=x(33);
xd(29,1)=x(34);

% Równania ruchu trzpieni
xd(30,1)=((x(20)-pa)*Fe-Pconst-c*x(25));
if x(25)<=0
    xd(30,1)=xd(30,1)-cs*x(25)-bs*x(30);
elseif x(25)>=s
    xd(30,1)=xd(30,1)-cs*(x(25)-s)-bs*x(30);
end;
xd(30,1)=xd(30,1)/m;

xd(31,1)=((x(21)-pa)*Fe-Pconst-c*x(26));
if x(26)<=0
    xd(31,1)=xd(31,1)-cs*x(26)-bs*x(31);
elseif x(26)>=s
    xd(31,1)=xd(31,1)-cs*(x(26)-s)-bs*x(31);
end;
xd(31,1)=xd(31,1)/m;

xd(32,1)=((x(22)-pa)*Fe-Pconst-c*x(27));
if x(27)<=0
    xd(32,1)=xd(32,1)-cs*x(27)-bs*x(32);
elseif x(27)>=s
    xd(32,1)=xd(32,1)-cs*(x(27)-s)-bs*x(32);
end;
xd(32,1)=xd(32,1)/m;

xd(33,1)=((x(23)-pa)*Fe2-Pconst2-c2*x(28));
if x(28)<=0
    xd(33,1)=xd(33,1)-cs2*x(28)-bs2*x(33);
elseif x(28)>=s2
    xd(33,1)=xd(33,1)-cs2*(x(28)-s2)-bs2*x(33);
end;
xd(33,1)=xd(33,1)/m2;

xd(34,1)=((x(24)-pa)*Fe2-Pconst2-c2*x(29));
if x(29)<=0
    xd(34,1)=xd(34,1)-cs2*x(29)-bs2*x(34);
elseif x(29)>=s2
    xd(34,1)=xd(34,1)-cs2*(x(29)-s2)-bs2*x(34);
end;
xd(34,1)=xd(34,1)/m2;

