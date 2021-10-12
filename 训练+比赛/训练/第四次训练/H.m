function z = H(t)
D = 12 / 60;
MAXT = 1/3;
if t < D
    z = 2;
else
    z = (1-(t-D)/(MAXT-D))^2+1;
end