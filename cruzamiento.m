function pts=cruzamiento(puntos) 
ptshijos=zeros(size(puntos)); 
for i=1:max(size(puntos))-1
    [a,b]=cruza(puntos(i,:),puntos(i+1,:));
    ptshijos(i,:)=a;
end
[a,b]=cruza(puntos(end,:),puntos(1,:));
ptshijos(end,:)=a; 
pts=[puntos;ptshijos];