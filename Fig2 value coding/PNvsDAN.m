%% identity coding


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

%%
conditions=1:2;
PNsubset=mean(PN_pf,1)';
figure;hold on;
bar(conditions,[mean(DAN_pf),mean(PNsubset)],'k');
er = errorbar(conditions,[mean(DAN_pf),mean(PNsubset)],[std(DAN_pf,0,1),std(PNsubset,0,1)],[std(DAN_pf,0,1),std(PNsubset,0,1)]);    
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
set(0,'defaultAxesFontName', 'Arial');
conditions=1:3;
PNsubset=mean(PN_pf,1)';
figure;hold on;
bar(conditions,[mean(DAN_pf),mean(PNsubset),mean(PN37_pf)],'k');
er = errorbar(conditions,[mean(DAN_pf),mean(PNsubset),mean(PN37_pf)],[std(DAN_pf,0,1),std(PNsubset,0,1),std(PN37_pf,0,1)],[std(DAN_pf,0,1),std(PNsubset,0,1),std(PN37_pf,0,1)]);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';
er.MarkerSize = 1;
hold off
xlim([0 4]);
ylim([0 1]);
xticks([1:3]);
set(gca,'XTickLabel',{'DAN','PN15','PN37'},'Fontsize',15);
ylabel('Classification accuracy','Fontsize',15)
%%

figure;hold on;
swarmchart(ones(100,1),DAN_pf)
hold on
swarmchart(2*ones(100,1),PN_pf)
xlim([0.5 2.5]);
ylim([0 1]);
xticks([1 2]);
set(gca,'XTickLabel',{'DAN','PN'},'Fontsize',15);
ylabel('Classification accuracy','Fontsize',15);

%%
figure;hold on;
swarmchart(ones(100,1),DAN_pf)
hold on
swarmchart(2*ones(100,1),PNsubset)
xlim([0.5 2.5]);
ylim([0 1]);
xticks([1 2]);
set(gca,'XTickLabel',{'DAN','PN'},'Fontsize',15);
ylabel('Classification accuracy','Fontsize',15);
%%
PN_pfall=reshape(PN_pf,10000,1);


s = rng(1);
r = randi([1 10000],1,100);

PN_pfsub=PN_pfall(r,:);

figure;hold on;
swarmchart(ones(100,1),DAN_pf)
hold on
swarmchart(2*ones(10000,1),PN_pfall)
xlim([0.5 2.5]);
ylim([0 1]);
xticks([1 2]);
set(gca,'XTickLabel',{'DAN','PN'},'Fontsize',15);
ylabel('Classification accuracy','Fontsize',15);

figure;hold on;
swarmchart(ones(100,1),DAN_pf)
hold ondd
swarmchart(2*ones(100,1),PN_pfsub)
xlim([0.5 2.5]);
ylim([0 1]);
xticks([1 2]);
set(gca,'XTickLabel',{'DAN','PN'},'Fontsize',15);
ylabel('Classification accuracy','Fontsize',15);
%%
%% value coding

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
conditions=1:3;
name={'fitting','leave one','generalization','fin'};
figure;hold on;
for i=1:4
    subplot(2,2,i)
    bar(conditions,[RsqDAN15(i),RsqPN15(i),RsqPN37(i)],'k');
    xlim([0 4]);
    ylim([0 1]);
    set(gca,'XTickLabel',{'DAN','PN','PN37'},'Fontsize',15);
    ylabel('Rsq value','Fontsize',15);
    title(name(i));
end

%%
    
figure;hold on;
    bar(conditions,[RsqDAN15(i),RsqPN15(i),RsqPN37(i)],'k');
    xlim([0 4]);
    ylim([0 1]);
    set(gca,'XTickLabel',{'DAN','PN','PN37'},'Fontsize',15);
    ylabel('Rsq value','Fontsize',15);
    title(name(i));
%%
figure;hold on;
bar(conditions,[RsqDAN15(3),mean(RsqPN15_n100(:,3),1),RsqPN37(3)],'k');
er = errorbar(2,mean(gg(:,3),1),std(RsqPN15_n100(:,3),1),std(RsqPN15_n100(:,3),1));    
er.Color = [0 0 0];                            
er.LineStyle = 'none';
er.MarkerSize = 1;
hold off
xlim([0 4]);
ylim([0 0.8]);
xticks([1:3]);
set(gca,'XTickLabel',{'DAN','PN15','PN37'},'Fontsize',15);
ssylabel('Rsq value','Fontsize',15)

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