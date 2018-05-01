% Proyecto Final
% Compression mediante AG.
clear all;
close all;
clc;
tic;

% ALFABETO DE SIMBOLOS DE REEMPLAZO

alphRnd = {'!','#','$','%','&','(',')','*','+',',','-','.','/',':',';','<','=','>','¡','¿','?','@','[','\',']','^','_','`','{','|','}','~','¨','ç','\','ª','º','å','∫','œ','æ','€','®','†','¥','ø','π','∂','ƒ','','™','¶','§','∑','©','√','ß'};
indxAlphRnd = 0;
indyAlphRnd = 1;

% TABLA DE RECONSTRUCCION

tableRecon = {};


%n GENERACIONES
n = 600;
% ELEMENTOS
nrand = 400;

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

arrayLengths = [];

for i=1:n
    ptsy = evaluacionN(A,bins,strs,tam);
    [sol,p] = max(ptsy);
    if(sol > solG)
        solG = sol;
        solx = strs(codInvN(bins(p,:)));
        
        indxAlphRnd = (length(alphRnd)-1).*rand(1,1) + 1;
        indyAlphRnd = (length(alphRnd)-1).*rand(1,1) + 1;
        
        charReplace = strcat(alphRnd(round(indxAlphRnd)),alphRnd(round(indyAlphRnd)));
        A = strrep(A,solx,charReplace)
        
        tableRecon = [tableRecon;{solx,charReplace{1}}];
        
        fprintf(1,"Generación: %d, num_rep es: (%d), cadena: %s -> %s \n",i,solG,solx,charReplace{1});
        
        solG = 1; % DESCOMENTAR SI QUEREMOS TODAS LAS REPETECIONES
        
        lengthCompressed = strlength(A) + strlength(solx) + strlength(charReplace{1});
        arrayLengths = [arrayLengths; lengthCompressed];
                
        fprintf("Tamaño Original: %0.4f\nTamaño Comprimido: %0.4f\n",lengthOrg,lengthCompressed);
        fprintf("Compress Ratio: %0.4f\n",lengthOrg/lengthCompressed);
    else
        reset = reset + 1;
    end
    if(reset >= 5)
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

figure;
plot(arrayLengths);
title('Compresión del Texto');
xlabel('Num. de ocurrencias') % x-axis label
ylabel('Data length') % y-axis label

reconText(A,tableRecon)

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


function text = reconText(A,tableRecon)
text = A;
for i=length(tableRecon):-1:1
    text = strrep(text,tableRecon{i,2},tableRecon{i,1});
end
end
