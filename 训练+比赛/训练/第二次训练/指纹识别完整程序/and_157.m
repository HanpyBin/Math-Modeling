function result = and_157(x,y,image1);

%p1 & p5 & p7

result = image1(x,y-1) * image1(x,y+1) * image1(x-1,y);


