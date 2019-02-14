Frogs_MFCCs = readtable('Frogs_MFCCs.csv');
%% 2.1- Visualizar datos y extraer subconjunto binario

%Aislamos las columnas de MFCCs
vector = table2array(Frogs_MFCCs(:,1:22));
%Creamos un vector con etiquetas numericas de la columna genus
vector_2 = double(categorical(Frogs_MFCCs.Genus));

%Buscamos las posiciones que encajan con las etiquetas 3 y 5
%respectivamente (que corresponden a leptodocus y dendrophosus)
index_1 = find (vector_2 == 3); %% Dendro
index_2 = find (vector_2 == 5); %% Lepto

%Cribamos usando las posiciones usadas anteriormente
dendrophosus = vector(index_1,:);
leptodocus = vector(index_2,:);

%Representamos todos los MFCCs para buscar alguno con bimodalidad clara
%(dos modas)
figure ();
for i=1:22
    title(i-1);
    subplot(5,5,i);
    histogram(leptodocus(:,i),'Normalization','pdf');hold on
    histogram(dendrophosus(:,i),'Normalization','pdf');
end

%% 2.2 - Modelar las distribuciones

%Una vez hemos encontrado un buen candidato estimamos los parametros de su
%funcion de densidad de probabilidad para cada especie
leptomedia= mean (leptodocus (:,5));
dendromedia= mean (dendrophosus (:,5));

leptovarianza = var(leptodocus (:,5));
dendrovarianza= var (dendrophosus (:,5));

figure();
x = -1:0.001:1;
%Utilizamos normpdf para estimar las pdf a partir de los parametros de cada
%una (media y varianza) estimados anteriormente y las representamos frente
%a los histogramas para ver si mas o menos coinciden
lepto_pdf = normpdf (x,leptomedia,sqrt(leptovarianza));
dendro_pdf = normpdf (x,dendromedia,sqrt(dendrovarianza));
area(x, lepto_pdf,'FaceColor','green'); hold on;
area(x, dendro_pdf,'FaceColor','yellow');hold on;
histogram(leptodocus(:,5),'Normalization','pdf');hold on;
histogram(dendrophosus(:,5),'Normalization','pdf');

%% 2.3 - Disenar los decisores 

p_x_H0=(1/sqrt(leptovarianza * 2 * pi)) * exp(-(x-leptomedia).^2 /(2* leptovarianza));
p_x_H1=(1/sqrt(dendrovarianza * 2 * pi)) * exp(-(x-dendromedia).^2 /(2* dendrovarianza));

%Sumamos las etiquetas 3 y dividimos entre el total para calcular la
%probabilidad de 3
p_3 = sum(vector_2==3)/length(vector_2);
%Lo mismo con 5
p_5 = sum(vector_2==5)/length(vector_2);

syms x; 

eta_MAP=eval(solve(p_3 * normpdf (x,dendromedia,sqrt(dendrovarianza)) == p_5 *  normpdf (x,leptomedia,sqrt(leptovarianza)),x)); 

%corregir el MAP, tenemos que calcular las apriori, y despues hascer bayes
% p_h0=suma==3/lenght(y);
% y luego con 5

plot([eta_MAP(1),eta_MAP(1)],[0 5],'Color','g','LineStyle','--');

syms x

eta_ML = solve((1/sqrt(dendrovarianza * 2 * pi)) * exp(-(x-dendromedia).^2 /(2* dendrovarianza)) == (1/sqrt(leptovarianza * 2 * pi)) * exp(-(x-leptomedia).^2 /(2* leptovarianza)), x);
plot([eta_ML(1),eta_ML(1)],[0 5],'Color','black','LineStyle','--');
legend ('pdf lepto','pdf dendro','lepto histogram','dendro histogram','MAP threshold', 'ML threshold');

%% 2.4- Curva ROC para evaluar decisores

% Calculamos la probabilidad de falsa alarma y la probabilidad de decision
% para un rango de umbrales entre -1 y 1
umbral = -1:0.05:1 ;
for iu=1:length(umbral)
    PFAs(iu) = int((1/sqrt(leptovarianza * 2 * pi)) * exp(-(x-leptomedia).^2 /(2* leptovarianza)),umbral(iu),inf);
    PDs(iu) = int((1/sqrt(dendrovarianza * 2 * pi)) * exp(-(x-dendromedia).^2 /(2* dendrovarianza)),umbral(iu),inf);
end

PDs = double(PDs);
PFAs = double(PFAs);

%buscamos la posicion del umbral a la que mas se aproxima el umbral de
%nuestro decisor y una vez lo obtenemos evaluamos PDs y PFAs obteniendo el
%punto de operacion
eta_MAP = eta_MAP (1);
eta_ML = double(eta_ML);eta_ML = eta_ML(1);
[~,posmin]=min(abs(eta_ML-umbral));
OP_ML = [PDs(posmin) PFAs(posmin)]; 
[~,posmin]=min(abs(eta_MAP-umbral));
OP_MAP = [PDs(posmin) PFAs(posmin)];

% Probabilidades de error
% P_FA_ML = int((1/sqrt(leptovarianza * 2 * pi)) * exp(-(x-leptomedia).^2 /(2* leptovarianza)),eta_ML,inf);
% P_D_ML = int((1/sqrt(dendrovarianza * 2 * pi)) * exp(-(x-dendromedia).^2 /(2* dendrovarianza)),eta_ML,inf);
% P_M_ML = 1 -P_D_ML;
% 
% P_FA_MAP = int((1/sqrt(leptovarianza * 2 * pi)) * exp(-(x-leptomedia).^2 /(2* leptovarianza)),eta_MAP,inf);
% P_D_MAP = int((1/sqrt(dendrovarianza * 2 * pi)) * exp(-(x-dendromedia).^2 /(2* dendrovarianza)),eta_MAP,inf);
% P_M_MAP = 1 -P_D_MAP;
% 
% perror_ML = p_3 * P_FA_ML + p_5 * P_M_ML; perror_ML = double (perror_ML);
% perror_MAP = p_3 * P_FA_MAP + p_5 * P_M_MAP; perror_MAP = double(perror_MAP);

% Con los puntos de operacion y las PFAs y PDs calculadas pintamos la ROC
figure; plot(PFAs,PDs);hold on;
xlabel('P_{FA}'); ylabel('P_D'); title('Curva ROC'); xlim([-0.01 1]); ylim([0 1.01])
plot(OP_ML(2),OP_ML(1),'r*');
plot(OP_MAP(2),OP_MAP(1),'ro');

legend('ROC','ML','MAP');

%% 2.5- Machine Learning (KNN)

%Aislamos una muestra que sera la que queremos clasificar
example = vector(4949,:);
%Construimos una matriz de etiquetas
tag = [repmat("Lepto",1,270) repmat("Dendro",1,310)];
%Construimos una matriz con los datos de entrenamiento que en este caso son
%todos los disponibles
frogs = [leptodocus;dendrophosus];
%Calculamos la distancia de cada una de las ranas del conjunto de
%entrenamiento con la que queremos clasificar
dist = sum((frogs - example).^2 ,2);
%Ordenamos las distancia de manera ascendente
[~,pos] = sort (dist,'ascend');
k=5;
%Buscamos cual es el valor mas repetido en los k elementos mas cercanos en
%el array de etiquetas
M = mode (tag(pos(1:k)));

