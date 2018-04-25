function pts = evaluacionN(A,bins,strs,tam) 
pts=zeros(max(size(bins)),1);
for i=1:max(size(bins))
    pts(i)=fnEvaluacion(A,codInvN(bins(i,:)),strs,tam);
end

function y = fnEvaluacion(A,num,strs,tam)
% Funcion objetivo
if(num <= tam && num > 0)
y = count(A,strs(num));
else
y = 0;    
end


                                   