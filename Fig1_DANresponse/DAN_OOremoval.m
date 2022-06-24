%% Analysis of data

display('Analyzing data...');
%% Set parameters
% 565 ms per Cycle

NumRepeat = 4;   % Number of repeats (blocks) that you want to analyze
NumOdor = 16;    % Including the blank vial
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

figure;colormap gray;
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

    OO(:,:,:,1)=mean(AverageSequenceBlock(:,:,:,1:2),4);
    OO(:,:,:,2)=mean(AverageSequenceBlock(:,:,:,3:4),4);

for i = 1:NumOdor*2
    subplot(2,NumOdor,i,'Fontsize',7);
    clims = [-10 40];
    k = mod(i,NumOdor);
    if (mod(i,NumOdor) == 0)
        k = NumOdor;
    end

    imagesc(OO(:,2:20,k,ceil(i/NumOdor)),clims);
    set(gca,'YTick',[]);
    set(gca,'XTick',[]);
    shading flat
    
    if i <= NumOdor
        title([OdorLabel{i}],'Fontsize',10);
    end

end
%% 
% 


clims = [-10 30];
set(0,'defaultAxesFontName', 'Arial')
figure;colormap gray;

 subplot(2,1,1,'Fontsize',7);
 imagesc(squeeze(mean(OO(:,5:9,1:13,1),2)),clims);
 h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
 subplot(2,1,2,'Fontsize',7);
 imagesc(squeeze(mean(OO(:,5:9,1:13,2),2)),clims);
h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];


for i = 12:13
    figure;
    for j=1:15
    subplot(3,5,j,'Fontsize',10);
    title(['    ' CP_Label{j}], 'Fontsize',12);
    hold on
    plot(AverageSequenceBlock(j,:,i,1),'Color',[0 0 0]);
    plot(AverageSequenceBlock(j,:,i,2),'Color',[0.5 0.5 0.5]);
    plot(AverageSequenceBlock(j,:,i,3),'Color',[0 0 1]);
    plot(AverageSequenceBlock(j,:,i,4),'Color',[0 0.6 1]);
    ylim([-20 120])
    
    if j == 1
        ylabel([OdorLabel{i}],'Fontsize',18);
    end
    
    end 
end
%%
SequenceA=permute(AverageS,[1 2 3 5 4]);

intact = mean(SequenceA(:,:,:,:,1:2),5);
removed = mean(SequenceA(:,:,:,:,3:4),5);

m_intact=mean(intact,4);
sem_intact=std(intact,0,4)/sqrt(6);

m_removed=mean(removed,4);
sem_removed=std(removed,0,4)/sqrt(6);

for i = 12:13
    figure;
    for j=1:15
    subplot(3,5,j,'Fontsize',10);
    title(['    ' CP_Label{j}], 'Fontsize',12);
    hold on
    plot(m_intact(j,:,i),'Color',[0 0 0]);
    plot(m_intact(j,:,i)+sem_intact(j,:,i),'Color',[0.5 0.5 0.5]);
    plot(m_intact(j,:,i)-sem_intact(j,:,i),'Color',[0.5 0.5 0.5]);
    plot(m_removed(j,:,i)+sem_removed(j,:,i),'Color',[1 0.8 1]);
    plot(m_removed(j,:,i)-sem_removed(j,:,i),'Color',[1 0.8 1]);
    plot(m_intact(j,:,i),'Color',[0 0 0]);
    plot(m_removed(j,:,i),'Color',[1 0 1]);
    h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
    ylim([-20 120])
    
    if j == 1
        ylabel([OdorLabel{i}],'Fontsize',18);
    end
    
    end 
end
