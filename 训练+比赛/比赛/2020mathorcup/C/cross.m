function ptasks = cross(ptasks)
personord = randperm(9);
persona = personord(1);
personb = personord(2);
alength = length(ptasks{persona});
blength = length(ptasks{personb});
aoffset = randperm(alength);
afrom = min(aoffset(1), aoffset(2));
ato = max(aoffset(1), aoffset(2));
boffset = randperm(blength);
bfrom = min(boffset(1), boffset(2));
bto = max(boffset(1), boffset(2));
ap = 0;
personanew = [];
personbnew = [];
for i = 1:afrom-1
    ap = ap + 1;
    personanew(ap) = ptasks{persona}(i);
end
for i = bfrom:bto
    ap = ap + 1;
    personanew(ap) = ptasks{personb}(i);
end
for i = ato+1:alength
    ap = ap + 1;
    personanew(ap) = ptasks{persona}(i);
end
bp = 0;
for i = 1:bfrom-1
    bp = bp + 1;
    personbnew(bp) = ptasks{personb}(i);
end
for i = afrom:ato
    bp = bp + 1;
    personbnew(bp) = ptasks{persona}(i);
end
for i = bto+1:blength
    bp = bp + 1;
    personbnew(bp) = ptasks{personb}(i);
end
if length(personanew) < 8 && length(personbnew) < 8 && length(personanew) > 3 && length(personbnew) > 3
    ptasks{persona} = personanew;
    ptasks{personb} = personbnew;
end