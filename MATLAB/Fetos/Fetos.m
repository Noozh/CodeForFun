clear; clc

data=readtable('CTG.csv'); %variableNames=data.Properties.VariableNames;
TEST = table2array(data);
X=table2array(data(:,1:end-1));
y=table2array(data(:,end)); %% Columna de estados fetales
% Discriminamos los fetos que estan bien --> tag 1
X=X(y==2 | y==3,:); y=y(y==2 | y==3); % y=2: estado fetal sospechoso; y=3: estado fetal patológico
x=X(:,11); % usar solo la variable MLTV (mean value of long term variability)

sosp=x(y==2);
patol=x(y==3);

figure();
% histogram(sosp,'Normalization','pdf');hold on;
% histogram(patol,'Normalization','pdf');
%sospechosos es gaussiana y patologicos exponencial

%Estimamos parametros para representar sus pdfs
media_sosp = mean (sosp);
var_sosp = std(sosp)^2;

media_pat = mean (patol);
lambda = 1/media_pat;

x = 0:0.05:30;
sosp_pdf = normpdf(x,media_sosp,sqrt(var_sosp));
pat_pdf = lambda * exp(-lambda * x);

area(x, sosp_pdf,'FaceColor','green','FaceAlpha',.3,'EdgeAlpha',.3); hold on;
area(x, pat_pdf,'FaceColor','yellow','FaceAlpha',.3,'EdgeAlpha',.3);hold on;

% ML
syms x;
p_x_H0=(1/sqrt(var_sosp * 2 * pi)) * exp(-(x-media_sosp).^2 /(2* var_sosp));
p_x_H1=(lambda*exp(-lambda*x));

eta_ML = solve(p_x_H0 == p_x_H1);
eta_ML= double(eta_ML);
plot([eta_ML(1),eta_ML(1)],[0 0.3],'Color','black','LineStyle','--');

% MAP

p_sosp = 295/2126;
p_patol = 176/2126;

eta_MAP=eval(solve(p_sosp*p_x_H0 == p_patol*p_x_H1,x));
eta_MAP=double(eta_MAP);

plot([eta_MAP(1),eta_MAP(1)],[0 0.3],'Color','green','LineStyle','--');
legend('sospechosos','patologicos','ML','MAP');

% ROC

umbral = 0:0.5:30 ;
for iu=1:length(umbral)
    PFAs(iu) = int(p_x_H1,umbral(iu),inf);
    PDs(iu) = int(p_x_H0,umbral(iu),inf);
end

PDs = double(PDs);
PFAs = double(PFAs);

%Puntos de operacion

eta_MAP = eta_MAP (1);
eta_ML = double(eta_ML);eta_ML = eta_ML(1);
[~,posmin]=min(abs(eta_ML-umbral));
OP_ML = [PDs(posmin) PFAs(posmin)]; 
[~,posmin]=min(abs(eta_MAP-umbral));
OP_MAP = [PDs(posmin) PFAs(posmin)];

p_M_ML = 1-OP_ML(1);
p_M_MAP = 1-OP_MAP(1);

figure; plot(PFAs,PDs);hold on;
xlabel('P_{FA}'); ylabel('P_D'); title('Curva ROC'); xlim([-0.01 1]); ylim([0 1.01])
plot(OP_ML(2),OP_ML(1),'r*');
plot(OP_MAP(2),OP_MAP(1),'ro');

legend('ROC','ML','MAP');

P_Mml = 1-OP_ML(1); 

%%%%%%%%%%CALCULO DE PFA Y PD CON DECISOR MAP---(0.0531)-----%%%%%%%%%%%%%%%%%%%%%%%%%
P_Mmap=1-OP_MAP(1);

%CALCULO PERROR
perror_ml= (OP_ML(2))+(P_Mml);
perror_map=(OP_MAP(2)*p_patol)+(P_Mmap*p_sosp);

%knn
example = TEST(57,1:21);
tag = [repmat("Sospechoso",1,295) repmat("Patologico",1,176)];
fetos = [sosp;patol];
dist = sum(sqrt((fetos - example).^2) ,2);
[~,pos] = sort (dist,'ascend');
k=5;
M = mode (tag(pos(1:k)));