
%% Analysis of data
display('Analyzing data...');

%% Set parameters
% 565 ms per Cycle
NumRepeat = 4;   % Number of repeats (blocks) that you want to analyze
NumOdor = 16;    % Including the blank vial
Baseline = 2;
BaselineDuration = 3;
BaselineEnd = 5;
Peak = 6;       % Peak time frame
PeakDuration = 3;
Offset = 9;
OffsetDuration = 3;
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
'Éø3',...
'Éøp3',...
'Éø2',...
'Éøp2',...
'Éø1',...
'Éøp1',...
'É¡1',...
'É¡2',...
'É¡3',...
'É¡4',...
'É¡5',...
'É¿1',...
'É¿p1',...
'É¿2',...
'É¿p2'
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

figure;colormap jet;
for i = 1:NumOdor*NumRepeat
    subplot(NumRepeat,NumOdor,i,'Fontsize',7);
    clims = [-20 80];
    k = mod(i,NumOdor);
    if (mod(i,NumOdor) == 0)
        k = NumOdor;
    end
    imagesc(AverageSequenceBlock(:,:,k,ceil(i/NumOdor)),clims);
    set(gca,'YTick',[]);
    %set(gca,'YTickLabel',NP225PositiveGlomeruliName);
    set(gca,'XTick',[]);
    shading flat
    
    if i <= NumOdor
        title(['        ' OdorLabel{i}],'Fontsize',15,'Rotation',15);
    end
    
    if mod(i,NumOdor) == 1
        ylabel(['block' num2str(ceil(i/NumOdor))],'Fontsize',10);
    end
end
% 
% h=gcf;
% set(h,'PaperOrientation','landscape');
% set(h,'PaperUnits','normalized');
% set(h,'PaperPosition', [0 0 1 1]);
% print(h, '-dpdf', 'fig1');

%% Plot the average
figure;colormap jet;
for i = 1:NumOdor
    subplot(2,8,i,'Fontsize',7);
    clims = [-20 80];
    imagesc(GrandAverageSequence(:,:,i),clims);
    yticks([1:15])
    set(gca,'YTickLabel',CP_Label,'Fontsize',12);
    xticks([0:5:20])
    set(gca,'YTickLabel',CP_Label,'Fontsize',12);
    shading flat
%     if i == 1
%         set(gca,'YTick',1:36);
%        % set(gca,'YTicoppkLabel',NP225PositiveGlomeruliName);
%     end
    
    if i <= NumOdor
        title(['        ' OdorLabel{i}],'Fontsize',15);
    end
end
colorbar;

% h=gcf;
% set(h,'PaperOrientation','landscape');
% set(h,'PaperUnits','normalized');
% set(h,'PaperPosition', [0 0 1 1]);
% print(h, '-dpdf', 'fig2');


for i = 5:7:16
    figure;
    for j=1:15
    subplot(3,5,j,'Fontsize',10);
    title(['    ' CP_Label{j}], 'Fontsize',12);
    hold on
    plot(AverageSequenceBlock(j,:,i,1),'k');
    plot(AverageSequenceBlock(j,:,i,2),'r');
    plot(AverageSequenceBlock(j,:,i,3),'g');
    plot(AverageSequenceBlock(j,:,i,4),'b');
    ylim([-20 100])
    
    if j == 1
        ylabel([OdorLabel{i}],'Fontsize',18);
    end
    
    end 
end


%% Calculating correlation coefficient and distance
CorrCoeffPeak = zeros(NumOdor*NumRepeat,NumOdor*NumRepeat);
CorrCoeffOffset = zeros(NumOdor*NumRepeat,NumOdor*NumRepeat);
CorrCoeffPeakMean = zeros(NumOdor,NumOdor);
CorrCoeffOffsetMean = zeros(NumOdor,NumOdor);

DistancePeak = zeros(NumOdor*NumRepeat,NumOdor*NumRepeat);
DistanceOffset = zeros(NumOdor*NumRepeat,NumOdor*NumRepeat);
DistancePeakMean = zeros(NumOdor,NumOdor);
DistanceOffsetMean = zeros(NumOdor,NumOdor);

for ix = 1:NumOdor
    for jx = 1:NumRepeat
        for iy = 1:NumOdor
            for jy = 1:NumRepeat
                % CorrCoeffPeak
                CorrCoeffPeakTemp = corrcoef(AverageSequenceBlock(:,Peak:Peak+PeakDuration-1,ix,jx),...
                    AverageSequenceBlock(:,Peak:Peak+PeakDuration-1,iy,jy));
                CorrCoeffPeak((ix-1)*NumRepeat+jx,(iy-1)*NumRepeat+jy) = CorrCoeffPeakTemp(1,2);
                % CorrCoeffOffset
                CorrCoeffOffsetTemp = corrcoef(AverageSequenceBlock(:,Offset:Offset+OffsetDuration-1,ix,jx),...
                    AverageSequenceBlock(:,Offset:Offset+OffsetDuration-1,iy,jy));
                CorrCoeffOffset((ix-1)*NumRepeat+jx,(iy-1)*NumRepeat+jy) = CorrCoeffOffsetTemp(1,2);
                
                % DistancePeak
                DistancePeakTemp = norm(AverageSequenceBlock(:,Peak:Peak+PeakDuration-1,ix,jx)-...
                    AverageSequenceBlock(:,Peak:Peak+PeakDuration-1,iy,jy));
                DistancePeak((ix-1)*NumRepeat+jx,(iy-1)*NumRepeat+jy) = DistancePeakTemp;
                % DistanceOffset
                DistanceOffsetTemp = norm(AverageSequenceBlock(:,Offset:Offset+OffsetDuration-1,ix,jx)-...
                    AverageSequenceBlock(:,Offset:Offset+OffsetDuration-1,iy,jy));
                DistanceOffset((ix-1)*NumRepeat+jx,(iy-1)*NumRepeat+jy) = DistanceOffsetTemp;
            end
        end
    end
end

for i = 1:NumOdor
    for j = 1:NumOdor
        if i == j
            CorrCoeffPeakMean(i,j) = mean(mean(triu(CorrCoeffPeak((i-1)*NumRepeat+1:i*NumRepeat,(j-1)*NumRepeat+1:j*NumRepeat),1),2),1);
            CorrCoeffOffsetMean(i,j) = mean(mean(triu(CorrCoeffOffset((i-1)*NumRepeat+1:i*NumRepeat,(j-1)*NumRepeat+1:j*NumRepeat),1),2),1);
            DistancePeakMean(i,j) = mean(mean(triu(DistancePeak((i-1)*NumRepeat+1:i*NumRepeat,(j-1)*NumRepeat+1:j*NumRepeat),1),2),1);
            DistanceOffsetMean(i,j) = mean(mean(triu(DistanceOffset((i-1)*NumRepeat+1:i*NumRepeat,(j-1)*NumRepeat+1:j*NumRepeat),1),2),1);
        end
        CorrCoeffPeakMean(i,j) = mean(mean(CorrCoeffPeak((i-1)*NumRepeat+1:i*NumRepeat,(j-1)*NumRepeat+1:j*NumRepeat),2),1);
        CorrCoeffOffsetMean(i,j) = mean(mean(CorrCoeffOffset((i-1)*NumRepeat+1:i*NumRepeat,(j-1)*NumRepeat+1:j*NumRepeat),2),1);
        DistancePeakMean(i,j) = mean(mean(DistancePeak((i-1)*NumRepeat+1:i*NumRepeat,(j-1)*NumRepeat+1:j*NumRepeat),2),1);
        DistanceOffsetMean(i,j) = mean(mean(DistanceOffset((i-1)*NumRepeat+1:i*NumRepeat,(j-1)*NumRepeat+1:j*NumRepeat),2),1);
    end
end

figure;
clims2 = [min(CorrCoeffPeakMean(:)) 1];
clims3 = [0 max(DistancePeakMean(:))];

subplot(2,2,1);
imagesc(CorrCoeffPeakMean,clims2);
title('Correlation coefficient (Peak)');
axis image;
subplot(2,2,2);
imagesc(CorrCoeffOffsetMean,clims2);
title('Correlation coefficient (Odor offset)');
axis image;
colorbar;
subplot(2,2,3);
imagesc(DistancePeakMean,clims3);
title('Distance (Peak)');
axis image;
subplot(2,2,4);
imagesc(DistanceOffsetMean,clims3);
title('Distance (Odor offset)');
axis image;
colorbar;

% h=gcf;
% set(h,'PaperOrientation','landscape');
% set(h,'PaperUnits','normalized');
% set(h,'PaperPosition', [0 0 1 1]);
% print(h, '-dpdf', 'fig3');




%% Perform Principal component analysis
Response = zeros(NumCycle*NumOdor,NumGlomerulus);
GrandAverageSequence = permute(GrandAverageSequence,[2 1 3]);

%Response(:,36) = [];   % currently 36th glomeruli contains NaN (VM1 is very small)

for i = 1:NumOdor;
        Response(((i-1)*NumCycle+1):i*NumCycle,:) = GrandAverageSequence(:,:,i);
end

%% PCA
% PCA1: Perform PCA using covariance.
% data - MxN matrix of input data
% (M dimensions, N trials)
% signals - MxN matrix of projected data
% PC - each column is a PC
% V - Mx1 matrix of variances
Response = Response';
[M,N] = size(Response);

% subtract off the mean for each dimension
mn = mean(Response,2);
Response = Response - repmat(mn,1,N);
% Response = Response./repmat(sd,1,N);

% calculate the covariance matrix
covariance = 1 / (N-1) * Response * Response';

% find the eigenvectors and eigenvalues
[PC, V] = eig(covariance);

% extract diagonal of matrix as vector
V = diag(V);

% sort the variances in decreasing order
[junk, rindices] = sort(-1*V);
V = V(rindices);
PC = PC(:,rindices);

% project the original data set
score1 = PC' * Response;
score1 = score1';

VarianceExplained = V./sum(V);
display(['Variance explained  ' num2str(VarianceExplained(1:5)')]);

%% Plot PC scores
figure;
for j = 1:3;   % plot the first 3 PC scores
    subplot(2,4,j);
    title(['PC' num2str(j)]);
    for i = 1:NumOdor;
        hold on;
        plot(score1(((i-1)*NumCycle+1):i*NumCycle,j),...
            'color',ColorPallet(i,:));
        axis([0 NumCycle min(score1(:,j)) max(score1(:,j))]);
    end
    if j == 3
        [legh,objh,outh,outm] = legend(OdorLabel,'Location','EastOutside');
        set(objh,'linewidth',3);   % changing the linewidth of legend
    end
end

%% All plots (three 2D plots)
combination = [2 1;3 1;2 3];

for j = 1:3
    subplot(2,4,j+4);
    title(['PC' num2str(combination(j,1)) ' vs ' 'PC' num2str(combination(j,2))]);
    xlabel(['PC' num2str(combination(j,1))]);
    ylabel(['PC' num2str(combination(j,2))]);
    for i = 1:NumOdor;
        hold on;
        plot(score1(((i-1)*NumCycle+1):i*NumCycle,combination(j,1)),score1(((i-1)*NumCycle+1):i*NumCycle,combination(j,2)),...
            'color',ColorPallet(i,:));    
        hold on;
        plot(score1(((i-1)*NumCycle+1):i*NumCycle,combination(j,1)),score1(((i-1)*NumCycle+1):i*NumCycle,combination(j,2)),...
            '.','MarkerSize',10,'color',ColorPallet(i,:));
        axis([min(score1(:,combination(j,1))) max(score1(:,combination(j,1))) min(score1(:,combination(j,2))) max(score1(:,combination(j,2)))]);
        axis equal;
    end
end

% h=gcf;
% set(h,'PaperOrientation','landscape');
% set(h,'PaperUnits','normalized');
% set(h,'PaperPosition', [0 0 1 1]);
% print(h, '-dpdf', 'fig4');

%% PCA at different time points
%Peak
figure;
Peak = 6;   % Analyzing every 2 s. Odor valve is switched on at 9.5 frames. Odor stimulation is 4 s (~8 frames) long.
NumberOfAnalysis = 6;
PeakDuration = 2;
for j = 1:NumberOfAnalysis;
    subplot(2,4,j);
    for i = 1:NumOdor;
        hold on;
        MeanScore = mean(score1(((i-1)*NumCycle+Peak+(j-1)*PeakDuration):((i-1)*NumCycle+Peak+(j-1)*PeakDuration+PeakDuration-1),:),1);
        plot3(MeanScore(1),MeanScore(2),MeanScore(3),...
            '.','MarkerSize',30,'color',ColorPallet(i,:));
        MeanPC1(i,1) = MeanScore(1);
        MeanPC1(i,2) = MeanScore(2);
        MeanPC1(i,3) = MeanScore(3);
    end
    title([num2str(Peak + (j-1)*PeakDuration) ' frame']);
    axis([min(score1(:,1))-20 max(score1(:,1))+20 min(score1(:,2))-20 max(score1(:,2))+20]);
    axis equal;
end

xlabel('PC1');
ylabel('PC2');
zlabel('PC3');

% h=gcf;
% set(h,'PaperOrientation','landscape');
% set(h,'PaperUnits','normalized');
% set(h,'PaperPosition', [0 0 1 1]);
% print(h, '-dpdf', 'fig5');

%% Plot individual odor responses in PC space
% All plots (3D plots)
figure;
for i = 1:NumOdor;
    subplot(4,ceil(NumOdor/4),i,'Fontsize',7);
    title(OdorLabel{i},'Fontsize',9);
    hold on;
    plot3(score1(((i-1)*NumCycle+1):i*NumCycle,1),score1(((i-1)*NumCycle+1):i*NumCycle,2),score1(((i-1)*NumCycle+1):i*NumCycle,3),...
        'color',ColorPallet(i,:));
    hold on;
    plot3(score1(((i-1)*NumCycle+1):i*NumCycle,1),score1(((i-1)*NumCycle+1):i*NumCycle,2),score1(((i-1)*NumCycle+1):i*NumCycle,3),...
        '.','color',ColorPallet(i,:));
    axis([min(score1(:,1)) max(score1(:,1)) min(score1(:,2)) max(score1(:,2)) min(score1(:,3)) max(score1(:,3))]);
end
% 
% h=gcf;
% set(h,'PaperOrientation','landscape');
% set(h,'PaperUnits','normalized');
% set(h,'PaperPosition', [0 0 1 1]);
% print(h, '-dpdf', 'fig6');


