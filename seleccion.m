function r=seleccion(A, bins,strs,tam) 
y=evaluacionN(A,bins,strs,tam); 
[ys,pys]=sort(y,'descend'); 
r=pys(1:size(bins,1)/2);