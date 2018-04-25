function [v1,v2]=cruza(a,b) 
n=fix(max(size(a))/2); 
v1=[a(1:n) b(n+1:end)]; 
v2=[b(1:n) a(n+1:end)];