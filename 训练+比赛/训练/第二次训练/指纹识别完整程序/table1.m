function result = table1(x,y,input);
%cauculate inputdex table
result = input(x-1,y-1)+input(x,y-1) * 2+input(x+1,y-1) * 4+input(x+1,y) * 8+input(x+1,y+1) * 16+input(x,y+1) * 32+input(x-1,y+1) * 64 + input(x-1,y) * 128;