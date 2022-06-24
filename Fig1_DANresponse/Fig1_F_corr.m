CorrValue=zeros(3,15);
for j=1:3
for i=1:15
First=BrainMeanArranged(i,:,:,1);
Other=BrainMeanArranged(i,:,:,j+1);
CorrValue(j,i)=corr2(permute(First,[2 3 1]),permute(Other,[2 3 1]));
end
end
figure;imagesc(CorrValue',[0,1]);
h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
colormap gray;
xticks([1:3])
set(gca,'XTickLabel',{'2','3','4'},'Fontsize',12);
xlabel('Target block#')
yticks([1:15])
set(gca,'YTickLabel',CP_Label,'Fontsize',12);
daspect([1 1 1]); 
colorbar;
CorrValue_temp=CorrValue

%%

ColorPallet = [
  0,0,0;  
  255,0,0; 
  0,255,0; 
  0,0,255; 
  255,255,0; 
  0,255,255; 
  255,0,255; 
  192,192,192; 
  128,128,128; 
  128,0,0; 
  128,128,0; 
  0,128,0; 
  128,0,128; 
  0,128,128; 
  0,0,128
  220,220,220];
ColorPallet = ColorPallet/255;   % The number has to be between 0 and 1

set(0,'defaultAxesFontName', 'Arial')
figure;
    for i = 1:15
        hold on;
        plot(CorrValue(:,i),'color',ColorPallet(i,:));
    end
xticks([1:4])
ylim([0,1])
set(gca,'XTickLabel',{'1','2','3','4'},'Fontsize',12);
xlabel('Target block#')

%%
CorrValue=zeros(3,15,100);
for g=1:100
for j=1:3
rng(g)
for i=1:15
Randi=randperm(27);
First=BrainMeanArranged(i,:,:,1);
Other=BrainMeanArranged(i,:,Randi,j+1);
CorrValue(j,i,g)=corr2(permute(First,[2 3 1]),permute(Other,[2 3 1]));
end
end
end

mCorrValue=mean(CorrValue,3);

figure;imagesc(mCorrValue',[0,1]);
h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
colormap gray;
xticks([1:3])
set(gca,'XTickLabel',{'2','3','4'},'Fontsize',12);
xlabel('Target block#')
yticks([1:15])
set(gca,'YTickLabel',CP_Label,'Fontsize',12);
daspect([1 1 1]); 
colorbar;
%% 
% 


figure;
subplot(1,2,1);
    for i = 1:15
        hold on;
        plot(CorrValue_temp(:,i),'color',ColorPallet(i,:));
    end
xticks([1:4]);
yticks ([0:0.2:1]);
ylim([1,5])
ylim([0,1])
set(gca,'XTickLabel',{'1','2','3','4'},'Fontsize',12);
xlabel('Target block#')

subplot(1,2,2);
    for i = 1:15
        hold on;
        plot(mCorrValue(:,i),'color',ColorPallet(i,:));
    end
xticks([1:4]);
yticks ([0:0.2:1]);
ylim([1,5])
ylim([0,1])
set(gca,'XTickLabel',{'1','2','3','4'},'Fontsize',12);
xlabel('Target block#')
%%

CorrValue1and2=zeros(3,15,21);
for ind=1:10
temp=GrandT1(:,:,:,:,ind);
for j=1:3
for i=1:15
First=temp(i,:,:,1);
Other=temp(i,:,:,j+1);
CorrValue1and2(j,i,ind)=corr2(permute(First,[2 3 1]),permute(Other,[2 3 1]));
end
end
end

for ind=1:11
temp=GrandT2(:,:,:,:,ind);
for j=1:3
for i=1:15
First=temp(i,:,:,1);
Other=temp(i,:,:,j+1);
CorrValue1and2(j,i,ind+10)=corr2(permute(First,[2 3 1]),permute(Other,[2 3 1]));
end
end
end

AverageInd=mean(CorrValue1and2,3)

figure;imagesc(AverageInd',[0,1]);
h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
colormap gray;
xticks([1:3])
set(gca,'XTickLabel',{'2','3','4'},'Fontsize',12);
xlabel('Target block#')
yticks([1:15])
set(gca,'YTickLabel',CP_Label,'Fontsize',12);
daspect([1 1 1]); 
colorbar;
%%
CorrValue1and2=zeros(3,15,21);
for ind=1:10
temp=squeeze(mean(GrandT1(:,5:9,:,:,ind),2));
for j=1:3
for i=1:15
First=temp(i,:,1);
Other=temp(i,:,j+1);
CorrValue1and2(j,i,ind)=corr(permute(First,[2 3 1]),permute(Other,[2 3 1]));
end
end
end

for ind=1:11
temp=squeeze(mean(GrandT2(:,5:9,:,:,ind),2));
for j=1:3
for i=1:15
First=temp(i,:,1);
Other=temp(i,:,j+1);
CorrValue1and2(j,i,ind+10)=corr2(permute(First,[2 3 1]),permute(Other,[2 3 1]));
end
end
end

AverageInd=mean(CorrValue1and2,3)

figure;imagesc(AverageInd',[0,1]);
h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
colormap gray;
xticks([1:3])
set(gca,'XTickLabel',{'2','3','4'},'Fontsize',12);
xlabel('Target block#')
yticks([1:15])
set(gca,'YTickLabel',CP_Label,'Fontsize',12);
daspect([1 1 1]); 
colorbar;
%%
CorrValue1and2=zeros(3,15,21,100);
for g=1:100
for ind=1:10
temp=squeeze(mean(GrandT1(:,5:9,:,:,ind),2));
for j=1:3
for i=1:15
    rng(g)
Randi=randperm(16);
First=temp(i,:,1);
Other=temp(i,Randi,j+1);
CorrValue1and2(j,i,ind,g)=corr(permute(First,[2 3 1]),permute(Other,[2 3 1]));
end
end
end
end

for g=1:100
for ind=1:11
temp=squeeze(mean(GrandT2(:,5:9,:,:,ind),2));
for j=1:3
for i=1:15
    rng(g)
Randi=randperm(16);
First=temp(i,:,1);
Other=temp(i,Randi,j+1);
CorrValue1and2(j,i,ind+10,g)=corr2(permute(First,[2 3 1]),permute(Other,[2 3 1]));
end
end
end
end

AverageRand=mean(CorrValue1and2,4)
SAverageInd=mean(AverageRand,3)

figure;imagesc(SAverageInd',[0,1]);
h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
colormap gray;
xticks([1:3])
set(gca,'XTickLabel',{'2','3','4'},'Fontsize',12);
xlabel('Target block#')
yticks([1:15])
set(gca,'YTickLabel',CP_Label,'Fontsize',12);
daspect([1 1 1]); 
colorbar;
%%
figure;
subplot(1,2,1);
    for i = 1:15
        hold on;
        plot(AverageInd(:,i),'color',ColorPallet(i,:));
    end
xticks([1:4]);
yticks ([0:0.2:1]);
ylim([1,5])
ylim([-0.1,1])
set(gca,'XTickLabel',{'1','2','3','4'},'Fontsize',12);
xlabel('Target block#')

subplot(1,2,2);
    for i = 1:15
        hold on;
        plot(SAverageInd(:,i),'color',ColorPallet(i,:));
    end
xticks([1:4]);
yticks ([0:0.2:1]);
ylim([1,5])
ylim([-0.1,1])
set(gca,'XTickLabel',{'1','2','3','4'},'Fontsize',12);
xlabel('Target block#')
%%
MeanOnset=squeeze(mean(BrainMeanArranged(:,5:9,:,:),2));

CorrValue=zeros(3,15);
for j=1:3
for i=1:15
First=MeanOnset(i,:,1);
Other=MeanOnset(i,:,j+1);
CorrValue(j,i)=corr(permute(First,[2 1 3]),permute(Other,[2 1 3]));
end
end
figure;imagesc(CorrValue',[0,1]);
h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
colormap gray;
xticks([1:3])
set(gca,'XTickLabel',{'2','3','4'},'Fontsize',12);
xlabel('Target block#')
yticks([1:15])
set(gca,'YTickLabel',CP_Label,'Fontsize',12);
daspect([1 1 1]); 
colorbar;
CorrValue_mean_solid=CorrValue;
%%

MeanOnset=squeeze(mean(BrainMeanArranged(:,5:9,:,:),2));

CorrValue=zeros(3,15,100);
for g=1:100
for j=1:3
rng(g)
for i=1:15
Randi=randperm(27);
First=MeanOnset(i,:,1);
Other=MeanOnset(i,Randi,j+1);
CorrValue(j,i,g)=corr(First',Other');
end
end
end

mCorrValue=mean(CorrValue,3);

figure;imagesc(mCorrValue',[0,1]);
h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
colormap gray;
xticks([1:3])
set(gca,'XTickLabel',{'2','3','4'},'Fontsize',12);
xlabel('Target block#')
yticks([1:15])
set(gca,'YTickLabel',CP_Label,'Fontsize',12);
daspect([1 1 1]); 
colorbar;

%% 
% 

figure;
subplot(1,2,1);
    for i = 1:15
        hold on;
        plot(CorrValue_mean_solid(:,i),'color',ColorPallet(i,:));
    end
xticks([1:4]);
yticks ([0:0.2:1]);
ylim([1,5])
ylim([-0.1,1])
set(gca,'XTickLabel',{'1','2','3','4'},'Fontsize',12);
xlabel('Target block#')

subplot(1,2,2);
    for i = 1:15
        hold on;
        plot(mCorrValue(:,i),'color',ColorPallet(i,:));
    end
xticks([1:4]);
yticks ([0:0.2:1]);
ylim([1,5])
ylim([-0.1,1])
set(gca,'XTickLabel',{'1','2','3','4'},'Fontsize',12);
xlabel('Target block#')
%%
kruskalwallis(CorrValue_mean_solid')

FriedMat=[reshape(CorrValue_mean_solid,[45,1]),reshape(mCorrValue,[45,1])]

friedman(FriedMat,15)