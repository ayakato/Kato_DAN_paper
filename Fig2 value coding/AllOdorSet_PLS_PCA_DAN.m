set(0,'defaultAxesFontName', 'Arial')

MeanOnset=squeeze(mean(BrainMeanArranged(:,5:7,:,:),2));
MeanOnset4trials = reshape(MeanOnset,15,108);

% PNmean=reshape(Rpn,37,100);
% s = rng;
% r = randi([1 37],1,15);
% 
% PNmean15PN=PNmean(r,:);

%airCent=sort(VI(1:27,1))-VI(1,1)+VI(2,1);
%VIall=[airCent;airCent;airCent;airCent];

figure;
    clims = [-20 80];
    imagesc(MeanOnset4trials,clims);
    
%%omit 8&15

VIsorted=sort(VI(1:27,1));
VIsorted(8)=[];
VIsorted(15)=[];

VI_25=[VIsorted;VIsorted;VIsorted;VIsorted];

MeanOnset4trials(:,8)=[];
MeanOnset4trials(:,15)=[];
MeanOnset4trials(:,8+27)=[];
MeanOnset4trials(:,15+27)=[];
MeanOnset4trials(:,8+54)=[];
MeanOnset4trials(:,15+54)=[];
MeanOnset4trials(:,8+81)=[];
MeanOnset4trials(:,15+81)=[];

valence=VI_25;
CaRes=MeanOnset4trials';

% standardization

[Z,mu,sigma] = zscore(CaRes) ;
%[Zv,mu,sigma] = zscore(valence) ;

% how many compartment contribute to the prediction
figure;
[XL,yl,XS,YS,beta,PCTVAR,MSE,stats] = plsregress(Z,valence,15,'CV',10);
plot(1:15,cumsum(100*PCTVAR(2,:)),'-bo');
xlabel('Number of PLS components','FontSize',15);
ylabel('Percent Variance Explained in y','FontSize',15);
%% 
% 


%CaRes=Z;

N_PLS=4

[XL,yL,XS,YS,beta,PCTVAR,MSE,stats] = plsregress(CaRes,valence,N_PLS,'CV',10);

yfit = [ones(size(CaRes,1),1) CaRes]*beta;
residuals = valence - yfit;
stem(residuals)
xlabel('Observation');
ylabel('Residual');

%Fitted response vs observed response
figure;
plot(valence,yfit,'o','Color','k')
xlim([-0.3 0.5])
ylim([-0.3 0.5])
hline=refline(1,0)
hline.Color = 'k';
xlabel('Actual valence index','FontSize',15);
ylabel('Fitted valence index','FontSize',15);
daspect([1 1 1])

%R-sqr value
TSS = sum((valence-mean(valence)).^2);
RSS = sum((valence-yfit).^2);
Rsquared = 1 - RSS/TSS

figure;
[axes,h1,h2] = plotyy(0:N_PLS,MSE(1,:),0:N_PLS,MSE(2,:));
set(h1,'Marker','o')
set(h2,'Marker','o')
legend('MSE Predictors','MSE Response')
xlabel('Number of Components')



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

%%generalization task

RSSs_tr=[];
RSSs_te=[];
Pbeta=[];

figure; 

for i=1:25
    N_PLS
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
plot(testY,yfit_test,'o','Color','k','MarkerSize',8)
refline(1,0) 
xlim([-0.2 0.5])
ylim([-0.2 0.5])
RSS = (testY-yfit_test).^2;
RSSs_te=[RSSs_te;RSS];
Pbeta=[Pbeta,beta];
hline=refline(1,0)
hline.Color = 'k';
xlabel('Actual valence index','FontSize',15);
ylabel('Predicted valence index','FontSize',15);
daspect([1 1 1])
end


%TSS=std(valence);

%Rsquared_tr = 1 - mean(RSSs_tr)
TSS = sum((valence-mean(valence)).^2);
Rsquared_te = 1 - sum(RSSs_te)/TSS

% make ground model
Gbeta= mean(Pbeta,2);
yfit_fin = [ones(size(CaRes,1),1) CaRes]*Gbeta;
figure;
plot(valence,yfit,'o','Color','k')
xlim([-0.2 0.6])
ylim([-0.2 0.6])
hline=refline(1,0)
hline.Color = 'k';
xlabel('Actual valence index','FontSize',15);
ylabel('Predicted valence index','FontSize',15);
daspect([1 1 1])


RSS=sum((valence-yfit_fin).^2);
TSS = sum((valence-mean(valence)).^2);
Rsquared_fin = 1 - RSS/TSS

RsqDAN15_PLS4=[Rsquared,Rsquared_te_class,Rsquared_te,Rsquared_fin]

CP_Label = {
'α3',...
'αp3',...
'α2',...
'αp2',...
'α1',...
'αp1',...
'γ1',...
'γ2',...
'γ3',...
'γ4',...
'γ5',...
'β1',...
'βp1',...
'β2',...
'βp2'
};
%%

figure;
colormap jet
clims = [-0.007, 0.007];
imagesc(Gbeta(2:16),clims);
yticks([1:15])
set(gca,'YTickLabel',CP_Label,'Fontsize',15);
daspect([1 1 1])
colorbar;

Gbeta= mean(Pbeta,2);
CPdata=zeros(15,2);

CPdata(:,1)=[1:15]';
CPdata(:,2)=Gbeta(2:16);
CPsem= std(Pbeta,0,2);

CPsemData=CPsem(2:16);

[B,I] = sort(CPdata(:,2));

CP_Labelre = {
    'β1',...
    'γ4',...
    'βp1',...
    'α1',...
    'αp3',...
    'α2',...
    'αp2',...
    'α3',...
    'βp2',...
    'γ3',...
    'γ2',...
    'γ5',...
    'αp1',...
    'β2',...
    'γ1'}

figure;
barh([1:15],B,'k');
hold on
yticks([1:15])
xlim([-0.007 0.007])
set(gca,'YTickLabel',CP_Labelre,'Fontsize',15);

er = errorbar(B,[1:15],CPsemData(I),CPsemData(I),'.','horizontal');    
er.Color = [0 0 0];                            
er.LineStyle = 'none';
er.MarkerSize = 1;
hold off


%%
set(0,'defaultAxesFontName', 'Arial')
% MeanOnset=squeeze(mean(BrainMeanArranged(:,5:7,:,:),2));
% MeanOnset4trials = reshape(MeanOnset,15,108);
% 
% airCent=sort(VI(1:27,1))-VI(1,1)+VI(2,1);
% VIall=[airCent;airCent;airCent;airCent];

% valence=VIall;
% CaRes=MeanOnset4trials';

rng(1); % For reproducibility
[idx,C] = kmeans(CaRes,3);
figure;image(idx*10);

figure; colormap jet;
scatter(idx,valence,30)
%PCA

coeff = pca(CaRes)
[coeff,score,latent,tsquared,explained] = pca(CaRes);

C = repmat([1:25],1,4);
c = C(:);

figure; colormap jet;
scatter3(score(:,1),score(:,2),score(:,3),30,c)
axis equal
xlabel('1st Principal Component')
ylabel('2nd Principal Component')
zlabel('3rd Principal Component')

figure;colormap jet;
scatter(score(:,1),score(:,2),30,c)
axis equal
xlabel('1st Principal Component','Fontsize',15)
ylabel('2nd Principal Component','Fontsize',15)

figure;colormap jet;
scatter(valence,score(:,1),50,"black")
ylim([-70 70])
xlim([-0.3 0.45])
ylabel('1st Principal Component','Fontsize',15)
xlabel('Valene index','Fontsize',15)
corr(valence,score(:,1))
refline
daspect([0.005 1 1])
yticks([-50 0 50])
xticks([-0.2 0 0.2 0.4])

figure;colormap jet;
scatter(valence,score(:,2),50,"black")
ylim([-40 50])
xlim([-0.3 0.45])
ylabel('2nd Principal Component','Fontsize',15)
xlabel('Valene index','Fontsize',15)
corr(valence,score(:,2))
refline
daspect([0.008 1 1])
yticks([-30 0 30])
xticks([-0.2 0 0.2 0.4])


figure;colormap jet;
scatter(valence,score(:,3),30,"black")
ylim([-40 50])
xlim([-0.3 0.45])
ylabel('3rd Principal Component','Fontsize',15)
xlabel('Valene index','Fontsize',15)
corr(valence,score(:,3))
daspect([0.008 1 1])
refline
yticks([-30 0 30])
xticks([-0.2 0 0.2 0.4])
ax = gca;
ax.FontSize = 15; 

%% SVM identity coding

store=zeros(10,1);
for j=1:10
Y=Alldata_4t.Odor;
X=Alldata_4t(:,3:17);
classOrder = unique(Y);
rng(j); 

t = templateSVM('Standardize',true);
PMdl = fitcecoc(X,Y,'Holdout',0.25,'Learners',t,'ClassNames',classOrder);
Mdl = PMdl.Trained{1};           % Extract trained, compact classifier

testInds = test(PMdl.Partition);  % Extract the test indices
XTest = X(testInds,:);
YTest = Y(testInds,:);
labels = predict(Mdl,XTest);

idx = randsample(sum(testInds),27);
table(YTest(idx),labels(idx),...
    'VariableNames',{'TrueLabels','PredictedLabels'});

tf=zeros(1,27);
for i=1:27
tf(i)=isequal(YTest(i),labels(i));
end

mean(tf);

store(j)=mean(tf);
end