N=input('Introduce número de muestras ');
Ancho=input('Introduce el intervalo a integrar ');
M_Debajo=0;
Maximo=tan(Ancho);
for i=1:N
    X=rand(1)*1.5;
    Y=rand(1)*Maximo;
    if Y<tan(X)
        M_Debajo=M_Debajo+1;
    end
end
disp('El valor de la integral es: ')
disp((M_Debajo*Ancho*Maximo)/N);