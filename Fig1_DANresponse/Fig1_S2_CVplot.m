
ResponseG1=squeeze(mean(GrandT1(:,5:9,2:13,:,:),2));

MeanTrial1=squeeze(mean(ResponseG1,3));
SDTrial1=squeeze(std(ResponseG1,0,3));

% MeanT1=reshape(MeanTrial1, 1950,1);
% SDT1=reshape(SDTrial1, 1950,1);

MeanT1=reshape(MeanTrial1, 1800,1);
SDT1=reshape(SDTrial1, 1800,1);

ResponseG2=squeeze(mean(GrandT2(:,5:9,2:15,:,:),2));

MeanTrial2=squeeze(mean(ResponseG2,3));
SDTrial2=squeeze(std(ResponseG2,0,3));

% MeanT2=reshape(MeanTrial2, 2640,1);
% SDT2=reshape(SDTrial2, 2640,1);

MeanT2=reshape(MeanTrial2, 2310,1);
SDT2=reshape(SDTrial2, 2310,1);

figure;hold on;
scatter(MeanT1,SDT1,'k')
scatter(MeanT2,SDT2,'k')
ylim([-5,95])
xlim([-40,160])
yt=[SDT1;SDT2];
xt=[MeanT1;MeanT2];
mdl = fitlm(xt,yt)
a=mdl.Coefficients.Estimate(1);
b=mdl.Coefficients.Estimate(2);
yft=b*xt+a;
plot(xt,yft)

[rho,pval]=corr([MeanT1;MeanT2],[SDT1;SDT2])




%%

figure;hold on;
for i=1:15
    
    M1=MeanTrial1(i,:,:);
    M1re=reshape(M1, 120,1);
    
    M2=MeanTrial2(i,:,:);
    M2re=reshape(M2, 154,1);
    
    S1=SDTrial1(i,:,:);
    S1re=reshape(S1, 120,1);
    
    S2=SDTrial2(i,:,:);
    S2re=reshape(S2, 154,1);


subplot(3,5,i);
hold on;
scatter(M1re,S1re,'k')
scatter(M2re,S2re,'k')
%ylim([-5,95])
%xlim([-40,160])

yt=[S1re;S2re];
xt=[M1re;M2re];
mdl = fitlm(xt,yt)
a=mdl.Coefficients.Estimate(1);
b=mdl.Coefficients.Estimate(2);

[rho,pval]=corr(xt,yt)

title(['r ',num2str(round(rho,2)),' slope ',num2str(b)])
yft=b*xt+a;
plot(xt,yft,'b')
lim = axis
ylim ([min(lim(1,[1,3])),max(lim(1,[2,4]))])
xlim ([min(lim(1,[1,3])),max(lim(1,[2,4]))])

daspect([1 1 1])
end

%%

MeanTrialPN=squeeze(mean(indPN,3));
SDTrialPN=squeeze(std(indPN,0,3));

MeanTPN=reshape(MeanTrialPN, 56425,1);
SDTPN=reshape(SDTrialPN, 56425,1);


MeanTPNna = rmmissing(MeanTPN)

SDTPNna = rmmissing(SDTPN)

figure;hold on;
scatter(MeanTPNna,SDTPNna,'k')
ylim([-10,350])
xlim([-100,620])
yt=SDTPNna;
xt=MeanTPNna;
mdl = fitlm(xt,yt)
a=mdl.Coefficients.Estimate(1);
b=mdl.Coefficients.Estimate(2);
yft=b*xt+a;
plot(xt,yft)



[rho,pval]=corr(MeanTPNna,SDTPNna)


%%