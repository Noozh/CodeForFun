N=input('Introduce número de muestras ');
Ancho=input('Introduce el intervalo a integrar ');
Sumatorio=0.0;
for i=1:N
  Sumatorio=Sumatorio+tan(rand(1)*Ancho);
end
disp('El valor de la integral es: ')
disp((Ancho*Sumatorio)/N);