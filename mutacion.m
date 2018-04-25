function r=mutacion(a,num) 
n=fix(max(size(a))/2); 
ind=fix(n*rand(num,1))+1; 
r=a;
r(ind)=~a(ind);