conditions=1:2;
mean(DAN_pf);
mean(PN_pf);

%errorbar(conditions,[mean(DAN_pf),mean(PN_pf)],[std(DAN_pf,0,1)/10,std(PN_pf,0,1)/10]); 

figure;hold on;
bar(conditions,[mean(DAN_pf),mean(PN_pf)],'k');
er = errorbar(conditions,[mean(DAN_pf),mean(PN_pf)],[std(DAN_pf,0,1),std(PN_pf,0,1)],[std(DAN_pf,0,1),std(PN_pf,0,1)]);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';
er.MarkerSize = 1;
hold off
xlim([0 3]);
ylim([0 1]);
xticks([1 2]);
set(gca,'XTickLabel',{'DAN','PN'},'Fontsize',15);
ylabel('Classification accuracy','Fontsize',15)
%% 
% 

%% PLS6
conditions=1:5;
name={'fitting','leave one','generalization','fin'};

figure;
for i=3
%    subplot(2,2,i);
hold on;
MeanRsq=[RsqDAN15_PLS6(i),mean(RsqPN15_n100_PLS6(:,i),1),RsqDANConnectome(i),mean(RsqDANConnectomeA10_P6(:,i),1),mean(RsqDANConnectomeAB10_25_P6(:,i),1)]    
SDRsq=[0,std(RsqPN15_n100_PLS6(:,i),1)/sqrt(100),0,std(RsqDANConnectomeA10_P6(:,i),1)/sqrt(10),std(RsqDANConnectomeAB10_25_P6(:,i),1)/sqrt(10)]
bar(conditions,MeanRsq,'k');
er = errorbar(conditions,MeanRsq,SDRsq,SDRsq);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';
er.MarkerSize = 1;
hold off
xlim([0 6]);
ylim([0 0.4]);
xticks([1:5]);
set(gca,'XTickLabel',{'DAN','PN15','connectome','GlomSh','AllSh'},'Fontsize',15);
ylabel('Rsq value','Fontsize',15)
title(name(i));
end
%%
conditions=1:3;
figure;
i=3
hold on;
MeanRsq=[RsqDANConnectome(i),RsqDANConnectome_P6_noLH(i),RsqDANConnectome_P6_noKC(i)]    
bar(conditions,MeanRsq,'k');
xlim([0 4]);
ylim([-0.3 0.4]);
xticks([1:3]);
set(gca,'XTickLabel',{'All','noLH','noKC'},'Fontsize',15);
ylabel('Rsq value','Fontsize',15)


%%
%% PLS4
conditions=1:5;
name={'fitting','leave one','generalization','fin'};

figure;hold on;
for i=1:4
    subplot(2,2,i)
    
bar(conditions,[RsqDAN15_PLS4(i),mean(RsqPN15_n100(:,i),1),RsqDANConnectome_P4(i),mean(RsqDANConnectomeA10_P4(:,i),1),mean(RsqDANConnectomeAB10_25_P4(:,i),1)],'k');
%er = errorbar(conditions,[0,std(RsqPN15_n100_PLS6(:,i),1),0,std(RsqDANConnectomeA10_P6(:,i),1),std(RsqDANConnectomeAB10_25_P6(:,i),1)]);    
xlim([0 6]);
ylim([0 0.8]);
xticks([1:5]);
set(gca,'XTickLabel',{'DAN','PN15','connectome','GlomSh','AllSh'},'Fontsize',15);
ylabel('Rsq value','Fontsize',15)
title(name(i));
end
%%
%% PLS4
conditions=1:5;
name={'fitting','leave one','generalization','fin'};

figure;hold on;
for i=1:4
    subplot(2,2,i)
    
bar(conditions,[RsqDAN15_PLS4(i),mean(RsqPN15_n100(:,i),1),RsqDANConnectome_P4(i),mean(RsqDANConnectomeA10_P4(:,i),1),mean(RsqDANConnectomeAB10_25_P4(:,i),1)],'k');
er = errorbar([RsqDAN15_PLS4(i),mean(RsqPN15_n100(:,i),1),RsqDANConnectome_P4(i),mean(RsqDANConnectomeA10_P4(:,i),1),mean(RsqDANConnectomeAB10_25_P4(:,i),1)],[0,std(RsqPN15_n100(:,i),1),0,std(RsqDANConnectomeA10_P4(:,i),1),std(RsqDANConnectomeAB10_25_P4(:,i),1)]);    
hold off
xlim([0 6]);
ylim([-0.5 1]);
xticks([1:5]);
set(gca,'XTickLabel',{'DAN','PN15','connectome','GlomSh','AllSh'},'Fontsize',15);
ylabel('Rsq value','Fontsize',15)
title(name(i));
end
%%
%% PLS5
conditions=1:5;
name={'fitting','leave one','generalization','fin'};

figure;hold on;
for i=1:4
    subplot(2,2,i)
    
bar(conditions,[RsqDAN15_PLS5(i),mean(RsqPN15_n100_PLS5(:,i),1),RsqDANConnectome_P5(i),mean(RsqDANConnectomeA10_P5(:,i),1),mean(RsqDANConnectomeAB10_25_P5(:,i),1)],'k');
er = errorbar([RsqDAN15_PLS5(i),mean(RsqPN15_n100_PLS5(:,i),1),RsqDANConnectome_P5(i),mean(RsqDANConnectomeA10_P5(:,i),1),mean(RsqDANConnectomeAB10_25_P5(:,i),1)],[0,std(RsqPN15_n100_PLS5(:,i),1),0,std(RsqDANConnectomeA10_P5(:,i),1),std(RsqDANConnectomeAB10_25_P5(:,i),1)]);    
hold off
xlim([0 6]);
ylim([-0.5 1]);
xticks([1:5]);
set(gca,'XTickLabel',{'DAN','PN15','connectome','GlomSh','AllSh'},'Fontsize',15);
ylabel('Rsq value','Fontsize',15)
title(name(i));
end
%%
%% PLS6
conditions=1:5;
name={'fitting','leave one','generalization','fin'};

figure;hold on;
for i=1:4
    subplot(2,2,i)
    
bar(conditions,[RsqDAN15_PLS6(i),mean(RsqPN15_n100_PLS6(:,i),1),RsqDANConnectome(i),mean(RsqDANConnectomeA10_P6(:,i),1),mean(RsqDANConnectomeAB10_25_P6(:,i),1)],'k');
er = errorbar([RsqDAN15_PLS6(i),mean(RsqPN15_n100_PLS6(:,i),1),RsqDANConnectome(i),mean(RsqDANConnectomeA10_P6(:,i),1),mean(RsqDANConnectomeAB10_25_P6(:,i),1)],[0,std(RsqPN15_n100_PLS6(:,i),1),0,std(RsqDANConnectomeA10_P6(:,i),1),std(RsqDANConnectomeAB10_25_P6(:,i),1)]);    
hold off
xlim([0 6]);
ylim([-0.5 1]);
xticks([1:5]);
set(gca,'XTickLabel',{'DAN','PN15','connectome','GlomSh','AllSh'},'Fontsize',15);
ylabel('Rsq value','Fontsize',15)
title(name(i));
end
%% 
% 

figure;hold on;
for i=1:4
    subplot(2,2,i)
    bar(conditions,[RsqDAN15(i),RsqPN15(i)],'k');
    xlim([0 3]);
    ylim([0 1]);
    set(gca,'XTickLabel',{'DAN','PN'},'Fontsize',15);
    ylabel('Rsq value','Fontsize',15);
end
%% 
% 
% 
%