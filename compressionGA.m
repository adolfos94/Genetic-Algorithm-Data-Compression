% Proyecto Final
% Compression mediante AG.
clear all;
close all;
clc;
tic;

% ALFABETO DE SIMBOLOS DE REEMPLAZO

alphRnd = {'º','ª','\','!','1','|','"','@','"'};

%n GENERACIONES
n = 500;
% ELEMENTOS
nrand = 250;

A = "Hugo corre a Lugo y toma jugo torre corre rreerrepollollo perro loro coro repartir coco cosa";

%fileID = fopen('text2.txt','r');
%A = string(fscanf(fileID,'%c'));

fprintf(2,"Texto Original: \n\n\t%s\n",A);

lengthOrg = strlength(A);

C = strsplit(A); % Separacion por palabras

magnitude = getMagnitude(C); % Obtener magnitud

[strs,tam,bins] = inicializacionPF(magnitude,A,nrand);

%Primera solucion max; si quiero minimizar.
%-inf si quiero maximizar

solG = -inf;
solx = 0;

reset = 0;
for i=1:n
    ptsy = evaluacionN(A,bins,strs,tam);
    [sol,p] = max(ptsy);
    if(sol > solG)
        solG = sol;
        solx = strs(codInvN(bins(p,:)));
        charReplace = randseq(1);
        A = strrep(A,solx,charReplace)
        
        fprintf(1,"Generación: %d, num_rep es: (%d), cadena: '%s' -> %s \n",i,solG,solx,charReplace);
        
        solG = 1; % DESCOMENTAR SI QUEREMOS TODAS LAS REPETECIONES
        
        lengthCompressed = strlength(A);
        
        fprintf("Compress Ratio: %0.4f\n",lengthOrg/lengthCompressed);
    else
        reset = reset + 1;
    end
    if(reset >= 0)
        %reset si no cambia la solucion
        C = strsplit(A); % Separacion por palabras
        magnitude = getMagnitude(C); % Obtener magnitud
        [strs,tam,bins] = inicializacionPF(magnitude,A,nrand);
        reset = 0;
        continue;
    end
    indM=seleccion(A, bins,strs,tam);
    bins=bins(indM,:);
    bins=cruzamiento(bins);
    bins=mutar(bins,0.10);
end

timeElapsed = toc;
fprintf('\n The time elapsed is %0.4fs\n',timeElapsed);

function magnitud = getMagnitude(C)
magnitud = 0;
for i=1:length(C)
    if(magnitud < length(C{i}))
        magnitud = length(C{i});
    end
end
end
