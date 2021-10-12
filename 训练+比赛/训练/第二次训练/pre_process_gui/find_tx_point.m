function [u,v] = find_tx_point(x,y,th)
    u = x*cos(th)-y*sin(th);
    v = x*sin(th)+y*cos(th);
%end find_tx_point