function result = and_357(x,y,image1);

% p3 & p5 & p7

result = image1(x+1,y) * image1(x,y+1) * image1(x-1,y);
