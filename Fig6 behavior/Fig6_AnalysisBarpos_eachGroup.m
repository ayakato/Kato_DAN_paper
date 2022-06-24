% Analyzes fly's behavioral responses to odors.
% Starting from .bad files after running packTool. Using barpos to
% calculate VI. Removes spinning and non-flying traces.
% Written to analyze Ayaka's flight experiment where the same odor is repeatedly applied. 20210426 HK
%% Set the parameters

Fs = 10000;      % Sampling frequency
BinSize2 = 50;   % Bin size for WBA estimation
FrameRate = Fs / BinSize2;  % Frame rate for barpos analysis
noSpinningThresh = 1440; % must turn 2 full turns in order to qualify for a spin
LowerThreshold = 45;  % Mean total deviation should be higher than this value
OdorRegion = 45;  % Odor application region (plus minus OdorRegion)
nBlock = 3;
nSet=21;
nRepeat = 1;    % number of repeats (blocks)
nOdor = 10;       % number of application of the same odor in this case
ITI = 11;         % duration of inter-test(odor)-interval in seconds
OdorPeriod = 4;  % duration of odor (test) period
VIperiod = 1;   % period during which VI is calculated
OdorDelay = 3.5; % delay between the opening of the solenoid and the arrival of odors to the animal

% There is no need to reorder the traces according to the rngSeed because
% the same odor is applied repeatedly and the traces appear in chronolgical
% order in info structure in the .bad file
%% Select the folder to be analyzed and load the data

pathname = uigetdir(cd,...
    'Select the first data folder to be analyzed');
DirOutput = dir(fullfile([pathname '\*.bad']));
FileNames = {DirOutput.name}';
nAnimal = numel(FileNames);
data = load(fullfile([pathname '\' FileNames{1}]),'-mat');
nFrame = numel([data.info(1).barpos, data.info(1+7).barpos, data.info(1+14).barpos]);
%% Loop through all the files (flies)

HeadingDirO1All = zeros(nAnimal, 7, 3, nFrame);
HeadingDirO6All = zeros(nAnimal, 7, 3, nFrame);
HeadingDirO9All = zeros(nAnimal, 7, 3, nFrame);
SpinO1All = zeros(nAnimal, 7, 3);
SpinO6All = zeros(nAnimal, 7, 3);
SpinO9All = zeros(nAnimal, 7, 3);
FlyO1All = zeros(nAnimal, 7, 3);
FlyO6All = zeros(nAnimal, 7, 3);
FlyO9All = zeros(nAnimal, 7, 3);
%%
for l = 1:nAnimal
    data = load(fullfile([pathname '\' FileNames{l}]),'-mat');   % The name of an object containing the data is "info"
    
    for i=1:3
        for j = 1:7 % Loads the heading direction
            HeadingDirO6 =[data.info(j+21*i-21).barpos, data.info(j+7+21*i-21).barpos, data.info(j+14+21*i-21).barpos]/96*360;
            SpinO6All(l,j,i)=findSpinningTrial(HeadingDirO6,noSpinningThresh);
            HeadingDirO6All(l,j,i,:) = HeadingDirO6;   % [nAnimal nRepeat nOdor nFrame]
            FlyO6All(l,j,i)=all([data.info(j+7+21*i-21).amprchunk+data.info(j+7+21*i-21).amplchunk]>0.1); % Detects the non-flying trial         
        end
    end

    for i=1:3
        for j = 1:7 % Loads the heading direction
            HeadingDirO1 =[data.info(j+21*i-21+63).barpos, data.info(j+7+21*i-21+63).barpos, data.info(j+14+21*i-21+63).barpos]/96*360;
            SpinO1All(l,j,i)=findSpinningTrial(HeadingDirO1,noSpinningThresh);
            HeadingDirO1All(l,j,i,:) = HeadingDirO1;   % [nAnimal nRepeat nOdor nFrame]
            FlyO1All(l,j,i)=all([data.info(j+7+21*i-21+63).amprchunk+data.info(j+7+21*i-21+63).amplchunk]>0.1); % Detects the non-flying trial         
        end
    end
        
    for i=1:3
        for j = 1:7 % Loads the heading direction
            HeadingDirO9 =[data.info(j+21*i-21+126).barpos, data.info(j+7+21*i-21+126).barpos, data.info(j+14+21*i-21+126).barpos]/96*360;
            SpinO9All(l,j,i)=findSpinningTrial(HeadingDirO9,noSpinningThresh);
            HeadingDirO9All(l,j,i,:) = HeadingDirO9;   % [nAnimal nRepeat nOdor nFrame]
            FlyO9All(l,j,i)=all([data.info(j+7+21*i-21+126).amprchunk+data.info(j+7+21*i-21+126).amplchunk]>0.1); % Detects the non-flying trial         
        end
    end     
end


%%

figure;
subplot(2,3,1);
imagesc(squeeze(sum(FlyO6All,'omitnan')),[0, nAnimal]);
title("Flight Odor6");
subplot(2,3,2);
imagesc(squeeze(sum(FlyO1All,'omitnan')),[0, nAnimal]);
title("Flight Odor1");
subplot(2,3,3);
imagesc(squeeze(sum(FlyO9All,'omitnan')),[0, nAnimal]);
title("Flight Odor9");
subplot(2,3,4);
imagesc(squeeze(sum(~SpinO6All,'omitnan')),[0, nAnimal]);
title("Spin Odor6");
subplot(2,3,5);
imagesc(squeeze(sum(~SpinO1All,'omitnan')),[0, nAnimal]);
title("Spin Odor1");
subplot(2,3,6);
imagesc(squeeze(sum(~SpinO9All,'omitnan')),[0, nAnimal]);
title("Spin Odor9");

%%
FlyO6All(FlyO6All==0)=NaN;
FlyO1All(FlyO1All==0)=NaN;
FlyO9All(FlyO9All==0)=NaN;

SO6=double(~SpinO6All);
SO1=double(~SpinO1All);
SO9=double(~SpinO9All);

SO6(SO6==0)=NaN;
SO1(SO1==0)=NaN;
SO9(SO9==0)=NaN;

HDO6=HeadingDirO6All.*FlyO6All.*SO6;
HDO1=HeadingDirO1All.*FlyO1All.*SO1;
HDO9=HeadingDirO9All.*FlyO9All.*SO9;

%%
nBlock=3;
nRepeat=7;
ExitTime=zeros(nAnimal,nRepeat,nBlock);

HDT=permute(HDO6,[4 3 2 1]);

for j=1:nAnimal
%   figure;hold on;
  for i=1:3
    for k=1:7
%         subplot(7,3,i+(k-1)*3);hold on;
                
IND=find(greaterThan(abs(HDT(:,i,k,j)),OdorRegion)==1);
OdorIND=IND(IND>700);
xINDani=min(OdorIND);
if isempty(OdorIND)==0
% xline(xINDani,'Color','r');hold on;
% yline(45,'Color','r');
% yline(-45,'Color','r');
% plot(HDT(1:2000,i,k,j),'Color','k');
ExitTime(j,k,i)=xINDani;
else
% plot(HDT(1:2000,i,k,j),'Color','k');
end
%         ylim([-180 180]);
%         xlim([1 2000]);
     end
  end  
end

ET6=ExitTime;  % [nAnimal 3 7]
%%
nBlock=3;
nRepeat=7;
ExitTime=zeros(nAnimal,nRepeat,nBlock);

HDT=permute(HDO1,[4 3 2 1]);

for j=1:nAnimal
  %figure;hold on;
  for i=1:3
    for k=1:7
        %subplot(7,3,i+(k-1)*3);hold on;
                
IND=find(greaterThan(abs(HDT(:,i,k,j)),OdorRegion)==1);
OdorIND=IND(IND>700);
xINDani=min(OdorIND);
if isempty(OdorIND)==0
% xline(xINDani,'Color','r');hold on;
% yline(45,'Color','r');
% yline(-45,'Color','r');
% plot(HDT(1:2000,i,k,j),'Color','k');
ExitTime(j,k,i)=xINDani;
else
% plot(HDT(1:2000,i,k,j),'Color','k');
end
%         ylim([-180 180]);
%         xlim([1 2000]);
     end
  end  
end

ET1=ExitTime;  % [nAnimal 3 7]
%%
nBlock=3;
nRepeat=7;
ExitTime=zeros(nAnimal,nRepeat,nBlock);

HDT=permute(HDO9,[4 3 2 1]);

for j=1:nAnimal
  %figure;hold on;
  for i=1:3
    for k=1:7
       % subplot(7,3,i+(k-1)*3);hold on;
                
IND=find(greaterThan(abs(HDT(:,i,k,j)),OdorRegion)==1);
OdorIND=IND(IND>700);
xINDani=min(OdorIND);
if isempty(OdorIND)==0
%xline(xINDani,'Color','r');hold on;
%yline(45,'Color','r');
%yline(-45,'Color','r');
%plot(HDT(1:2000,i,k,j),'Color','k');
ExitTime(j,k,i)=xINDani;
else
%plot(HDT(1:2000,i,k,j),'Color','k');
end
     %   ylim([-180 180]);
     %  xlim([1 2000]);
     end
  end  
end

ET9=ExitTime;  % [nAnimal 3 7]
%%
ExitTimeO6=ET6.*FlyO6All.*SO6;
ExitTimeO1=ET1.*FlyO1All.*SO1;
ExitTimeO9=ET9.*FlyO9All.*SO9;

ExitTimeO6(ExitTimeO6==0)=2000;
ExitTimeO1(ExitTimeO1==0)=2000;
ExitTimeO9(ExitTimeO9==0)=2000;

mExitTimeO6=squeeze(nanmean(ExitTimeO6,1));
mExitTimeO1=squeeze(nanmean(ExitTimeO1,1));
mExitTimeO9=squeeze(nanmean(ExitTimeO9,1));

figure;
for i=1:7
for k=1:3
subplot(7,3,k+(i-1)*3);hold on;
hold on;
bar(1,mExitTimeO6(i,k)-700);
bar(2,mExitTimeO1(i,k)-700);
bar(3,mExitTimeO9(i,k)-700);
ylim([0 1000])
end
end
%%
m7ExitTimeO6=squeeze(nanmean(mExitTimeO6,1));
m7ExitTimeO1=squeeze(nanmean(mExitTimeO1,1));
m7ExitTimeO9=squeeze(nanmean(mExitTimeO9,1));

Odorlist={'1st','2nd','3rd'};

figure;

for k=1:3
subplot(1,3,k);hold on;
hold on;
bar(1,m7ExitTimeO6(k)-700);
bar(2,m7ExitTimeO1(k)-700);
bar(3,m7ExitTimeO9(k)-700);
ylim([0 1500])
title([Odorlist{k}])
end
%%
m3ExitTimeO6=squeeze(nanmean(mExitTimeO6,2));
m3ExitTimeO1=squeeze(nanmean(mExitTimeO1,2));
m3ExitTimeO9=squeeze(nanmean(mExitTimeO9,2));

Odorlist={'1st','2nd','3rd','4th','5th','6th','7th'};

figure;

for k=1:7
subplot(1,7,k);hold on;
hold on;
bar(1,m3ExitTimeO6(k)-700);
bar(2,m3ExitTimeO1(k)-700);
bar(3,m3ExitTimeO9(k)-700);
ylim([0 1200])
title([Odorlist{k}])
end
%%
    figure;hold on;
    for k=1:nAnimal
    for i=1:3
    subplot(nAnimal,3,i+(k-1)*3)
    plot(TDO6(i,:,k),'b');hold on;
    plot(TDO1(i,:,k),'k');hold on;
    plot(TDO9(i,:,k),'r');
    end
    end
%%
mTDO6=squeeze(nanmean(TDO6,3));
mTDO1=squeeze(nanmean(TDO1,3));
mTDO9=squeeze(nanmean(TDO9,3));


figure;
for i=1:nBlock
    for k=1:7
subplot(7,3,i+(k-1)*3);hold on;
hold on;
bar(1,mTDO6(i,k));
bar(2,mTDO1(i,k));
bar(3,mTDO9(i,k));
title([Odorlist{i}])
ylim([0 600])
    end
end
    
%%
m7TDO6=squeeze(nanmean(mTDO6,2));
m7TDO1=squeeze(nanmean(mTDO1,2));
m7TDO9=squeeze(nanmean(mTDO9,2));

figure;

for k=1:3
subplot(1,3,k);hold on;
hold on;
bar(1,m7TDO6(k));
bar(2,m7TDO1(k));
bar(3,m7TDO9(k));
ylim([0 700])
title([Odorlist{k}])
end
%%
m3TDO6=squeeze(nanmean(mTDO6,1));
m3TDO1=squeeze(nanmean(mTDO1,1));
m3TDO9=squeeze(nanmean(mTDO9,1));

Odorlist={'1st','2nd','3rd','4th','5th','6th','7th'};

figure;

for k=1:7
subplot(1,7,k);hold on;
hold on;
bar(1,m3TDO6(k));
bar(2,m3TDO1(k));
bar(3,m3TDO9(k));
ylim([0 400])
title([Odorlist{k}])
end
%% Calculate and plot instantaneousVI and VI

%%%%%%%%%%%%%%%%%%% Mean by Trials
VIinstant = greaterThan(abs(HDO6),OdorRegion);  % [nAnimal nOdor nFrame]
VIinstant6 = permute(VIinstant,[1 4 3 2]);  % conversion from [nAnimal nOdor nFrame] to [nAnimal nFrame nOdor]
VIO6 = squeeze(nanmean(VIinstant6(:,(OdorPeriod+OdorDelay-VIperiod)*FrameRate:(OdorPeriod+OdorDelay)*FrameRate,:,:),2));  %[nAnimal nOdor]

VIinstant = greaterThan(abs(HDO1),OdorRegion);  % [nAnimal nOdor nFrame]
VIinstant1 = permute(VIinstant,[1 4 3 2]);  % conversion from [nAnimal nOdor nFrame] to [nAnimal nFrame nOdor]
VIO1 = squeeze(nanmean(VIinstant1(:,(OdorPeriod+OdorDelay-VIperiod)*FrameRate:(OdorPeriod+OdorDelay)*FrameRate,:,:),2));  %[nAnimal nOdor]

VIinstant = greaterThan(abs(HDO9),OdorRegion);  % [nAnimal nOdor nFrame]
VIinstant9 = permute(VIinstant,[1 4 3 2]);  % conversion from [nAnimal nOdor nFrame] to [nAnimal nFrame nOdor]
VIO9 = squeeze(nanmean(VIinstant9(:,(OdorPeriod+OdorDelay-VIperiod)*FrameRate:(OdorPeriod+OdorDelay)*FrameRate,:,:),2));  %[nAnimal nOdor]

% Plot instantaneousVI over time

figure;
VI1st=nanmean(VIinstant6,4); %% mean 7 trials

myebnanSEM(VI1st);
ylim([0 1]);
legend;
xlabel('Time frame','Fontsize',12)
ylabel('Instantaneous VI','Fontsize',12)
legend('1st','2nd','3rd');
title('VI int aversive')

% Plot instantaneousVI over time
figure;
VI1st=nanmean(VIinstant1,4);
myebnanSEM(VI1st);
ylim([0 1]);
legend;
xlabel('Time frame','Fontsize',12)
ylabel('Instantaneous VI','Fontsize',12)
legend('1st','2nd','3rd');
title('VI int attractive');

% Plot instantaneousVI over time
figure;
VI1st=nanmean(VIinstant9,4);
myebnanSEM(VI1st);
ylim([0 1]);
legend;
xlabel('Time frame','Fontsize',12)
ylabel('Instantaneous VI','Fontsize',12)
legend('1st','2nd','3rd');
title('VI int neutral');

%%
% Plot VI at the end of the odor application period
conditions = 1:3;
figure;hold on;
VIi = squeeze(nanmean(VIO6,3));  %% mean 7 trials
VIMean = nanmean(VIi,1);
VISE = nanstd(VIi,0,1)/sqrt(size(VIi,1));
errorbar(conditions,VIMean,VISE); hold on;

VIi = squeeze(nanmean(VIO1,3));  % [nOdor nAnimal]
VIMean = nanmean(VIi,1);
VISE = nanstd(VIi,0,1)/sqrt(size(VIi,1));
errorbar(conditions,VIMean,VISE); hold on;

VIi = squeeze(nanmean(VIO9,3));  % [nOdor nAnimal]
VIMean = nanmean(VIi,1);
VISE = nanstd(VIi,0,1)/sqrt(size(VIi,1));
errorbar(conditions,VIMean,VISE);
xlim([0.5 3.5]);
ylim([0 1]);
legend('Aversive','Attractive', 'Neutral');
xlabel('Stimulus Repeat','Fontsize',12)
ylabel('VI','Fontsize',12)

%%%%%%%%%%%%%%%%%%% Mean by repeat
%%
% ATPmON.HeadingDirO1All=HeadingDirO1All;
% ATPmON.HeadingDirO6All=HeadingDirO6All;
% ATPmON.HeadingDirO9All=HeadingDirO9All;
% ATPmON.HDO1=HDO1;
% ATPmON.HDO6=HDO6;
% ATPmON.HDO9=HDO9;
% ATPmON.ExitTimeO1=ExitTimeO1;
% ATPmON.ExitTimeO6=ExitTimeO6;
% ATPmON.ExitTimeO9=ExitTimeO9;
% ATPmON.TDO1=TDO1;
% ATPmON.TDO6=TDO6;
% ATPmON.TDO9=TDO9;
% ATPmON.VIinstant1=VIinstant1;
% ATPmON.VIinstant6=VIinstant6;
% ATPmON.VIinstant9=VIinstant9;
% ATPmON.VIO1=VIO1;
% ATPmON.VIO6=VIO6;
% ATPmON.VIO9=VIO9;
% 
% save('ATPmON_n22.mat','ATPmON')
%%
% ATPpON.HeadingDirO1All=HeadingDirO1All;
% ATPpON.HeadingDirO6All=HeadingDirO6All;
% ATPpON.HeadingDirO9All=HeadingDirO9All;
% ATPpON.HDO1=HDO1;
% ATPpON.HDO6=HDO6;
% ATPpON.HDO9=HDO9;
% ATPpON.ExitTimeO1=ExitTimeO1;
% ATPpON.ExitTimeO6=ExitTimeO6;
% ATPpON.ExitTimeO9=ExitTimeO9;
% ATPpON.TDO1=TDO1;
% ATPpON.TDO6=TDO6;
% ATPpON.TDO9=TDO9;
% ATPpON.VIinstant1=VIinstant1;
% ATPpON.VIinstant6=VIinstant6;
% ATPpON.VIinstant9=VIinstant9;
% ATPpON.VIO1=VIO1;
% ATPpON.VIO6=VIO6;
% ATPpON.VIO9=VIO9;
% 
% save('DANbeta2mp_ATPpON.mat','ATPpON')
%%