%Zbiorniki
Vz1p=0.08; %objetosc zbiornika zasilaj¹cego, m^3;
Vz2p=0.06; %objetosc zbiornika zasilaj¹cego, m^3;
%Rozgaleziacze
Vw1p=1e-6; %objetosc rozgaleziacza 1, m^3
Vw2p=1e-6; %objetosc rozgaleziacza 2, m^3
Vw3p=2*1e-6; %objetosc rozgaleziacza 3, m^3
%Przewody
l(1)=20; d(1)=0.008; mu(1)=0.197410;
l(2)=2;  d(2)=0.008; mu(2)=0.226910;
l(3)=1;  d(3)=0.006; mu(3)=0.338910;
l(4)=2; d(4)=0.006; mu(4)=0.308800;
l(5)=3; d(5)=0.008; mu(5)=0.214330;
l(6)=5;  d(6)=0.012; mu(6)=0.109930;
l(7)=10; d(7)=0.006; mu(7)=0.255550;
l(8)=1;  d(8)=0.006; mu(8)=0.248350;
l(9)=3; d(9)=0.009; mu(9)=0.225170;

%Si³owniki membranowe S1 S2 S3
D1=0.145; %wiêksza srednica membrany [m]
D2=0.114; %mniejsza srednica membrany [m]
s=0.02; %skok trzpienia [m]
m=0.75; %masa czesci ruchomch [kg]
V0kp=1e-5; %objetosc poczatkowa [m^3]
c=21500; %sztywnosc sprezyny [N/m]
cs=1e9; %sztywnosc scianek [N/m]
bs=1e5; %t³umienie scianek [Ns/m]
Pconst=10; %sta³a si³a obci¹¿aj¹ca [N]

%Si³owniki membranowe S4 S5
D12=0.290; %wiêksza srednica membrany [m]
D22=0.228; %mniejsza srednica membrany [m]
s2=0.06; %skok trzpienia [m]
m2=1.2; %masa czesci ruchomch [kg]
V0kp2=4*1e-5; %objetosc poczatkowa [m^3]
c2=42500; %sztywnosc sprezyny [n/m]
cs2=1e9; %sztywnosc scianek [n/m]
bs2=1e5; %t³umienie scianek [ns/m]
Pconst2=500; %sta³a si³a obci¹¿aj¹ca [N]

%Pole efektywne membrany
Fe=pi/12*(D1^2+D1*D2+D2^2);
Fe2=pi/12*(D12^2+D12*D22+D22^2);
%Pozosta³e paramtery
T=293;  %Temperatura powietrza
R=287.14; %sta³a gazowa, J/(kg*K)
kap=1.4; %wyk³adnik adiabaty
pa=1e5; %ciœnienie atmosferyczne, Pa
%Obliczanie przewodnoœci oraz objetoœci przewodników
for n=1:9
    fe(n)=mu(n)*pi*d(n)^2/4;
    a(n)=0.654*fe(n)*sqrt(R*T*kap^3);
    Vr(n)=pi*l(n)*d(n)^2/4;
end;
%Objêtoœci komór
V(1)=Vr(1)/3;
V(2)=Vr(2);
V(3)=Vr(3);
V(4)=Vr(4);
V(5)=Vr(5)/3;
V(6)=Vr(6);
V(7)=Vr(7)/5;
V(8)=Vr(8)/2;
V(9)=Vr(9)/2;
Vz(1)=Vz1p+V(1)+V(6); Vz(2)=Vz2p+V(7)+V(6);
Vw1=Vw1p+V(1)+V(2)+V(3); Vw2=Vw2p+V(2)+V(4)+V(5);
Vw3=Vw3p+V(7)+V(8)+V(9);
V0k(1)=V0kp+V(4);
V0k(2)=V0kp+V(5);
V0k(3)=V0kp+V(3);
V0k(4)=V0kp;
V0k(5)=V0kp+V(9);
%Warunki pocz¹tkowe
pz01=8e5;
pz02=8e5;
p06=8e5;
p0=1e5;
xk0s1=0;
xk0s2=0.06;
x0=[pz01; p0; p0; p0; p0; p0; p0; p0; p0; p0; p06; pz02; p06; p06; p06; p06; p06; p06; p06;  p0; p0; p0; p06; p06;
    0;0;0;0.06;0.06; %przemieszczenia
    0;0;0;0;0]; %prêdkoœci
tfinal=4; %czas trwania symulacji
dt=0.01; %krok obliczen
options=odeset('AbsTol',1e-3,'RelTol',1e-3);
[t,x]=ode23s(@mup_02_odefun,[0:dt:tfinal],x0,options,a, V, V0k,Fe,Fe2,Pconst,m,c,s,cs,bs,Pconst2,m2,c2,s2,cs2,bs2, Vz,Vw1,Vw2,Vw3,pa,kap);
figure(1);
plot(t,x(:,1)*1e-3,'k',t,x(:,12)*1e-3,'b--');
grid;
axis([0 tfinal 0 900])
xlabel('t [s]');
ylabel('p [kPa]');
legend('p_{z1}','p_{z2}');
title('Ciœnienie w ziornikach z1 i z2')
figure(2)
plot(t,x(:,20)*1e-3,'k',t,x(:,21)*1e-3,'b', t,x(:,22)*1e-3,'r')
xlabel('t [s]');
ylabel('p [kPa]');
legend('p_{k1}','p_{k2}','p_{k3}');
title('Ciœnienie w si³ownikach S1, S2 i S3')
figure(3)
plot(t,x(:,23)*1e-3,'b--',t,x(:,24)*1e-3,'k')
xlabel('t [s]');
ylabel('p [kPa]');
legend('p_{k4}','p_{k5}');
title('Ciœnienie w si³ownikach S4 i S5')
axis([0 tfinal 0 900])
figure(4);
plot(t,x(:,25)*1e3,'b--',t,x(:,26)*1e3,'k',t,x(:,27)*1e3,'r--',t,x(:,28)*1e3,'g', t,x(:,29)*1e3,'y');
xlabel('t [s]');
ylabel('x [mm]');
title('Wartoœæ przemieszczenia trzpienia w si³ownikach S1, S2, S3,  S4 i S5')
legend('p_{k1}','p_{k2}','p_{k3}','p_{k4}','p_{k5}');