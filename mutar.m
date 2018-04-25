function puntos = mutar(puntos, n)
total=size(puntos,1); 
ind=fix(rand(fix(n*total),1))+1;

for i=1:size(ind,1)
    puntos(ind(i),:)=mutacion(puntos(ind(i),:),4);
end