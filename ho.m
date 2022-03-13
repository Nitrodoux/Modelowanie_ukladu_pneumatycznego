function y = ho(t)
to=0.05; %czas opoznienia zaworu, s 
if (t<to)
    y=1;
else
    y=0; 
end;
