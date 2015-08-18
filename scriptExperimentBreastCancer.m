%% Breast cancer experiment, two kernel sample test
% reading data set
clear
clc
[X,XX]=fuzzyDataBreastCancer(1:100);

expResults=zeros(22,2);

% Experiments
addpath ./kernels

% level of the test
alph=0.05;
%number of samples
m=25;
%number of shuffles for boostrap
shuff=300;
%number of tests
nTest=100;
%number of epochs for statistics
nroEpoch=500;
%variables with final statistics
% i=1  samples from two different distributions
% i=2  samples from the same distribution
expCont=1;

matrixResults=cell(1,22)
%STAT1 = p=q STAT2 = p~=q

%-----------------------------------------------------------
%EXPERIMENTS WITH INTERSECTION FUZZY KERNEL AND RBF KERNEL
%-----------------------------------------------------------

%First Experiment
%-------------------------------------------------------------------------
for i=1:2
    % Each fuzzy variable (set) has its own fuzzy intersection kernel, for the rest of crisp
    % variables a RBF with parameter given by the median heuristic is computed
    %
    [STAT1, STAT2]=firstExperiment(alph,m,shuff,nTest,nroEpoch,X,i)
    matrixResults{expCont}= [STAT1 ,STAT2];
    expResults(expCont,:)=[mean(STAT1) , mean(STAT2)];
    expCont=expCont+1;
end

disp('first experiment finished')

%Second Experiment
%-------------------------------------------------------------------------
for i=1:2
    % It is computed a RBF kernel  with parameter given by the median heuristic
    %over the crisp version X of the fuzzy dataset XX
    %
    [STAT1, STAT2]=secondExperiment(alph,m,shuff,nTest,nroEpoch,XX,i)
    matrixResults{expCont}= [STAT1, STAT2];
    expResults(expCont,:)=[mean(STAT1) , mean(STAT2)];
    expCont=expCont+1;
end

disp('second experiment finished')

%Third Experiment
%-------------------------------------------------------------------------
for i=1:2
    % Each fuzzy variable (set) has its own fuzzy intersection kernel, each
    % crisp dimension has its own RBF kernel, sharing the same kernel parameter
    % given by the median heuristic over the crisp variables
    %
    [STAT1, STAT2]=thirdExperiment(alph,m,shuff,nTest,nroEpoch,X,i)
    matrixResults{expCont}= [STAT1, STAT2];
    expResults(expCont,:)=[mean(STAT1) , mean(STAT2)];
    expCont=expCont+1;
end

disp('third experiment finished')

%Fourth Experiment
%-------------------------------------------------------------------------
for i=1:2
    % The same than the third experiment but each RBF kernel has its own kernel
    % parameter given by the median heuristic
    
    [STAT1 ,STAT2]=fourthExperiment(alph,m,shuff,nTest,nroEpoch,X,i)
    matrixResults{expCont}= [STAT1 ,STAT2];
    expResults(expCont,:)=[mean(STAT1) , mean(STAT2)];
    expCont=expCont+1;
end

disp('fourth experiment finished')
    

%Fifth Experiment
%-------------------------------------------------------------------------
for i=1:2
    % each dimension is considered with a rbf kernel with its own
    % kernel parameter
    
    [STAT1, STAT2]=fifthExperiment(alph,m,shuff,nTest,nroEpoch,XX,i)
    matrixResults{expCont}= [STAT1, STAT2];
    expResults(expCont,:)=[mean(STAT1) , mean(STAT2)];
    expCont=expCont+1;
end

disp('fifth experiment finished')

%--------------------------------------------------------------
%EXPERIMENTS WITH INTERSECTION FUZZY KERNEL AND LINELAR KERNEL
%--------------------------------------------------------------
%Sixth Experiment
%-------------------------------------------------------------------------
for i=1:2
    % Each fuzzy variable (set) has its own fuzzy intersection kernel, for the rest of crisp
    % variables a linear kernel is computed
    %
    
    [STAT1, STAT2]=sixthExperiment(alph,m,shuff,nTest,nroEpoch,X,i)
    matrixResults{expCont}= [STAT1, STAT2];
    expResults(expCont,:)=[mean(STAT1) , mean(STAT2)];
    expCont=expCont+1;
end

disp('sixth experiment finished')

%Seventh Experiment
%-------------------------------------------------------------------------
for i=1:2
    % It is computed a linear kernel
    %over the crisp version X of the fuzzy dataset XX
    %
    
    [STAT1, STAT2]=seventhExperiment(alph,m,shuff,nTest,nroEpoch,XX,i)
    matrixResults{expCont}= [STAT1 ,STAT2];
    expResults(expCont,:)=[mean(STAT1) , mean(STAT2)];
    expCont=expCont+1;
end

disp('seventh experiment finished')

%Eighth Experiment
%-------------------------------------------------------------------------
for i=1:2
    % a linear kernel by dimension
    
    [STAT1, STAT2]=eighthExperiment(alph,m,shuff,nTest,nroEpoch,XX,i)
    matrixResults{expCont}= [STAT1 ,STAT2];
    expResults(expCont,:)=[mean(STAT1) , mean(STAT2)];
    expCont=expCont+1;
end

disp('eighth experiment finished')

%--------------------------------------------------------------------
%EXPERIMENTS WITH  FUZZY DISTANCE SUBSTITUTION KERNEL AND RBF KERNEL
%--------------------------------------------------------------------

%Ninth Experiment
%-------------------------------------------------------------------------
for i=1:2
    % Each fuzzy variable (set) has its own fuzzy distance substitution  kernel, for the rest of crisp
    % variables a RBF with parameter given by the median heuristic is computed,
    % this same parameter is given for the fuzzy kernel
    %
    [STAT1, STAT2]=ninthExperiment(alph,m,shuff,nTest,nroEpoch,X,i)
    matrixResults{expCont}= [STAT1, STAT2];
    expResults(expCont,:)=[mean(STAT1) , mean(STAT2)];
    expCont=expCont+1;
end

disp('ninth experiment finished')


%Tenth Experiment
%-------------------------------------------------------------------------
for i=1:2
    % Each fuzzy variable (set) has its own fuzzy distance substitution
    % kernel,each crisp variable has its own RBF kernel,
    % all the kernel parameters were computed using the median heuristic over
    % the crisp dataset
    [STAT1 ,STAT2]=tenthExperiment(alph,m,shuff,nTest,nroEpoch,X,i)
    matrixResults{expCont}= [STAT1, STAT2];
    expResults(expCont,:)=[mean(STAT1) , mean(STAT2)];
    expCont=expCont+1;
end

disp('tenth experiment finished')

%Eleventh Experiment
%-------------------------------------------------------------------------
for i=1:2
    % Same as the sixth experiment bu each crisp dimension has its own
    % linear kernel
    
    [STAT1 ,STAT2]=eleventhExperiment(alph,m,shuff,nTest,nroEpoch,X,i)
    matrixResults{expCont}= [STAT1, STAT2];
    expResults(expCont,:)=[mean(STAT1) , mean(STAT2)];
    expCont=expCont+1;
end

disp('eleventh experiment finished')



% resultsExperimentBreastCancer005.mat is the results with the following
% parameters:
% m=25;
% %number of shuffles for boostrap
% shuff=300;
% %number of tests
% nTest=100;
% %number of epochs for statistics
% nroEpoch=250;

save resultsExperimentBreastCancer005_500.mat

M=cell2mat(matrixResults);
MAlt=M(:,2:4:end);
MNull=M(:,3:4:end);
ind = [7 2 6 1 9];

%results of the paper
mean(MAlt(:,ind))
mean(MNull(:,ind))

%plots statistics
figure
%boxplot(100-MAlt(:,ind),'labels',{'k_{lin}','k_{RBF}','k_{\cap}+k_{lin}','k_{\cap}+k_{RBF}','k_D+k_{RBF}'},'labelorientation','horizontal');           %ACC
boxplot(100-MAlt(:,ind),'labels',{'','','','',''},'labelorientation','horizontal');           %ACC
ylabel('ACC')
h = findobj(gca, 'type', 'text');
set(h, 'Interpreter', 'tex');
%title ('Type II Error')
title ('Erro Tipo II')


figure
%boxplot(100-MNull(:,ind),'labels',{'k_{lin}','k_{RBF}','k_{\cap}+k_{lin}','k_{\cap}+k_{RBF}','k_D+k_{RBF}'},'labelorientation','horizontal');               %AUC
boxplot(100-MNull(:,ind),'labels',{'','','','',''},'labelorientation','horizontal');               %AUC
ylabel('AUC')
h = findobj(gca, 'type', 'text');
set(h, 'Interpreter', 'tex');
%title ('Type I Error')
title ('Erro Tipo I')





%% Experiment on computational time
% As the fourth and fifth experimental settings give us better accuracy, we
% test the time of the two methods, and the number of samples used to form
% the fuzzy sets.

% level of the test
alph=0.5;
%number of samples
m=25;
%number of shuffles for boostrap
shuff=300;
%number of tests
nTest=100;
%number of epochs for statistics
nroEpoch=30;
%variables with final statistics
nRep=30;
tElapsed1=zeros(nRep,1);
tElapsed2=zeros(nRep,1);
accTemp1=zeros(nRep,1);
accTemp2=zeros(nRep,1);
t1=zeros(10,1);
t2=zeros(10,1);
acc1=zeros(10,1);
acc2=zeros(10,1);


for i=1:10
    i
    sample{i}=1:i:100;
    [X,XX]=fuzzyDataBreastCancer(sample{i});
    for j=1:nRep
        tStart=tic;
        [~,STAT2]=fourthExperiment(alph,m,shuff,nTest,nroEpoch,X);
        tElapsed1(j)=toc(tStart);
        accTemp1(j)=STAT2;
        
        tStart=tic;
        [~,STAT2]=fifthExperiment(alph,m,shuff,nTest,nroEpoch,XX);
        tElapsed2(j)=toc(tStart);
        accTemp2(j)=STAT2;
    end
    t1(i)=mean(tElapsed1);
    acc1(i)=mean(accTemp1);
    t2(i)=mean(tElapsed2);
    acc2(i)=mean(accTemp2);
end

% and the results were:
%t1 = [ 90.6993   82.4548   80.3261   81.7797   80.4408   79.9777   81.6611   79.3604   78.3363   76.4293];
%t2 = [ 74.0321   71.6431   71.8362   71.9569   71.9732   72.3695   72.1359   71.4622   71.1072   70.6980];
%plot(t1); hold on
%plot(t2,'r')



% conclusion there is no statistical diferrence in the time between the
% fourth and fifth experiment

%% Experiment, significance level vs type II error

clear
clc
[X,XX]=fuzzyDataBreastCancer(1:100);

expResults=zeros(22,2);

% Experiments
addpath ./kernels

%number of samples
m=25;
%number of shuffles for boostrap
shuff=300;
%number of tests
nTest=100;
%number of epochs for statistics
nroEpoch=250;
%variables with final statistics
% i=1  samples from two different distributions
% i=2  samples from the same distribution
expCont=1;

%STAT1 = p=q STAT2 = p~=q

test=1;
var1=zeros(1,10);
var2=zeros(1,10);
var3=zeros(1,10);
var4=zeros(1,10);
var5=zeros(1,10);
for alph= linspace(0.5, 0.01, 10)
    
    %k_lin
    [STAT1 , ~]=seventhExperiment(alph,m,shuff,nTest,nroEpoch,XX,test);
    var1(expCont)=mean(STAT1);
    
    %k_rbf
    [STAT1 , ~]=secondExperiment(alph,m,shuff,nTest,nroEpoch,XX,test);
    var2(expCont)=mean(STAT1);
    
    %k_intersection+k_lin
    [STAT1 , ~]=sixthExperiment(alph,m,shuff,nTest,nroEpoch,X,test);
    var3(expCont)=mean(STAT1);
    
    %k_intersection+k_rbf
    [STAT1 , ~]=firstExperiment(alph,m,shuff,nTest,nroEpoch,X,test);
    var4(expCont)=mean(STAT1);
    
    %k_D+k_rbf
    [STAT1 , ~]=ninthExperiment(alph,m,shuff,nTest,nroEpoch,X,test);
    var5(expCont)=mean(STAT1);
    
    expCont=expCont+1;
end

save alphavdTypeIIError.mat
load('alphavdTypeIIError.mat')
alph= linspace(0.5, 0.01, 10)
colors=['-b'; '-g' ;'-r'; '-c'; '-m'; '-y'; '-k'; '-b'; '-g']

plot(alph, var1,colors(1,:),'LineWidth',3)
hold on
plot(alph,var2,colors(2,:),'LineWidth',3)
plot(alph,var3,colors(3,:),'LineWidth',3)
plot(alph,var4,colors(4,:),'LineWidth',3)
plot(alph,var5,colors(5,:),'LineWidth',3)
title('Nivel de significância vs o Erro do Tipo II')
xlabel('Nivel de significância \alpha') % x-axis label
ylabel('Erro tipo II') % y-axis label
legend('k_{lin}','k_{RBF}','k_{\cap}+k_{lin}','k_{\cap}+k_{RBF}','k_D+k_{RBF}','Location','eastoutside','Orientation','vertical')
set(gca,'fontsize',25)



%% kernel selection strategy:
%is a feature selection problem
% focus in probçems that benefit from careful kernel choice

%first experiment:  wich kernel in the family of K={k; k=sum b_u k_u  u=1...d}, outperforms a single
%kernel from the set {k_1,...,k_u,...,k_d}

% RBF unnivariate kernels or one gaussian kernel per dimension
%important
%------------
%conexion MMD and supervised classification  maximize
%the MMD on the training data, which is equivalent to minimizing the error in classifying p
%vs. q under linear loss [15]

%% Plots

%plot variable Age: 10-19, 20-29, 30-39, 40-49, 50-59, 60-69, 70-79, 80-89, 90-99.
sample=1:1:100;
temp=[10 19];
colors=['-b'; '-g' ;'-r'; '-c'; '-m'; '-y'; '-k'; '-b'; '-g']
j=1;
for i=0:10:80
    y=trapmf(sample,[temp(1)-5 temp(1) temp(2) temp(2)+5]);
    plot(sample,y,colors(j,:),'LineWidth',3)
    j=j+1;
    hold on
    temp=[10 19]+i;
end
set(gca,'fontsize',25)

%plot variable Menopause: lt40, ge40, premeno.

figure
sample=1:0.1:100
y = zmf(sample,[40 45]);
plot(sample,y,'-r','LineWidth',3)
hold on
y=smf(sample,[35 40]);
plot(sample,y,'-b','LineWidth',3)
y= gaussmf(sample,[ (50-40)/(2*sqrt(2*log(2))) ,45])
plot(sample,y,'-y','LineWidth',3)
set(gca,'fontsize',25)

%   plot variable Tumor-size: 0-4, 5-9, 10-14, 15-19, 20-24, 25-29, 30-34, 35-39, 40-44, 45-49, 50-54, 55-59.
figure
sample=1:0.1:60;
colors=['-b'; '-g' ;'-r'; '-c'; '-m'; '-y'; '-k'; '-b'; '-g';'-r'; '-c'; '-m']
j=1;
temp=[0 4];
y=zmf(sample,[temp(1) temp(2)+5]);
plot(sample,y,colors(j,:),'LineWidth',3)
j=j+1;
hold on
temp=[55 59];
y=smf(sample,[temp(1)-5 temp(2)]);
plot(sample,y,colors(j,:),'LineWidth',3)
j=j+1;

for i=0:5:45
    temp=[5 9]+i
    y=gaussmf(sample,[ (temp(2)-temp(1))/(2*sqrt(2*log(2))) ,mean(temp)]);
    plot(sample,y,colors(j,:),'LineWidth',3)
    j=j+1;
end
set(gca,'fontsize',25)

% plot variable  Inv-nodes: 0-2, 3-5, 6-8, 9-11, 12-14, 15-17, 18-20, 21-23, 24-26, 27-29, 30-32, 33-35, 36-39.
figure
sample=1:0.1:40;
colors=['-b'; '-g' ;'-r'; '-c'; '-m'; '-y'; '-k'; '-b'; '-g';'-r'; '-c'; '-m'; '-y']
j=1;
temp=[0 2];
y=zmf(sample,[temp(1) temp(2)+3]);
plot(sample,y,colors(j,:),'LineWidth',3)
j=j+1;
hold on
temp=[36 39];
y=smf(sample,[temp(1)-3 temp(2)]);
plot(sample,y,colors(j,:),'LineWidth',3)
j=j+1;

for i=0:3:33
    temp=[3 5]+i
    y=gaussmf(sample,[ (temp(2)-temp(1))/(2*sqrt(2*log(2))) ,mean(temp)]);
    plot(sample,y,colors(j,:),'LineWidth',3)
    j=j+1;
end
set(gca,'fontsize',25)

%etc
%%
%idea del experimento, plotar la acuracion con respecto al sample


%% idea del experimento
% crear un kernel por dimension: kd, luego por cada computar el MMD con
% cada kd, luego selecionar el kernel kd que maximiza el MMD es a kernel
% selection method
