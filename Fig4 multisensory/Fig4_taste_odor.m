%% 
%% Set parameters
% 565 ms per Cycle

set(0,'defaultAxesFontName', 'Arial')
%%

%% Change the appreance of the graphs
NumRepeat = 8;   % Number of repeats (blocks) that you want to analyze
NumOdor = 6;  %7  % Including the blank vial
Baseline = 5;
BaselineDuration = 5;
BaselineEnd = 9;
Peak = 11;       % Peak time frame
PeakDuration = 3;
Offset = 15;
OffsetDuration = 3;
climsMin = -20;
climsMax = 200;

OdorLabel = {
'Odor',...
'Taste',...
'O-T0'
};


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
%% Color pallet

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
%% Load the saved mat files

addpath(genpath('D:\Analysis201211-\Rawdata\PE_exp_3'));
[filename,pathname] = uigetfile('C:\Users\ayaka\Dropbox\DANpaper_All_Materials\Fig4 Tastant Integration\*.mat',...
    'Select a mat file to be analyzed','MultiSelect','on');
if iscell(filename) == 0
    NumBrain = 1;            % numel: number of elements
    FileNames{1} = filename;
else
    NumBrain = numel(filename);
    FileNames = filename;
end

% Create an image sequence array
if NumBrain == 1
    load(FileNames{1});
    J = data.DeltaFOverFAll;
    Sequence = zeros([size(J,1) size(J,2) 48 NumBrain]);
    Sequence(:,:,:,1) = data.DeltaFOverFAll(:,:,1:48);    
else 
    load(FileNames{1});
    J = data.DeltaFOverFAll;
    Sequence = zeros([size(J,1) size(J,2) NumRepeat*NumOdor NumBrain]);
    for q = 1:NumBrain;
        load(FileNames{q});
        Sequence(:,:,:,q) = data.DeltaFOverFAll(:,:,1:NumRepeat*NumOdor);
        Percent(q)=data.PercentOverlap;
    end
end
%%

for q = 1:NumBrain;
figure;%colormap viridis;
for i = 1:NumOdor*NumRepeat
    subplot(NumRepeat,NumOdor,i,'Fontsize',7);
    
    imagesc(Sequence(:,:,i,q))
    
    shading flat
    caxis([-20 80]);
 
        set(gca,'YTick',[1:15]);
        set(gca,'XTick',[0:5:25]);
        set(gca,'YTickLabel',CP_Label,'Fontsize',5);
end

end
%% Average across brains and trials

NumCycle = size(J,2);
NumGlomerulus = size(J,1);
AverageSequence = mean(Sequence,4);

figure;%colormap viridis;
for i = 1:NumOdor*NumRepeat
    subplot(NumRepeat,NumOdor,i,'Fontsize',7);
    
    imagesc(AverageSequence(:,:,i))
    
    shading flat
    caxis([-20 80]);
 
        set(gca,'YTick',[1:15]);
        set(gca,'XTick',[0:5:25]);
        set(gca,'YTickLabel',CP_Label,'Fontsize',5);
end


    NumTOdor=48;
    IndMean=AverageSequence(:,:,1:12);

    
    for i=1:12
    IndMean(:,:,i)=mean(AverageSequence(:,:,i:12:NumTOdor),3);
    end
    


    figure;
    for i=1:12
    subplot(2,6,i,'Fontsize',7);
    clims = [-20 80];
    imagesc(IndMean(:,:,i),clims);  
        set(gca,'YTick',[1:15]);
        set(gca,'XTick',[0:5:25]);
        set(gca,'YTickLabel',CP_Label,'Fontsize',12);
    end
    %colormap viridis;
    
    
    TImean=AverageSequence(:,:,1:6);
    TImean(:,:,1)=mean(IndMean(:,:,[1,9]),3);
    TImean(:,:,2)=mean(IndMean(:,:,[2,8]),3);
    TImean(:,:,3)=mean(IndMean(:,:,[3,7]),3);
    TImean(:,:,4)=mean(IndMean(:,:,[4,12]),3);
    TImean(:,:,5)=mean(IndMean(:,:,[5,11]),3);
    TImean(:,:,6)=mean(IndMean(:,:,[6,10]),3);

    figure;
    for i=1:6
    subplot(2,3,i,'Fontsize',7);
    clims = [-20 80];
    imagesc(TImean(:,:,i),clims);  
        set(gca,'YTick',[1:15]);
        set(gca,'XTick',[0:5:25]);
        set(gca,'YTickLabel',CP_Label,'Fontsize',12);
    end
    %colormap viridis;
    
    
%% line plot


figure;
for j = 1:6;
    subplot(2,3,j);
    for i = 1:15;
        hold on;
        plot(TImean(i,:,j),'color',ColorPallet(i,:));
    end
    ylim([-40 200])
end

%%


OdorLabel = {
'apO',...
'Taste',...
'apO-T 2',...
'avO',...
'Taste',...
'avO-T 2'
};

%%
%% Sum

Sum2pen=TImean(:,:,1)+TImean(:,:,2);

figure;colormap jet;

subplot(2,2,1);

    for i = 1:15;
        hold on;
        plot(TImean(i,:,3),'color',ColorPallet(i,:))
    set(gca,'XTick',[0:5:25]);
    ylim([-40 200])
    end

subplot(2,2,2);
    for i = 1:15
        hold on;
        plot(Sum2pen(i,:),'color',ColorPallet(i,:))
    set(gca,'XTick',[0:5:25]);
    ylim([-40 200])
    end

Sum2mp=TImean(:,:,4)+IndMean(:,:,5);

subplot(2,2,3);

    for i = 1:15;
        hold on;
        plot(TImean(i,:,6),'color',ColorPallet(i,:))
    set(gca,'XTick',[0:5:25]);
    ylim([-40 200])
    end

subplot(2,2,4);
    for i = 1:15;
        hold on;
        plot(Sum2mp(i,:),'color',ColorPallet(i,:))
    set(gca,'XTick',[0:5:25]);
    ylim([-40 200])
    end

%%
   
    FirstPeak = mean(TImean(:,11:13,:),2);
    SecondPeak = mean(TImean(:,14:17,:),2);
    
    figure;
    for i=1:15
    subplot(3,5,i)
    bar(FirstPeak(i,:)); 
    title([CP_Label{i}],'Fontsize',10);
    ylim([-40 200])
    end

    figure;
    for i=1:15
    subplot(3,5,i)
    bar(SecondPeak(i,:)); 
    title([CP_Label{i}],'Fontsize',10);
    ylim([-40 200])
    end
%%
   
    FirstPeak = max(TImean(:,10:13,:),[],2);
    SecondPeak = max(TImean(:,14:17,:),[],2);
    
    figure;
    for i=1:15
    subplot(3,5,i)
    bar(FirstPeak(i,:)); 
    title([CP_Label{i}],'Fontsize',10);
    ylim([-40 300])
    end

    figure;
    for i=1:15
    subplot(3,5,i)
    bar(SecondPeak(i,:)); 
    title([CP_Label{i}],'Fontsize',10);
    ylim([-40 300])
    end
%%
%% Sum

Sum2pen=FirstPeak(:,1)+FirstPeak(:,2);
Sum2mp=FirstPeak(:,4)+FirstPeak(:,5);

Comparison=[FirstPeak(:,3),Sum2pen,FirstPeak(:,6),Sum2mp];

    figure;
    for i=1:15
    subplot(3,5,i)
    bar(Comparison(i,:)); 
    title([CP_Label{i}],'Fontsize',10);
    ylim([-40 200])
    end 
    
Sum2pen=SecondPeak(:,1)+SecondPeak(:,2);
Sum2mp=SecondPeak(:,4)+SecondPeak(:,5);

Comparison=[SecondPeak(:,3),Sum2pen,SecondPeak(:,6),Sum2mp];

    figure;
    for i=1:15
    subplot(3,5,i)
    bar(Comparison(i,:)); 
    title([CP_Label{i}],'Fontsize',10);
    ylim([-40 200])
    end 
%% Indivisual difference


    AverageTrial=zeros(15,25,12,NumBrain);
    
    for i=1:12
        AverageTrial(:,:,i,:) = mean(Sequence(:,:,[i,i+12,i+24,i+36],:),3);      
    end
    
    Trialmean=AverageTrial(:,:,1:6,:);
    Trialmean(:,:,1,:)=mean(AverageTrial(:,:,[1,9],:),3);
    Trialmean(:,:,2,:)=mean(AverageTrial(:,:,[2,8],:),3);
    Trialmean(:,:,3,:)=mean(AverageTrial(:,:,[3,7],:),3);
    Trialmean(:,:,4,:)=mean(AverageTrial(:,:,[4,12],:),3);
    Trialmean(:,:,5,:)=mean(AverageTrial(:,:,[5,11],:),3);
    Trialmean(:,:,6,:)=mean(AverageTrial(:,:,[6,10],:),3);
    
    FirstPeak = mean(Trialmean(:,11:13,:,:),2);
    FirstPeakmean=mean(FirstPeak,4);
    FirstPeakSEM=std(FirstPeak,0,4)/sqrt(size(FirstPeak,4));
                 
    
    figure;
    for i=1:15
    subplot(3,5,i)
    bar(FirstPeakmean(i,:));
    hold on
    er = errorbar(1:6,FirstPeakmean(i,:),FirstPeakSEM(i,:));    
    er.Color = [0 0 0];                            
    er.LineStyle = 'none';  
    hold off
    title([CP_Label{i}],'Fontsize',10);
    ylim([-40 180])
    end

%%
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
for CP=1:15
    subplot(3,5,CP); 
    hold on;
    plot(Tracemean(CP,:,1),'color',[0.4,0.5,1],'LineWidth',1);
    plot(Tracemean(CP,:,4),'color',[1,0.1,0.5],'LineWidth',1);
    plot((Tracemean(CP,:,5)+Tracemean(CP,:,2))/2,'color',[0,0,0],'LineWidth',1);
    title([CP_Label{CP}], 'Fontsize',12);
    ylim([-20 120]);
end
%%
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

figure;
for CP=1:15
    subplot(3,5,CP); 
    hold on;
    plot(Tracemean(CP,:,1)+Tracemean(CP,:,2),'color',[0,0,0],'LineWidth',1);
    plot(Tracemean(CP,:,3),'color',[0.4,0.5,1],'LineWidth',1);
    %plot(Tracemean(CP,:,6),'color',[1,0.1,0.5],'LineWidth',1);
    title([CP_Label{CP}], 'Fontsize',12);
    ylim([-20 120]);
end
%%

set(0,'defaultAxesFontName', 'Arial')
timerange=10:13;
Xall= squeeze(mean(Trialmean(:,timerange,1,:)+Trialmean(:,timerange,2,:),2));
Yall= squeeze(mean(Trialmean(:,timerange,3,:),2));
Xsd=std(Xall',0);
Ysd=std(Yall',0);

figure;
hold on;
xlim([-40 80]);
ylim([-40 80]);
xneg=Xsd/2;
xpos=Xsd/2;
yneg=Ysd/2;
ypos=Ysd/2;
X=mean(Xall,2);
Y=mean(Yall,2);
for i=1:15
errorbar(X(i), Y(i),yneg(i),ypos(i),xneg(i),xpos(i),'o','MarkerSize',8,'color',ColorPallet(i,:))
end
refline(1,0)
xlabel('Linear summation','FontSize',15);
ylabel('Combination','FontSize',15);
dx = 1; dy = 1; 
%text(mean(Xall,2)+dx, mean(Yall,2)+dy, CP_Label);
grid on
daspect([1 1 1]);       

timerange=10:13;
Xall= squeeze(mean(Trialmean(:,timerange,4,:)+Trialmean(:,timerange,5,:),2));
Yall= squeeze(mean(Trialmean(:,timerange,6,:),2));
Xsd=std(Xall',0);
Ysd=std(Yall',0);

figure;
hold on;
xlim([-40 90]);
ylim([-40 90]);
xneg=Xsd/2;
xpos=Xsd/2;
yneg=Ysd/2;
ypos=Ysd/2;
X=mean(Xall,2);
Y=mean(Yall,2);
for i=1:15
errorbar(X(i), Y(i),yneg(i),ypos(i),xneg(i),xpos(i),'o','MarkerSize',8,'color',ColorPallet(i,:))
end
refline(1,0)
xlabel('Linear summation','FontSize',15);
ylabel('Combination','FontSize',15);
dx = 1; dy = 1; 
%text(mean(Xall,2)+dx, mean(Yall,2)+dy, CP_Label);
grid on
daspect([1 1 1]);       

%%
set(0,'defaultAxesFontName', 'Arial')

timerange=10:13;
Xall= squeeze(mean(Trialmean(:,timerange,1,:),2));
Yall= squeeze(mean(Trialmean(:,timerange,2,:),2));
Xsd=std(Xall',0);
Ysd=std(Yall',0);

figure;
hold on;
xlim([-20 80]);
ylim([-20 80]);
xneg=Xsd/2;
xpos=Xsd/2;
yneg=Ysd/2;
ypos=Ysd/2;
X=mean(Xall,2);
Y=mean(Yall,2);
for i=1:15
errorbar(X(i), Y(i),yneg(i),ypos(i),xneg(i),xpos(i),'o','MarkerSize',8,'color',ColorPallet(i,:))
end
xlabel('Odor response','FontSize',15);
ylabel('Tastant response','FontSize',15);
dx = 1; dy = 1; 
%text(mean(Xall,2)+dx, mean(Yall,2)+dy, CP_Label);
grid on
daspect([1 1 1]);       

timerange=10:13;
Xall= squeeze(mean(Trialmean(:,timerange,4,:),2));
Yall= squeeze(mean(Trialmean(:,timerange,5,:),2));
Xsd=std(Xall',0);
Ysd=std(Yall',0);

figure;
hold on;
xlim([-30 60]);
ylim([-30 60]);
xneg=Xsd/2;
xpos=Xsd/2;
yneg=Ysd/2;
ypos=Ysd/2;
X=mean(Xall,2);
Y=mean(Yall,2);
for i=1:15
errorbar(X(i), Y(i),yneg(i),ypos(i),xneg(i),xpos(i),'o','MarkerSize',8,'color',ColorPallet(i,:))
end
xlabel('Odor response','FontSize',15);
ylabel('Tastant response','FontSize',15);
dx = 1; dy = 1; 
%text(mean(Xall,2)+dx, mean(Yall,2)+dy, CP_Label);
grid on
daspect([1 1 1]);   

%%

set(0,'defaultAxesFontName', 'Helvetica')
timerange=10:13;
Xall= squeeze(mean(Trialmean(:,timerange,1,:),2));
Yall= squeeze(mean(Trialmean(:,timerange,2,:),2));
Xsd=std(Xall',0);
Ysd=std(Yall',0);

figure;
hold on;
xlim([-20 80]);
ylim([-20 80]);
xneg=Xsd/2;
xpos=Xsd/2;
yneg=Ysd/2;
ypos=Ysd/2;

X=mean(Xall,2);
Y=mean(Yall,2);
for i=1:15
errorbar(X(i), Y(i),yneg(i),ypos(i),xneg(i),xpos(i),'o','MarkerSize',8,'color',ColorPallet(i,:))
end
xlabel('Odor response','FontSize',15);
ylabel('Tastant response','FontSize',15);
dx = 1; dy = 1; 
%text(mean(Xall,2)+dx, mean(Yall,2)+dy, CP_Label);
grid on
daspect([1 1 1]);       

%%