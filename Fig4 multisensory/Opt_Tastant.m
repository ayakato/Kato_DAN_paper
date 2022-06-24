
%% Analysis of data
display('Analyzing data...');
set(0,'defaultAxesFontName', 'Helvetica')
%% Set parameters
% 565 ms per Cycle
NumRepeat = 6;   % Number of repeats (blocks) that you want to analyze
NumOdor = 5;  %7  % Including the blank vial
climsMin = -20;
climsMax = 200;

OdorLabel = {
'Pow 1/6',...
'Pow 3/12',...
'Pow 2/6',...
'Pow 3/6',...
'Pow 6/6'
};


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


%% Load the saved mat files
addpath(genpath('D:\Analysis201211-\Rawdata\PE_OPT'));
[filename,pathname] = uigetfile('D:\Analysis201211-\Rawdata\PE_OPT\*.mat',...
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
Percent

%% Average across brains and trials
NumCycle = size(J,2);
NumGlomerulus = size(J,1);
AverageSequence = mean(Sequence,4);

figure;colormap parula;
for i = 1:NumOdor*NumRepeat
    subplot(NumRepeat,NumOdor,i,'Fontsize',7);
    
    imagesc(AverageSequence(:,:,i))
    
    shading flat
    caxis([-20 80]);
 
        set(gca,'YTick',[1:15]);
        set(gca,'XTick',[0:5:25]);
        set(gca,'YTickLabel',CP_Label,'Fontsize',8);
            
    if i <= NumOdor
        title(['        ' OdorLabel{i}],'Fontsize',10);
    end
    
    if mod(i,NumOdor) == 1
        ylabel(['block' num2str(ceil(i/NumOdor))],'Fontsize',10);
    end
end


DFD=AverageSequence;
    NumOdor=30;
    IndMean=DFD(:,:,1:5);

    IndMean(:,:,1)=mean(DFD(:,:,1:5:NumOdor),3);
    IndMean(:,:,2)=mean(DFD(:,:,2:5:NumOdor),3);
    IndMean(:,:,3)=mean(DFD(:,:,3:5:NumOdor),3);
    IndMean(:,:,4)=mean(DFD(:,:,4:5:NumOdor),3);   
    IndMean(:,:,5)=mean(DFD(:,:,5:5:NumOdor),3);    

    figure;
    for i=1:5
    subplot(1,5,i,'Fontsize',7);
    clims = [-20 100];
    imagesc(IndMean(:,:,i),clims);  
        set(gca,'YTick',[1:15]);
        set(gca,'XTick',[0:5:25]);
        set(gca,'YTickLabel',CP_Label,'Fontsize',12);
    if i <= NumOdor
        title([OdorLabel{i}],'Fontsize',12);
    end
    end
 
    colormap parula;
    

    figure;hold on;
    for j=1:NumBrain
        
    DFD=Sequence(:,:,:,j);
    IndMean=DFD(:,:,1:5);

    IndMean(:,:,1)=mean(DFD(:,:,1:5:NumOdor),3);
    IndMean(:,:,2)=mean(DFD(:,:,2:5:NumOdor),3);
    IndMean(:,:,3)=mean(DFD(:,:,3:5:NumOdor),3);
    IndMean(:,:,4)=mean(DFD(:,:,4:5:NumOdor),3);   
    IndMean(:,:,5)=mean(DFD(:,:,5:5:NumOdor),3); 
    
    for i = 1:5
    subplot(NumBrain,5,i+(j-1)*5,'Fontsize',7);
    
    imagesc(IndMean(:,:,i))
    
    shading flat
    caxis([-20 80]);
 
        set(gca,'YTick',[1:15]);
        set(gca,'XTick',[0:5:25]);
        set(gca,'YTickLabel',CP_Label,'Fontsize',8);
        if j==1
        title(['        ' OdorLabel{i}],'Fontsize',10);
        end


    end
    

    end

    
        
 %%  
    OPT_66a=AverageSequence;
    NumOdor=30;
    DFD=OPT_66a;
    IndMean=DFD(:,:,1:5);

    IndMean(:,:,1)=mean(DFD(:,:,1:5:NumOdor),3);
    IndMean(:,:,2)=mean(DFD(:,:,2:5:NumOdor),3);
    IndMean(:,:,3)=mean(DFD(:,:,3:5:NumOdor),3);
    IndMean(:,:,4)=mean(DFD(:,:,4:5:NumOdor),3);   
    IndMean(:,:,5)=mean(DFD(:,:,5:5:NumOdor),3);    

    %OPTstim_66a=IndMean;
    
    figure;
    for i=1:5
    subplot(1,5,i,'Fontsize',7);
    clims = [0 80];
    imagesc(IndMean(:,5:25,i),clims);  
        set(gca,'YTick',[1:15]);
        set(gca,'XTick',[0:5:25]);
        set(gca,'YTickLabel',CP_Label,'Fontsize',12);
    if i <= NumOdor
        title([OdorLabel{i}],'Fontsize',12);
    end
    daspect([2 1 1]);
    end
  
    colormap parula;

ColorPallet = [
    0.8,0.8,0.8;
    0.6,0.6,0.6;  
    0.4,0.4,0.4;
    0.2,0.2,0.2;
    0,0,0; 
  ];

%ColorPallet = ColorPallet/255;   % The number has to be between 0 and 1    
    
    figure;hold on;
for j = 1:15;
    subplot(3,5,j);
    for i = 1:5;
        hold on;
        plot(IndMean(j,5:25,i),'color', ColorPallet(i,:));
    end
    ylim([-30 120])
        if i <= NumOdor
        title([CP_Label{j}],'Fontsize',12);
        end
    %daspect([1 4 1]);
end
    
    
%% exstract real tastant stimulus
    
    load(FileNames{1});
    J = data.DeltaFOverFAll;
    Suc = zeros([size(J,1) size(J,2) 10 NumBrain]);
    
    for q = 1:NumBrain
        load(FileNames{q});
        NumRecords=size(data.DeltaFOverFAll,3);
        Suc(:,:,1:(NumRecords-30),q) = data.DeltaFOverFAll(:,:,31:NumRecords);
    end


    figure;
    for j=1:NumBrain
    for i=1:10
    subplot(NumBrain,10,i+(j-1)*10,'Fontsize',7);
    clims = [-20 80];
    imagesc(Suc(:,:,i,j),clims);  
        set(gca,'YTick',[1:15]);
        set(gca,'XTick',[0:5:25]);
        set(gca,'YTickLabel',CP_Label,'Fontsize',7);
    end
    end
    
  
       figure;
    clims = [-10 80];  
    subplot(1,4,1)
    imagesc(OPTstim_64f(:,5:25,2),clims);  
        set(gca,'YTick',[1:15]);
        set(gca,'XTick',[0:5:25]);
        set(gca,'YTickLabel',CP_Label,'Fontsize',12);
        daspect([4 1 1]);
        h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
    subplot(1,4,2)
    imagesc(MeanSu(:,5:25),clims);  
        set(gca,'YTick',[1:15]);
        set(gca,'XTick',[0:5:25]);
        set(gca,'YTickLabel',CP_Label,'Fontsize',12);
        h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
        daspect([4 1 1]);
    colormap parula;
    subplot(1,4,3)
    imagesc(OPTstim_66a(:,5:25,3),clims);  
        set(gca,'YTick',[1:15]);
        set(gca,'XTick',[0:5:25]);
        set(gca,'YTickLabel',CP_Label,'Fontsize',12);
        h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
        daspect([4 1 1]);
    subplot(1,4,4)
    imagesc(MeanBit(:,5:25)/6,clims);  
        set(gca,'YTick',[1:15]);
        set(gca,'XTick',[0:5:25]);
        set(gca,'YTickLabel',CP_Label,'Fontsize',12);
    colormap gray;
    h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
    daspect([4 1 1]);
      
    
    [rho,pvl]=corr(mean(OPTstim_64f(:,10:14,2),2),mean(MeanSu(:,10:14),2))
    
    [rho,pvl]=corr(mean(OPTstim_66a(:,10:14,2),2),mean(MeanBit(:,10:14),2))
    
