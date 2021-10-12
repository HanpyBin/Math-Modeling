function f=adapt(b)
[m,n]=size(b);
m1=m/8;
n1=n/8;
for i=1:m1
   for j=1:n1
      t=mean2(b((i-1)*8+1:(i-1)*8+8,(j-1)*8+1:(j-1)*8+8));
      for k=(i-1)*8+1:(i-1)*8+8
          for l=(j-1)*8+1:(j-1)*8+8
              if b(k,l)<t
                  b(k,l)=1;
              else 
                  b(k,l)=0;
              end
          end
      end
   end
end
for i=1:m
    for j=1:n
        if b(i,j)>1
            b(i,j)=0;
        end
    end
end
for i=1:m
    for j=1:n
        if b(i,j)==1
            for k=1:j
                b(i,k)=1;
            end
            break;
        end
    end
end

for i=1:m
    for j=n:-1:1
        if b(i,j)==1
            for k=n:-1:j
                b(i,k)=1;
            end
            break;
        end
    end
end
%³¹µ×¶þÖµ»¯£»
for i=1:m
    for j=1:n
        if b(i,j)==1
            b(i,j)=0;
        else
            b(i,j)=1;
        end
    end
end

f=b;