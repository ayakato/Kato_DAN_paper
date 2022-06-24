%% 


set(0,'defaultAxesFontName', 'Arial')
%% mean and SD

GrandAverageTrial = mean(AverageS,4);
GT=permute(GrandAverageTrial,[1 2 3 5 4]);

CaRes=zeros(15,20,27,21);
CaresAir=zeros(15,20,21);
CaresMineral=zeros(15,20,21);

CaresAir(:,:,1:10)=GT(:,:,1,:);
CaresAir(:,:,11:21)=GT2(:,:,1,:);
CaresMineral(:,:,1:10)=GT(:,:,10,:);
CaresMineral(:,:,11:21)=GT2(:,:,6,:);

CaRes(:,:,1,:)=CaresAir;
CaRes(:,:,2,:)=CaresMineral;

CaRes(:,:,3:13,1:10)=GT(:,:,[2:9,11:13],:);
CaRes(:,:,14:27,11:21)=GT2(:,:,[2:5,7:16],:);

BrainMean=zeros(15,20,27);
BrainMean(:,:,1:2)=mean(CaRes(:,:,1:2,:),4);
BrainMean(:,:,3:13)=mean(CaRes(:,:,3:13,1:10),4);
BrainMean(:,:,14:27)=mean(CaRes(:,:,14:27,11:21),4);

Arranged=zeros(15,20,27,21);
BrainMeanArranged=zeros(15,20,27);

[B,I] = sort(VI(1:27,1));

for ind=1:27
    Arranged(:,:,ind,:) = CaRes(:,:,I(ind),:);
    BrainMeanArranged(:,:,ind)=BrainMean(:,:,I(ind));
end

%% visualize


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
.1
figure;
for Comp=1:15
    subplot(3,5,Comp); 
    hold on;
    plot(BrainMeanArranged(Comp,:,1),'color',[0.1,0,1],'LineWidth',1);
    plot(BrainMeanArranged(Comp,:,2),'color',[0.4,0.5,1],'LineWidth',1);
    plot(BrainMeanArranged(Comp,:,3),'color',[0.1,0.7,1],'LineWidth',1);
    plot(BrainMeanArranged(Comp,:,25),'color',[1,0.5,0.3],'LineWidth',1);
    plot(BrainMeanArranged(Comp,:,26),'color',[1,0.3,0.7],'LineWidth',1);
    plot(BrainMeanArranged(Comp,:,27),'color',[1,0.1,0.5],'LineWidth',1);
    %legend({'2 pentanone','Banana essence','2-butanal','Butanal','Benzaldehyde','2-methylphenol'},'FontSize',10,'Location','southoutside')
    title([CP_Label{Comp}], 'Fontsize',12);
    ylim([-20 110]);
end
%%
%TrialMean=mean(BrainMeanArranged,4)

figure;
for Comp=1:15
    subplot(3,5,Comp); 
    hold on;
    plot(TrialMean(Comp,:,1),'color',[0,1,0],'LineWidth',1);
    plot(TrialMean(Comp,:,2),'color',[0,1,0.4],'LineWidth',1);
    plot(TrialMean(Comp,:,3),'color',[0,1,0.7],'LineWidth',1);
    plot(TrialMean(Comp,:,25),'color',[1,0.7,1],'LineWidth',1);
    plot(TrialMean(Comp,:,26),'color',[1,0.4,1],'LineWidth',1);
    plot(TrialMean(Comp,:,27),'color',[1,0,1],'LineWidth',1);
    %legend({'2 pentanone','Banana essence','2-butanal','Butanal','Benzaldehyde','2-methylphenol'},'FontSize',10,'Location','southoutside')
    title([CP_Label{Comp}], 'Fontsize',12);
    ylim([-20 110]);
end
%%

     
%% WIth SEM


% plot((Tracemean(CP,:,6)+TraceSEM(CP,:,6)),'color',[0.7,0.7,0.7],'LineWidth',1);
% plot((Tracemean(CP,:,6)-TraceSEM(CP,:,6)),'color',[0.7,0.7,0.7],'LineWidth',1);
%% off response

OnSet=5:7;
OffSet=9:11;
for i=1:3
figure;hold on;
Complist=[1,4,15];
Comp=Complist(i)

subplot(2,2,1)
bar(squeeze(mean(BrainMeanArranged(Comp,OnSet,1:3),2)));
ylim([0 30]);title('attractive onset');
subplot(2,2,2)
bar(squeeze(mean(BrainMeanArranged(Comp,OnSet,25:27),2)));
ylim([0 30]);title('aversive onset');
subplot(2,2,3)
bar(squeeze(mean(BrainMeanArranged(Comp,OffSet,1:3),2)));
ylim([0 30]);title('attractive offset');
subplot(2,2,4)
bar(squeeze(mean(BrainMeanArranged(Comp,OffSet,25:27),2)));
ylim([0 30]);title('aversive offset');
end
%%

%% 
% 

figure; hold on;
for Comp=1:15
    subplot(3,5,Comp); hold on;
    bar(1,mean(Ind(Comp,1:3),2));
    bar(2,mean(Ind(Comp,25:27),2));
    title([CP_Label{Comp}], 'Fontsize',12);
    ylim([5 15]);
end
%%

%%
% OnSet=5:6;
% OffSet=11:12;
OnSet=5:7;
OffSet=11:13;
Complist=[1,4,15];

figure;
for i=1:3
Comp=Complist(i);
subplot(3,3,i); hold on;
bar(1,mean(squeeze(mean(BrainMeanArranged(Comp,OnSet,1:3),2))),'FaceColor',[0.1,0,1]);
bar(2,mean(squeeze(mean(BrainMeanArranged(Comp,OnSet,25:27),2))),'FaceColor',[1,0.1,0.5]);
title([CP_Label{Comp}], 'Fontsize',12);
%set(gca,'XTickLabel',{'Attractive','Aversive'},'Fontsize',8);
ylim([-5 20]);
end

for i=1:3
Comp=Complist(i);
subplot(3,3,i+3); hold on;
bar(1,mean(squeeze(mean(BrainMeanArranged(Comp,OffSet,1:3),2))),'FaceColor',[0.1,0,1]);
bar(2,mean(squeeze(mean(BrainMeanArranged(Comp,OffSet,25:27),2))),'FaceColor',[1,0.1,0.5]);
title([CP_Label{Comp}], 'Fontsize',12);
xticks([1:2]);
%xtickangle(45)
%set(gca,'XTickLabel',{'Attractive','Aversive'},'Fontsize',8);
ylim([-5 20]);
end


for i=1:3
Comp=Complist(i);
    subplot(3,3,i+6); hold on;
    bar(1,mean(Ind(Comp,1:3),2),'FaceColor',[0.1,0,1]);
    bar(2,mean(Ind(Comp,25:27),2),'FaceColor',[1,0.1,0.5]);
    xticks([1:2]);
    %xtickangle(45)
    %set(gca,'XTickLabel',{'Attractive','Aversive'},'Fontsize',8);
    title([CP_Label{Comp}], 'Fontsize',12);
    ylim([5 15]);
end
%%
set(0,'defaultAxesFontName', 'Arial')
OnSet=6:8;
OffSet=10:12;
Complist=[1,4,15];
%Complist=[13,14,15];

%Arranged=squeeze(mean(Arranged,4));

figure;
for i=1:3
Comp=Complist(i);
subplot(2,3,i); hold on;
Res1=squeeze(mean(Arranged(Comp,OnSet,1:3,:),2));
y1 = reshape(Res1,1,63);
y1(y1==0)=[];
Res2=squeeze(mean(Arranged(Comp,OnSet,25:27,:),2));
y2 = reshape(Res2,1,63);
y2(y2==0)=[];
y=[y1 y2];
x1=ones(1,size(y1,2));
x2=3*ones(1,size(y2,2));
swarmchart(x1,y1)
hold on
swarmchart(x2,y2)
plot([0.8 1.2], [mean(y1) mean(y1)], 'k-', 'LineWidth', 3);
plot([2.8 3.2], [mean(y2) mean(y2)], 'k-', 'LineWidth', 3);
hold off
title([CP_Label{Comp}], 'Fontsize',12);
ylim([-15 50]);
xlim([0 4])
end

for i=1:3
Comp=Complist(i);
subplot(2,3,3+i); hold on;
Res1=squeeze(mean(Arranged(Comp,OffSet,1:3,:),2));
y1 = reshape(Res1,1,63);
y1(y1==0)=[];
Res2=squeeze(mean(Arranged(Comp,OffSet,25:27,:),2));
y2 = reshape(Res2,1,63);
y2(y2==0)=[];
y=[y1 y2];
x1=ones(1,size(y1,2));
x2=3*ones(1,size(y2,2));
swarmchart(x1,y1)
hold on
swarmchart(x2,y2)
plot([0.8 1.2], [mean(y1) mean(y1)], 'k-', 'LineWidth', 3);
plot([2.8 3.2], [mean(y2) mean(y2)], 'k-', 'LineWidth', 3);
hold off
title([CP_Label{Comp}], 'Fontsize',12);
ylim([-15 50]);
xlim([0 4])
end

%%
set(0,'defaultAxesFontName', 'Arial')
OnSet=6:8;
OffSet=10:12;
Complist=[1,4,15];
%Complist=[13,14,15];

%Arranged=squeeze(mean(Arranged,4));

figure;
for i=1:3
Comp=Complist(i);
subplot(2,3,i); hold on;
Res1=squeeze(mean(Arranged(Comp,OnSet,1:3,:),2));
y1 = reshape(Res1,1,63);
y1(y1==0)=[];
Res2=squeeze(mean(Arranged(Comp,OnSet,25:27,:),2));
y2 = reshape(Res2,1,63);
y2(y2==0)=[];
y=[y1 y2];
x1=ones(1,size(y1,2));
x2=3*ones(1,size(y2,2));
swarmchart(x1,y1)
hold on
swarmchart(x2,y2)
plot([0.8 1.2], [median(y1) median(y1)], 'k-', 'LineWidth', 3);
plot([2.8 3.2], [median(y2) median(y2)], 'k-', 'LineWidth', 3);
hold off
title([CP_Label{Comp}], 'Fontsize',12);
ylim([-15 50]);
xlim([0 4])
end

for i=1:3
Comp=Complist(i);
subplot(2,3,3+i); hold on;
Res1=squeeze(mean(Arranged(Comp,OffSet,1:3,:),2));
y1 = reshape(Res1,1,63);
y1(y1==0)=[];
Res2=squeeze(mean(Arranged(Comp,OffSet,25:27,:),2));
y2 = reshape(Res2,1,63);
y2(y2==0)=[];
y=[y1 y2];
x1=ones(1,size(y1,2));
x2=3*ones(1,size(y2,2));
swarmchart(x1,y1)
hold on
swarmchart(x2,y2)
plot([0.8 1.2], [median(y1) median(y1)], 'k-', 'LineWidth', 3);
plot([2.8 3.2], [median(y2) median(y2)], 'k-', 'LineWidth', 3);
hold off
title([CP_Label{Comp}], 'Fontsize',12);
ylim([-15 50]);
xlim([0 4])
end

%%

for i=1:3
Comp=Complist(i);
    subplot(3,3,i+6); hold on;
    bar(1,mean(Ind(Comp,1:3),2));
    bar(2,mean(Ind(Comp,25:27),2));
    title([CP_Label{Comp}], 'Fontsize',12);
    ylim([5 15]);
end
%%

OnSet=5:7;
OffSet=10:12;
Complist=[1,4,15];

figure;hold on;
for i=1:3
Comp=Complist(i);
subplot(3,3,i); hold on;
bar(1,mean(squeeze(mean(BrainMeanArranged(Comp,OnSet,1:3),2))));
bar(2,mean(squeeze(mean(BrainMeanArranged(Comp,OnSet,25:27),2))));
title([CP_Label{Comp}], 'Fontsize',12);
ylim([-5 20]);
end

for i=1:3
Comp=Complist(i);
subplot(3,3,i+3); hold on;
bar(1,mean(squeeze(mean(BrainMeanArranged(Comp,OffSet,1:3),2))));
bar(2,mean(squeeze(mean(BrainMeanArranged(Comp,OffSet,25:27),2))));
title([CP_Label{Comp}], 'Fontsize',12);
ylim([-5 20]);
end


for i=1:3
Comp=Complist(i);
    subplot(3,3,i+6); hold on;
    bar(1,mean(Ind(Comp,1:3),2));
    bar(2,mean(Ind(Comp,25:27),2));
    title([CP_Label{Comp}], 'Fontsize',12);
    ylim([5 15]);
end
%%
% odors=1:3;
% ResMean=squeeze(mean(BrainMeanArranged(Comp,OnSet,1:3),2));
% ResSD=a;
% errorbar(odors,VIMean,VISE); hold on;

%%
At1=Arranged(:,:,1:3,:);
At2=Arranged(:,:,1:3,:);
Aversive=Arranged(:,:,25:27,:);

%%
%% check CaRes was loaded stdの計算

BrainMean=zeros(15,20,27);
BrainMean(:,:,1:2)=mean(CaRes(:,:,1:2,:),4);
BrainSD(:,:,1:2)=std(CaRes(:,:,1:2,:),0,4);
BrainMean(:,:,3:13)=mean(CaRes(:,:,3:13,1:10),4);
BrainSD(:,:,3:13)=std(CaRes(:,:,3:13,1:10),0,4);
BrainMean(:,:,14:27)=mean(CaRes(:,:,14:27,11:21),4);
BrainSD(:,:,14:27)=std(CaRes(:,:,14:27,11:21),0,4);

Arranged=zeros(15,20,27,21);
BrainMeanArranged=zeros(15,20,27);
BrainSDArranged=zeros(15,20,27);

[B,I] = sort(VI(1:27,1));

for ind=1:27
    Arranged(:,:,ind,:) = CaRes(:,:,I(ind),:);
    BrainMeanArranged(:,:,ind)=BrainMean(:,:,I(ind));
    BrainSDArranged(:,:,ind)=BrainSD(:,:,I(ind));
end
%%
%% corr single compartment