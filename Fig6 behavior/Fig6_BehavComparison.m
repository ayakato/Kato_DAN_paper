%% Change the appreance of the graphs
set(0,'defaultAxesFontName', 'Arial');

%% load the data
%%
%Aversive
%% Comparison of the　VI

set(0,'defaultAxesFontName', 'Helvetica');
trials = 1:3;
figure;hold on;

VIi = squeeze(nanmean(ATPpON.VIO6,3));  % [nOdor nAnimal]
VIMean = nanmean(VIi,1);
VISE = nanstd(VIi,0,1)/sqrt(size(VIi,1));
e=errorbar(trials,VIMean,VISE,'-o','LineWidth',1);
e.Color = 'black';
%plot(VIMean, 'LineWidth', 2);

VIi = squeeze(nanmean(ATPpOFF.VIO6,3));  % [nOdor nAnimal]
VIMean = nanmean(VIi,1);
VISE = nanstd(VIi,0,1)/sqrt(size(VIi,1));
e=errorbar(trials,VIMean,VISE,'--o','LineWidth',1);
e.Color = 'black';
%plot(VIMean, 'LineWidth', 2);

VIi = squeeze(nanmean(ATPmON.VIO6,3));  %% mean 7 trials
VIMean = nanmean(VIi,1);
VISE = nanstd(VIi,0,1)/sqrt(size(VIi,1));
e=errorbar(trials,VIMean,VISE,'-x','LineWidth',1); 
e.Color = [0.6 0.6 0.6];
%plot(VIMean, 'LineWidth', 2);

VIi = squeeze(nanmean(ATPmOFF.VIO6,3));  % [nOdor nAnimal]
VIMean = nanmean(VIi,1);
VISE = nanstd(VIi,0,1)/sqrt(size(VIi,1));
e=errorbar(trials,VIMean,VISE,'--x','LineWidth',1); 
e.Color = [0.6 0.6 0.6];
%plot(VIMean, 'LineWidth', 2);

xlim([0.5 3.5]);
ylim([0 1]);
title('Aversive odor','Fontsize',20);
%legend('ATR+ ON','ATR+ OFF','ATR- ON','ATR- OFF','Fontsize',8);
yticks([0:0.2:1]);
xticks([1:3]);
xlabel('Stimulus Repeat','Fontsize',12)
ylabel('Odor value index','Fontsize',12)
set(gca,'XTickLabel',{'1st','2nd','3rd'},'fontsize',12);

%%
ATPmONVI6=squeeze(nanmean(ATPmON.VIO6,3));
ATPmOFFVI6=squeeze(nanmean(ATPmOFF.VIO6,3));
ATPpONVI6=squeeze(nanmean(ATPpON.VIO6,3));
ATPpOFFVI6=squeeze(nanmean(ATPpOFF.VIO6,3));
% 2-way comparison

label=[ones(size(ATPmONVI6(:,3)));2*ones(size(ATPmOFFVI6(:,3)));3*ones(size(ATPpONVI6(:,3)));4*ones(size(ATPpOFFVI6(:,3)))];
x = [ATPmONVI6(:,1);ATPmOFFVI6(:,1);ATPpONVI6(:,1);ATPpOFFVI6(:,1)];
y = [ATPmONVI6(:,2);ATPmOFFVI6(:,2);ATPpONVI6(:,2);ATPpOFFVI6(:,2)];
z = [ATPmONVI6(:,3);ATPmOFFVI6(:,3);ATPpONVI6(:,3);ATPpOFFVI6(:,3)];

data=[x;y;z];
g1=[label;label;label];
g2=[ones(size(x));2*ones(size(y));3*ones(size(z))];


%[p,tbl,stats] = anovan(data,{g1,g2})

[p,tbl,stats]  = anovan(data,{g1,g2},'model',2,'varnames',{'group','repeat'})

c = multcompare(stats,'CType','tukey-kramer')
r = multcompare(stats,'Dimension',[2])

%%

%%attractive
%% Comparison of the　VI
set(0,'defaultAxesFontName', 'Helvetica');
trials = 1:3;
figure;hold on;

VIi = squeeze(nanmean(ATPpON.VIO1,3));  % [nOdor nAnimal]
VIMean = nanmean(VIi,1);
VISE = nanstd(VIi,0,1)/sqrt(size(VIi,1));
e=errorbar(trials,VIMean,VISE,'-o','LineWidth',1);
e.Color = 'black';
%plot(VIMean, 'LineWidth', 2);


VIi = squeeze(nanmean(ATPpOFF.VIO1,3));  % [nOdor nAnimal]
VIMean = nanmean(VIi,1);
VISE = nanstd(VIi,0,1)/sqrt(size(VIi,1));
e=errorbar(trials,VIMean,VISE,'--o','LineWidth',1);
e.Color = 'black';
%plot(VIMean, 'LineWidth', 2);

VIi = squeeze(nanmean(ATPmON.VIO1,3));  %% mean 7 trials
VIMean = nanmean(VIi,1);
VISE = nanstd(VIi,0,1)/sqrt(size(VIi,1));
e=errorbar(trials,VIMean,VISE,'-x','LineWidth',1); 
e.Color = [0.6 0.6 0.6];
%plot(VIMean, 'LineWidth', 2);

VIi = squeeze(nanmean(ATPmOFF.VIO1,3));  % [nOdor nAnimal]
VIMean = nanmean(VIi,1);
VISE = nanstd(VIi,0,1)/sqrt(size(VIi,1));
e=errorbar(trials,VIMean,VISE,'--x','LineWidth',1); 
e.Color = [0.6 0.6 0.6];
%plot(VIMean, 'LineWidth', 2);

xlim([0.5 3.5]);
ylim([0 1]);
title('Attractive odor','Fontsize',12);
legend('ATR+ ON','ATR+ OFF','ATR- ON','ATR- OFF','Fontsize',8);
yticks([0:0.2:1]);
xticks([1:3]);
xlabel('Stimulus Repeat','Fontsize',12)
ylabel('Odor value index','Fontsize',12)
set(gca,'XTickLabel',{'1st','2nd','3rd'},'fontsize',12);


%%

% 2-way comparison

ATPmONVI6=squeeze(nanmean(ATPmON.VIO1,3));
ATPmOFFVI6=squeeze(nanmean(ATPmOFF.VIO1,3));
ATPpONVI6=squeeze(nanmean(ATPpON.VIO1,3));
ATPpOFFVI6=squeeze(nanmean(ATPpOFF.VIO1,3));

% 2-way comparison

label=[ones(size(ATPmONVI6(:,3)));2*ones(size(ATPmOFFVI6(:,3)));3*ones(size(ATPpONVI6(:,3)));4*ones(size(ATPpOFFVI6(:,3)))];
x = [ATPmONVI6(:,1);ATPmOFFVI6(:,1);ATPpONVI6(:,1);ATPpOFFVI6(:,1)];
y = [ATPmONVI6(:,2);ATPmOFFVI6(:,2);ATPpONVI6(:,2);ATPpOFFVI6(:,2)];
z = [ATPmONVI6(:,3);ATPmOFFVI6(:,3);ATPpONVI6(:,3);ATPpOFFVI6(:,3)];

data=[x;y;z];
g1=[label;label;label];
g2=[ones(size(x));2*ones(size(y));3*ones(size(z))];



[p,tbl,stats]  = anovan(data,{g1,g2},'model',2,'varnames',{'group','repeat'})

c = multcompare(stats,'CType','tukey-kramer')
r = multcompare(stats,'Dimension',[2])
%%
%%Neutral
%% Comparison of the　VI
set(0,'defaultAxesFontName', 'Helvetica');
trials = 1:3;
figure;hold on;

VIi = squeeze(nanmean(ATPpON.VIO9,3));  % [nOdor nAnimal]
VIMean = nanmean(VIi,1);
VISE = nanstd(VIi,0,1)/sqrt(size(VIi,1));
e=errorbar(trials,VIMean,VISE,'-o','LineWidth',1);
e.Color = 'black';
%plot(VIMean, 'LineWidth', 2);


VIi = squeeze(nanmean(ATPpOFF.VIO9,3));  % [nOdor nAnimal]
VIMean = nanmean(VIi,1);
VISE = nanstd(VIi,0,1)/sqrt(size(VIi,1));
e=errorbar(trials,VIMean,VISE,'--o','LineWidth',1);
e.Color = 'black';
%plot(VIMean, 'LineWidth', 2);

VIi = squeeze(nanmean(ATPmON.VIO9,3));  %% mean 7 trials
VIMean = nanmean(VIi,1);
VISE = nanstd(VIi,0,1)/sqrt(size(VIi,1));
e=errorbar(trials,VIMean,VISE,'-x','LineWidth',1); 
e.Color = [0.6 0.6 0.6];
%plot(VIMean, 'LineWidth', 2);

VIi = squeeze(nanmean(ATPmOFF.VIO9,3));  % [nOdor nAnimal]
VIMean = nanmean(VIi,1);
VISE = nanstd(VIi,0,1)/sqrt(size(VIi,1));
e=errorbar(trials,VIMean,VISE,'--x','LineWidth',1); 
e.Color = [0.6 0.6 0.6];
%plot(VIMean, 'LineWidth', 2);

xlim([0.5 3.5]);
ylim([0 1]);
title('Neutral odor','Fontsize',12);
legend('ATR+ ON','ATR+ OFF','ATR- ON','ATR- OFF','Fontsize',8);
yticks([0:0.2:1]);
xticks([1:3]);
xlabel('Stimulus Repeat','Fontsize',12)
ylabel('Odor value index','Fontsize',12)
set(gca,'XTickLabel',{'1st','2nd','3rd'},'fontsize',12);
%%

ATPmONVI6=squeeze(nanmean(ATPmON.VIO9,3));
ATPmOFFVI6=squeeze(nanmean(ATPmOFF.VIO9,3));
ATPpONVI6=squeeze(nanmean(ATPpON.VIO9,3));
ATPpOFFVI6=squeeze(nanmean(ATPpOFF.VIO9,3));


% 2-way comparison

label=[ones(size(ATPmONVI6(:,3)));2*ones(size(ATPmOFFVI6(:,3)));3*ones(size(ATPpONVI6(:,3)));4*ones(size(ATPpOFFVI6(:,3)))];
x = [ATPmONVI6(:,1);ATPmOFFVI6(:,1);ATPpONVI6(:,1);ATPpOFFVI6(:,1)];
y = [ATPmONVI6(:,2);ATPmOFFVI6(:,2);ATPpONVI6(:,2);ATPpOFFVI6(:,2)];
z = [ATPmONVI6(:,3);ATPmOFFVI6(:,3);ATPpONVI6(:,3);ATPpOFFVI6(:,3)];

data=[x;y;z];
g1=[label;label;label];
g2=[ones(size(x));2*ones(size(y));3*ones(size(z))];


%[p,tbl,stats] = anovan(data,{g1,g2})

[p,tbl,stats]  = anovan(data,{g1,g2},'model',2,'varnames',{'group','repeat'})

c = multcompare(stats,'CType','tukey-kramer')
r = multcompare(stats,'Dimension',[2])