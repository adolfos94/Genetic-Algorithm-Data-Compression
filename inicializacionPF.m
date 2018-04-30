function [strs,tam,bins] = inicializacionPF(m,str,n)

tamPalabra = 3; %% TAMAÑO PALABRA MINIMO

tam = 0;

for i = tamPalabra -1 : m - 1 
    tam = tam + (strlength(str)-i);
end

magn = length(dec2bin(tam));

if(mod(magn,2) ~= 0)
    magn = magn + 1;
end

strs = strings(tam,1);
pos = zeros(tam,1);
bins = zeros(n,magn); 
ptsr = (tam-1).*rand(n,1) + 1;
index = 1;

str = str{1};

for i = tamPalabra:m 
    for j = 1:strlength(str) - i + 1
        strs(index) = str(j:j-1+i);
        pos(index) = index;
        index = index + 1;
    end
end


for i = 1:n
    bins(i,:) = codN(round(ptsr(i)),magn);
end
    