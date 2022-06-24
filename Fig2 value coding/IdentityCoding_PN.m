%Alldata_4t=readtable('Alldataset_4trials_val.csv');


seedPNmax=100;

PN_pf=zeros(seedPNmax,100);

for seedPN=1:seedPNmax

s = rng(seedPN);
r = randi([1 37],1,15);
PNmean15PN=PNmean(r,:);

% Y2Teststore=[];
% VIstore=[];
store=zeros(100,1);

OdorName=readtable('OdorName25.csv');
OutN=25;

for j=1:100
Y=OdorName.OdorName;
Y2=VI_25;
X=PNmean15PN';
classOrder = unique(Y);
rng(j); 
p=OutN/100;
t = templateSVM('Standardize',true);
PMdl = fitcecoc(X,Y,'Holdout',p,'Learners',t,'ClassNames',classOrder);
Mdl = PMdl.Trained{1};           % Extract trained, compact classifier

testInds = test(PMdl.Partition);  % Extract the test indices

XTest = X(testInds,:);
YTest = Y(testInds,:);
Y2Test= Y2(testInds,:);
labels = predict(Mdl,XTest);

idx = randsample(sum(testInds),OutN);
table(YTest(idx),labels(idx),...
    'VariableNames',{'TrueLabels','PredictedLabels'})

tf=zeros(1,OutN);
for i=1:OutN
tf(i)=isequal(YTest(i),labels(i));
end

mean(tf)
store(j,1)=mean(tf);

% VI=zeros(OutN,1);
% for i=1:OutN
% s1=labels(i);
% s2=YTest;
% tf = strcmp(s1,s2);
% VI(i,1)=Y2Test(tf);
% end
% 
% Y2Teststore=[Y2Teststore;Y2Test];
% VIstore=[VIstore;VI];

end

PN_pf(seedPN,:)=store;


end


%%

Result=[Y2Teststore-VIstore];
Error=Result(find(Result));

randi=randperm(size(Y2Teststore,1));
RandY2=Y2Teststore(randi);

Result2=[RandY2-VIstore];
Error2=Result2(find(Result2));
ErrorRand=Error2(1:size(Error,1));

figure;
hold on
histogram(Error,'BinWidth',0.05);ylim([0 300]);
histogram(ErrorRand,'BinWidth',0.05);ylim([0 300]);
legend('Result','Randomized') 
%save Error50.mat Error ErrorRand

figure;
hold on
histogram(abs(Error),'BinWidth',0.05);ylim([0 500]);
histogram(abs(ErrorRand),'BinWidth',0.05);ylim([0 500]);
legend('Result','Randomized')