set(0,'defaultAxesFontName', 'Arial')

coeff = pca(CaRes)
[coeff,score,latent,tsquared,explained] = pca(CaRes);

C = repmat([1:25],1,4);
c = C(:);

scatter(mean(PNmean,1),score(:,1),50,"black")
ylim([-70 70])
xlim([-10 120])
ylabel('2nd Principal Component','Fontsize',15)
xlabel('Valene index','Fontsize',15)
[rho,pval]=corr(mean(PNmean,1)',score(:,1))
refline