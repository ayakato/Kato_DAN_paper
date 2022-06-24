% 
% seedPNmax=100;
% 
% RsqPN15_n100=zeros(seedPNmax,4);
% 
% for seedPN=1:seedPNmax
% PNmean=reshape(Rpn,37,100);
% s = rng(seedPN);
% r = randi([1 37],1,15);
% 
% PNmean15PN=PNmean(r,:);

valence=VI_25;
[Z,mu,sigma] = zscore(PNmean15PN) ;
CaRes=PNmean';%15PN';

N_PLS=4;

[XL,yL,XS,YS,beta,PCTVAR,MSE,stats] = plsregress(CaRes,valence,N_PLS,'CV',10);

yfit = [ones(size(CaRes,1),1) CaRes]*beta;

%R-sqr value
TSS = sum((valence-mean(valence)).^2);
RSS = sum((valence-yfit).^2);
Rsquared = 1 - RSS/TSS

RSSs_tr=[];
RSSs_te=[];
Pbeta=[];


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

% test

yfit_test = [ones(size(testX,1),1) testX]*beta;

RSS = (testY-yfit_test).^2;
RSSs_te=[RSSs_te;RSS];
Pbeta=[Pbeta,beta];
end

TSS = sum((valence-mean(valence)).^2);
Rsquared_te_class = 1 - sum(RSSs_te)/TSS

%%generalization task

RSSs_tr=[];
RSSs_te=[];
Pbeta=[];


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

RSS = (testY-yfit_test).^2;
RSSs_te=[RSSs_te;RSS];
Pbeta=[Pbeta,beta];

end

TSS = sum((valence-mean(valence)).^2);
Rsquared_te = 1 - sum(RSSs_te)/TSS

% make ground model
Gbeta= mean(Pbeta,2);
yfit_fin = [ones(size(CaRes,1),1) CaRes]*Gbeta;

RSS=sum((valence-yfit_fin).^2);
TSS = sum((valence-mean(valence)).^2);
Rsquared_fin = 1 - RSS/TSS

RsqPN37=[Rsquared,Rsquared_te_class,Rsquared_te,Rsquared_fin]
% end