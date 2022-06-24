EM= readmatrix('NN_byBlock_0_100_4trials_wEI_1_DbyPN_MBON.csv');   

valence=VI_25;
CaRes=EM(:,2:101)';

% standardization

[Z,mu,sigma] = zscore(CaRes) ;
%[Zv,mu,sigma] = zscore(valence) ;

% how many compartment contribute to the prediction
figure;
[XL,yl,XS,YS,beta,PCTVAR,MSE,stats] = plsregress(CaRes,valence,15,'CV',10);
plot(1:15,cumsum(100*PCTVAR(2,:)),'-bo');
xlabel('Number of PLS components','FontSize',15);
ylabel('Percent Variance Explained in y','FontSize',15);

yfit = [ones(size(CaRes,1),1) CaRes]*beta;

N_PLS=4

%Fitted response vs observed response
figure;
plot(valence,yfit,'o','Color','k')
xlim([-0.3 0.5])
ylim([-0.3 0.5])
hline=refline(1,0);
hline.Color = 'k';
xlabel('Actual valence index','FontSize',15);
ylabel('Fitted valence index','FontSize',15);
daspect([1 1 1])

%R-sqr value
TSS = sum((valence-mean(valence)).^2);
RSS = sum((valence-yfit).^2);
Rsquared = 1 - RSS/TSS

RSSs_tr=[];
RSSs_te=[];
Pbeta=[];

figure; 

for i=1:100
    
trainX=CaRes;
trainY=valence;
r = i;
%r = [i,i+27,i+54,i+81];
testX=CaRes(r,:);
testY=valence(r,:);
trainX(r,:) = [];
trainY(r,:) = [];

% cross validation
[XL,yl,XS,YS,beta,PCTVAR,MSE,stats] = plsregress(trainX,trainY,N_PLS,'CV',10);

% % fitting
% yfit_tr = [ones(size(trainX,1),1) trainX]*beta;
% figure(1);
% plot(trainY,yfit_tr,'o')
% refline(1,0) 
% TSS = sum((trainY-mean(trainY)).^2);
% RSS = sum((trainY-yfit_tr).^2);
% Rsquared_tr = 1 - RSS/TSS
% %TSSs =[TSSs;TSS];
% RSSs_tr=[RSSs_tr;RSS];

% test

yfit_test = [ones(size(testX,1),1) testX]*beta;
hold on
plot(testY,yfit_test,'o')
refline(1,0) 
xlim([-0.3 0.5])
ylim([-0.3 0.5])
RSS = (testY-yfit_test).^2;
RSSs_te=[RSSs_te;RSS];
Pbeta=[Pbeta,beta];
xlabel('Actual valence index','FontSize',15);
ylabel('Predicted valence index','FontSize',15);
daspect([1 1 1])
end


%TSS=std(valence);

%Rsquared_tr = 1 - mean(RSSs_tr)
TSS = sum((valence-mean(valence)).^2);
Rsquared_te_class = 1 - sum(RSSs_te)/TSS

%%genel

RSSs_tr=[];
RSSs_te=[];
Pbeta=[];

figure; 

for i=1:25
    
trainX=CaRes;
trainY=valence;
%r = [1+(i-1)*27:27+(i-1)*27];
r = [i,i+25,i+50,i+75];
testX=CaRes(r,:);
testY=valence(r,:);
trainX(r,:) = [];
trainY(r,:) = [];

% cross validation
[XL,yl,XS,YS,beta,PCTVAR,MSE,stats] = plsregress(trainX,trainY,N_PLS,'CV',10);

% test

yfit_test = [ones(size(testX,1),1) testX]*beta;
hold on
plot(testY,yfit_test,'o','Color','k','MarkerSize',8);
refline(1,0) ;
xlim([-0.2 0.5]);
ylim([-0.2 0.5]);
RSS = (testY-yfit_test).^2;
RSSs_te=[RSSs_te;RSS];
Pbeta=[Pbeta,beta];
hline=refline(1,0);
hline.Color = 'k';
xlabel('Actual valence index','FontSize',15);
ylabel('Predicted valence index','FontSize',15);
daspect([1 1 1]);
end


%TSS=std(valence);

%Rsquared_tr = 1 - mean(RSSs_tr)
TSS = sum((valence-mean(valence)).^2);
Rsquared_te = 1 - sum(RSSs_te)/TSS

% make ground model
Gbeta= mean(Pbeta,2);
yfit_fin = [ones(size(CaRes,1),1) CaRes]*Gbeta;
figure;
plot(valence,yfit,'o','Color','k');
xlim([-0.2 0.6]);
ylim([-0.2 0.6]);
hline=refline(1,0);
hline.Color = 'k';
xlabel('Actual valence index','FontSize',15);
ylabel('Predicted valence index','FontSize',15);
daspect([1 1 1])

RSS=sum((valence-yfit_fin).^2);
TSS = sum((valence-mean(valence)).^2);
Rsquared_fin = 1 - RSS/TSS

NT_RsqDANConnectome_P4=[Rsquared,Rsquared_te_class,Rsquared_te,Rsquared_fin]
%%

%%Rand onlyA
EM= readmatrix('NN_NT_4trials_RandA.csv');   

NT_RandA10_P4=zeros(10,4);
for g=1:10
valence=VI_25;
CaRes=EM(:,2+g*100-100:101+g*100-100)';

% standardization

[Z,mu,sigma] = zscore(CaRes) ;
%[Zv,mu,sigma] = zscore(valence) ;

% how many compartment contribute to the prediction
figure;
[XL,yl,XS,YS,beta,PCTVAR,MSE,stats] = plsregress(CaRes,valence,15,'CV',10);
plot(1:15,cumsum(100*PCTVAR(2,:)),'-bo');
xlabel('Number of PLS components','FontSize',15);
ylabel('Percent Variance Explained in y','FontSize',15);

yfit = [ones(size(CaRes,1),1) CaRes]*beta;

N_PLS=4

%Fitted response vs observed response
figure;
plot(valence,yfit,'o','Color','k')
xlim([-0.3 0.5])
ylim([-0.3 0.5])
hline=refline(1,0);
hline.Color = 'k';
xlabel('Actual valence index','FontSize',15);
ylabel('Fitted valence index','FontSize',15);
daspect([1 1 1])

%R-sqr value
TSS = sum((valence-mean(valence)).^2);
RSS = sum((valence-yfit).^2);
Rsquared = 1 - RSS/TSS

RSSs_tr=[];
RSSs_te=[];
Pbeta=[];

figure; 

for i=1:100
    
trainX=CaRes;
trainY=valence;
r = i;
%r = [i,i+27,i+54,i+81];
testX=CaRes(r,:);
testY=valence(r,:);
trainX(r,:) = [];
trainY(r,:) = [];

% cross validation
[XL,yl,XS,YS,beta,PCTVAR,MSE,stats] = plsregress(trainX,trainY,N_PLS,'CV',10);

% % fitting
% yfit_tr = [ones(size(trainX,1),1) trainX]*beta;
% figure(1);
% plot(trainY,yfit_tr,'o')
% refline(1,0) 
% TSS = sum((trainY-mean(trainY)).^2);
% RSS = sum((trainY-yfit_tr).^2);
% Rsquared_tr = 1 - RSS/TSS
% %TSSs =[TSSs;TSS];
% RSSs_tr=[RSSs_tr;RSS];

% test

yfit_test = [ones(size(testX,1),1) testX]*beta;
hold on
plot(testY,yfit_test,'o')
refline(1,0) 
xlim([-0.3 0.5])
ylim([-0.3 0.5])
RSS = (testY-yfit_test).^2;
RSSs_te=[RSSs_te;RSS];
Pbeta=[Pbeta,beta];
xlabel('Actual valence index','FontSize',15);
ylabel('Predicted valence index','FontSize',15);
daspect([1 1 1])
end


%TSS=std(valence);

%Rsquared_tr = 1 - mean(RSSs_tr)
TSS = sum((valence-mean(valence)).^2);
Rsquared_te_class = 1 - sum(RSSs_te)/TSS

%%genel

RSSs_tr=[];
RSSs_te=[];
Pbeta=[];

figure; 

for i=1:25
    
trainX=CaRes;
trainY=valence;
%r = [1+(i-1)*27:27+(i-1)*27];
r = [i,i+25,i+50,i+75];
testX=CaRes(r,:);
testY=valence(r,:);
trainX(r,:) = [];
trainY(r,:) = [];

% cross validation
[XL,yl,XS,YS,beta,PCTVAR,MSE,stats] = plsregress(trainX,trainY,N_PLS,'CV',10);

% test

yfit_test = [ones(size(testX,1),1) testX]*beta;
hold on
plot(testY,yfit_test,'o','Color','k','MarkerSize',8);
refline(1,0) ;
xlim([-0.2 0.5]);
ylim([-0.2 0.5]);
RSS = (testY-yfit_test).^2;
RSSs_te=[RSSs_te;RSS];
Pbeta=[Pbeta,beta];
hline=refline(1,0);
hline.Color = 'k';
xlabel('Actual valence index','FontSize',15);
ylabel('Predicted valence index','FontSize',15);
daspect([1 1 1]);
end


%TSS=std(valence);

%Rsquared_tr = 1 - mean(RSSs_tr)
TSS = sum((valence-mean(valence)).^2);
Rsquared_te = 1 - sum(RSSs_te)/TSS

% make ground model
Gbeta= mean(Pbeta,2);
yfit_fin = [ones(size(CaRes,1),1) CaRes]*Gbeta;
figure;
plot(valence,yfit,'o','Color','k');
xlim([-0.2 0.6]);
ylim([-0.2 0.6]);
hline=refline(1,0);
hline.Color = 'k';
xlabel('Actual valence index','FontSize',15);
ylabel('Predicted valence index','FontSize',15);
daspect([1 1 1])

RSS=sum((valence-yfit_fin).^2);
TSS = sum((valence-mean(valence)).^2);
Rsquared_fin = 1 - RSS/TSS


NT_RandA10_P4(g,:)=[Rsquared,Rsquared_te_class,Rsquared_te,Rsquared_fin]

end
%%
%%Rand AB

EM= readmatrix('NN_NT_4trials_RandAB.csv'); 

NT_RandAB10_P4=zeros(10,4);
for g=1:10
valence=VI_25;
CaRes=EM(:,2+g*100-100:101+g*100-100)';

% standardization

[Z,mu,sigma] = zscore(CaRes) ;
%[Zv,mu,sigma] = zscore(valence) ;

% how many compartment contribute to the prediction
figure;
[XL,yl,XS,YS,beta,PCTVAR,MSE,stats] = plsregress(CaRes,valence,15,'CV',10);
plot(1:15,cumsum(100*PCTVAR(2,:)),'-bo');
xlabel('Number of PLS components','FontSize',15);
ylabel('Percent Variance Explained in y','FontSize',15);

yfit = [ones(size(CaRes,1),1) CaRes]*beta;

N_PLS=4

%Fitted response vs observed response
%figure;
plot(valence,yfit,'o','Color','k')
xlim([-0.3 0.5])
ylim([-0.3 0.5])
hline=refline(1,0);
hline.Color = 'k';
xlabel('Actual valence index','FontSize',15);
ylabel('Fitted valence index','FontSize',15);
daspect([1 1 1])

%R-sqr value
TSS = sum((valence-mean(valence)).^2);
RSS = sum((valence-yfit).^2);
Rsquared = 1 - RSS/TSS;

RSSs_tr=[];
RSSs_te=[];
Pbeta=[];

%figure; 

for i=1:100
    
trainX=CaRes;
trainY=valence;
r = i;
%r = [i,i+27,i+54,i+81];
testX=CaRes(r,:);
testY=valence(r,:);
trainX(r,:) = [];
trainY(r,:) = [];

% cross validation
[XL,yl,XS,YS,beta,PCTVAR,MSE,stats] = plsregress(trainX,trainY,N_PLS,'CV',10);

% fitting
yfit_tr = [ones(size(trainX,1),1) trainX]*beta;
figure(1);
plot(trainY,yfit_tr,'o')
refline(1,0) 
TSS = sum((trainY-mean(trainY)).^2);
RSS = sum((trainY-yfit_tr).^2);
Rsquared_tr = 1 - RSS/TSS
%TSSs =[TSSs;TSS];
RSSs_tr=[RSSs_tr;RSS];

% test

yfit_test = [ones(size(testX,1),1) testX]*beta;
hold on
plot(testY,yfit_test,'o')
refline(1,0) 
xlim([-0.3 0.5])
ylim([-0.3 0.5])
RSS = (testY-yfit_test).^2;
RSSs_te=[RSSs_te;RSS];
Pbeta=[Pbeta,beta];
xlabel('Actual valence index','FontSize',15);
ylabel('Predicted valence index','FontSize',15);
daspect([1 1 1])
end


%TSS=std(valence);

%Rsquared_tr = 1 - mean(RSSs_tr)
TSS = sum((valence-mean(valence)).^2);
Rsquared_te_class = 1 - sum(RSSs_te)/TSS

%%genel

RSSs_tr=[];
RSSs_te=[];
Pbeta=[];

%figure; 

for i=1:25
    
trainX=CaRes;
trainY=valence;
%r = [1+(i-1)*27:27+(i-1)*27];
r = [i,i+25,i+50,i+75];
testX=CaRes(r,:);
testY=valence(r,:);
trainX(r,:) = [];
trainY(r,:) = [];

% cross validation
[XL,yl,XS,YS,beta,PCTVAR,MSE,stats] = plsregress(trainX,trainY,N_PLS,'CV',10);

% test

yfit_test = [ones(size(testX,1),1) testX]*beta;
hold on
plot(testY,yfit_test,'o','Color','k','MarkerSize',8);
refline(1,0) ;
xlim([-0.2 0.5]);
ylim([-0.2 0.5]);
RSS = (testY-yfit_test).^2;
RSSs_te=[RSSs_te;RSS];
Pbeta=[Pbeta,beta];
hline=refline(1,0);
hline.Color = 'k';
xlabel('Actual valence index','FontSize',15);
ylabel('Predicted valence index','FontSize',15);
daspect([1 1 1]);
end


%TSS=std(valence);

%Rsquared_tr = 1 - mean(RSSs_tr)
TSS = sum((valence-mean(valence)).^2);
Rsquared_te = 1 - sum(RSSs_te)/TSS

% make ground model
Gbeta= mean(Pbeta,2);
yfit_fin = [ones(size(CaRes,1),1) CaRes]*Gbeta;
%figure;
plot(valence,yfit,'o','Color','k');
xlim([-0.2 0.6]);
ylim([-0.2 0.6]);
hline=refline(1,0);
hline.Color = 'k';
xlabel('Actual valence index','FontSize',15);
ylabel('Predicted valence index','FontSize',15);
daspect([1 1 1])

RSS=sum((valence-yfit_fin).^2);
TSS = sum((valence-mean(valence)).^2);
Rsquared_fin = 1 - RSS/TSS

NT_RandAB10_P4(g,:)=[Rsquared,Rsquared_te_class,Rsquared_te,Rsquared_fin]

end
%%
%% PLS4
conditions=1:4;
name={'fitting','leave one','generalization','fin'};

figure;hold on;
for i=1:4
    subplot(2,2,i)
    
bar(conditions,[RsqDAN15_PLS4(i),NT_RsqDANConnectome_P4(i),mean(NT_RandA10_P4(:,i),1),mean(NT_RandAB10_P4(:,i),1)],'k');
er = errorbar([RsqDAN15_PLS4(i),NT_RsqDANConnectome_P4(i),mean(NT_RandA10_P4(:,i),1),mean(NT_RandAB10_P4(:,i),1)],[0,0,std(NT_RandA10_P4(:,i),1),std(NT_RandAB10_P4(:,i),1)]);    
hold off
xlim([0 6]);
ylim([-0.5 1]);
xticks([1:4]);
set(gca,'XTickLabel',{'DAN','connectome','GlomSh','AllSh'},'Fontsize',15);
ylabel('Rsq value','Fontsize',15)
title(name(i));
end
%%
%% PLS4
conditions=1:4;
name={'fitting','leave one','generalization','fin'};

figure;hold on;
i=3
bar(conditions,[RsqDAN15_PLS4(i),NT_RsqDANConnectome_P4(i),mean(NT_RandA10_P4(:,i),1),mean(NT_RandAB10_P4(:,i),1)],'k');
er = errorbar([RsqDAN15_PLS4(i),NT_RsqDANConnectome_P4(i),mean(NT_RandA10_P4(:,i),1),mean(NT_RandAB10_P4(:,i),1)],[0,0,std(NT_RandA10_P4(:,i),1),std(NT_RandAB10_P4(:,i),1)]);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';
er.MarkerSize = 1;
hold off
xlim([0 5]);
ylim([-0.75 0.75]);
xticks([1:4]);
set(gca,'XTickLabel',{'DAN','connectome','GlomSh','AllSh'},'Fontsize',15);
ylabel('Rsq value','Fontsize',15)
title(name(i));
%%
figure;hold on;
conditions=1:5;
i=3
bar(conditions,[RsqDAN15_PLS4(i),mean(RsqPN15_n100_PLS4(:,i),1),NT_RsqDANConnectome_P4(i),mean(NT_RandA10_P4(:,i),1),mean(NT_RandAB10_P4(:,i),1)],'k');
er = errorbar([RsqDAN15_PLS4(i),mean(RsqPN15_n100_PLS4(:,i),1),NT_RsqDANConnectome_P4(i),mean(NT_RandA10_P4(:,i),1),mean(NT_RandAB10_P4(:,i),1)],[0,std(RsqPN15_n100_PLS4(:,i),1),0,std(NT_RandA10_P4(:,i),1),std(NT_RandAB10_P4(:,i),1)]);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';
er.MarkerSize = 1;
hold off
xlim([0 6]);
ylim([-0.75 0.75]);
xticks([1:5]);
set(gca,'XTickLabel',{'DAN','PN15','connectome','GlomSh','AllSh'},'Fontsize',15);
ylabel('Rsq value','Fontsize',15)
title(name(i));