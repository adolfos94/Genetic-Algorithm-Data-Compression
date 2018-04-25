function r=codInvN(n) 

r=0;
tam=size(n,2);

for i=tam:-1:1
  r=r+n(i)*2.^(tam-i); 
end

%r=a+epsilon*r;