%% Analysis of data

display('Analyzing data...');
%% Set parameters
% 565 ms per Cycle

NumRepeat = 4;   % Number of repeats (blocks) that you want to analyze
NumOdor = 16;    % Including the blank vial
Baseline = 2;
BaselineDuration = 3;
climsMin = -20;
climsMax = 200;

OdorLabel = {
'air (empty vial)',...
'2-pentanone',...
'ethyl butyrate',...
'2-methylphenol',...
'Apple cider vinegar',...
'ethyl acetate',...
'3-methylthio-1-propanol',...
'3-octanol',...
'propionic acid',...
'mineral oil',...
'water',...
'MCH',...
'BNZ',...
'EtOH6',...
'EtOH3',...
'EtOH0'
};

% OdorLabel = {
% 'air (empty vial)',...
% '2-butanone',...
% 'Banana Essence',...
% 'Pentyl Acetate',...
% 'Methyl Salicilate',...
% 'Mineral Oil',...
% 'Isopentyl Acetate',...
% 'Benzyl Alcohol',...
% '1-butanol',...
% 'Linalool',...
% 'g-butyrolactone',...
% 'Methanoic acid',...
% 'Hexyl Acetate',...
% '1-octanol',...
% 'Acetophenone',...
% 'Butanal',...
% };



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

addpath(genpath('C:\Users\ayaka\Dropbox\DANpaper_All_Materials\Fig1 DAN data\DAN rawdata&codes'));
[filename,pathname] = uigetfile('C:\Users\ayaka\Dropbox\DANpaper_All_Materials\Fig1 DAN data\DAN rawdata&codes\*.mat',...
    'Select a mat file to be analyzed','MultiSelect','on');
if iscell(filename) == 0
    NumBrain = 1;            % numel: number of elements
    FileNames{1} = filename;
else
    NumBrain = numel(filename);
    FileNames = filename;
end

Percent=zeros(1,NumBrain);

% Create an image sequence array
if NumBrain == 1
    load(FileNames{1});
    J = data.DeltaFOverFAll;
    Sequence = zeros([size(J,1) size(J,2) NumRepeat*NumOdor NumBrain]);
    Sequence(:,:,:,1) = data.DeltaFOverFAll(:,:,1:NumRepeat*NumOdor);    
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
%% Average across brains and trials

NumCycle = size(J,2);
NumGlomerulus = size(J,1);
AverageSequence = mean(Sequence,4);
AverageSequenceBlock = zeros([size(J,1) size(J,2) NumOdor NumRepeat],'double');

% Reorder the trials
rng('default');
rng(46); trialOrder(:,1) = randperm(NumOdor)';
rng(30); trialOrder(:,2) = randperm(NumOdor)';
rng(20); trialOrder(:,3) = randperm(NumOdor)';
rng(5); trialOrder(:,4) = randperm(NumOdor)';

for i = 1:NumRepeat
    AverageSequenceBlock(:,:,trialOrder(:,i),i) = AverageSequence(:,:,NumOdor*(i-1)+1:NumOdor*i);
end

GrandAverageSequence = mean(AverageSequenceBlock,4);
%% Average across trials, not brain

NumCycle = size(J,2);
NumGlomerulus = size(J,1);
AverageS = zeros([size(J,1) size(J,2) NumOdor NumRepeat NumBrain],'double');

% Reorder the trials
rng('default');
rng(46); trialOrder(:,1) = randperm(NumOdor)';
rng(30); trialOrder(:,2) = randperm(NumOdor)';
rng(20); trialOrder(:,3) = randperm(NumOdor)';
rng(5); trialOrder(:,4) = randperm(NumOdor)';

for j=1:NumBrain
for i = 1:NumRepeat
    AverageS(:,:,trialOrder(:,i),i,:) = Sequence(:,:,NumOdor*(i-1)+1:NumOdor*i,:);
end
end

GrandAverageTrial = mean(AverageS,4);
GT2=permute(GrandAverageTrial,[1 2 3 5 4]);
%% Visualize DeltaF over F

figure;colormap parula;
h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
for i = 1:NumOdor*NumRepeat
    subplot(NumRepeat,NumOdor,i,'Fontsize',7);
    clims = [-20 80];
    k = mod(i,NumOdor);
    if (mod(i,NumOdor) == 0)
        k = NumOdor;
    end
    imagesc(AverageSequenceBlock(:,:,k,ceil(i/NumOdor)),clims);
    set(gca,'YTick',[]);
    set(gca,'XTick',[]);
    shading flat
    
    if i <= NumOdor
        title([OdorLabel{i}],'Fontsize',15,'Rotation',15);
    end
    
    if mod(i,NumOdor) == 1
        ylabel(['block' num2str(ceil(i/NumOdor))],'Fontsize',15);
    end
end
%%
set(0,'defaultAxesFontName', 'Arial')
figure;colormap parula;
h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];

    OO(:,:,:,1)=mean(AverageSequenceBlock(:,:,:,1:4),4);

for i = 1:NumOdor
    subplot(1,NumOdor,i,'Fontsize',7);
    clims = [-10 40];
    k = mod(i,NumOdor);
    if (mod(i,NumOdor) == 0)
        k = NumOdor;
    end

    imagesc(OO(:,2:20,k,ceil(i/NumOdor)),clims);
    set(gca,'YTick',[]);
    set(gca,'XTick',[]);
    shading flat
   

end
%% 
% 


set(0,'defaultAxesFontName', 'Arial')
figure;colormap gray;

 subplot(1,1,1,'Fontsize',7);
 imagesc(squeeze(mean(OO(:,5:9,1:13,1),2)),clims);
 h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
%%
%Response24h=AverageSequenceBlock;
%Response0h=AverageSequenceBlock;
%Response4h=AverageSequenceBlock;

set(0,'defaultAxesFontName', 'Arial')

Res24h=squeeze(mean(Response24h(:,5:9,1:13,1),2));
Res0h=squeeze(mean(Response0h(:,5:9,1:13,1),2));
Res4h=squeeze(mean(Response4h(:,5:9,1:13,1),2));

CorrMatrix33=zeros(3,3);

CorrMatrix33(1,1)=corr2(Res0h,Res0h);
CorrMatrix33(1,2)=corr2(Res0h,Res4h);
CorrMatrix33(1,3)=corr2(Res0h,Res24h);
CorrMatrix33(2,1)=corr2(Res4h,Res0h);
CorrMatrix33(2,2)=corr2(Res4h,Res4h);
CorrMatrix33(2,3)=corr2(Res4h,Res24h);
CorrMatrix33(3,1)=corr2(Res24h,Res0h);
CorrMatrix33(3,2)=corr2(Res24h,Res4h);
CorrMatrix33(3,3)=corr2(Res24h,Res24h);

figure;colormap gray;
imagesc(CorrMatrix33,[0,1]);
h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
daspect([1 1 1])

x = diag(corr(Res24h',Res0h'))


figure;
colormap parula
clims = [0, 1];
imagesc(x,clims);
yticks([1:15])
set(gca,'YTickLabel',CP_Label,'Fontsize',15);
daspect([1 1 1])
colorbar;


set(0,'defaultAxesFontName', 'Arial')
figure;colormap gray;

clims = [-10, 30];
 subplot(1,3,1,'Fontsize',7);
 imagesc(Res0h,clims);
 h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
 daspect([1 1 1])
 
 subplot(1,3,2,'Fontsize',7);
 imagesc(Res4h,clims);
 h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
 daspect([1 1 1])
 
 subplot(1,3,3,'Fontsize',7);
 imagesc(Res24h,clims);
 h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
 daspect([1 1 1])
 
%% 
% 

figure;
colormap parula
clims = [-3,3];
imagesc((Res24h-Res0h)./Res0h,clims);
yticks([1:15])
set(gca,'YTickLabel',CP_Label,'Fontsize',15);
daspect([1 1 1])
colorbar;


for i = 3:10:16
    figure;
    for j=1:15
    subplot(3,5,j,'Fontsize',10);
    title(['    ' CP_Label{j}], 'Fontsize',12);
    hold on
    plot(AverageSequenceBlock(j,:,i,1),'k');
    plot(AverageSequenceBlock(j,:,i,2),'r');
    plot(AverageSequenceBlock(j,:,i,3),'g');
    plot(AverageSequenceBlock(j,:,i,4),'b');
    ylim([-20 120])
    
    if j == 1
        ylabel([OdorLabel{i}],'Fontsize',18);
    end
    
    end 
end
