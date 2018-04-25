function r=codN(num,m)
    r=zeros(1,m);
    
    for i=m:-1:1
        r(i)=mod(num,2);
        num=fix(num./2);
    end
end