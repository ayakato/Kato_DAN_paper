


%% for re-order the 14-15 files
%     load(FileNames{2});
%     Temp=IntensityAll;
%     Temp2=IntensityAll;
%     Temp2(:,:,2:2:24)=Temp(:,:,1:2:24);
%     Temp2(:,:,1:2:24)=Temp(:,:,2:2:24);
%     IntensityAll=Temp2;
%     save( ['order0317_2.mat'],'IntensityAll');
%       

addpath(genpath('D:\Analysis201211-\Rawdata\MBON_SCH'));
[filename,pathname] = uigetfile('D:\Analysis201211-\Rawdata\MBON_SCH',...
    'Select a mat file to be analyzed','MultiSelect','on');
if iscell(filename) == 0
    NumBrain = 1;            % numel: number of elements
    FileNames{1} = filename;
else
    NumBrain = numel(filename);
    FileNames = filename;
end

% Create an image sequence array

    load(FileNames{1});
    J =IntensityAll;
    Sequence = zeros([size(J,1) size(J,2) 24 NumBrain]);
    Seq_DF= zeros([300 24 NumBrain]);
        
    for q = 1:NumBrain
        load(FileNames{q})
        Sequence(:,:,:,q) = IntensityAll;

Intensity_z=squeeze(sum(IntensityAll(:,:,:),1));
baseline=mean(Intensity_z(6:15,:),1);

DeltaFz=zeros(300,24);
for loopt=1:300
 DeltaFz(loopt,:)= (Intensity_z(loopt,:)-baseline)./baseline*100;
end

Seq_DF(:,:,q) = DeltaFz;

    end

    
AllRes=zeros(300,6,NumBrain);
AllRes(:,1,:)=mean(Seq_DF(:,[1:2:8],:),2);
AllRes(:,2,:)=mean(Seq_DF(:,[2:2:8],:),2);
AllRes(:,3,:)=mean(Seq_DF(:,[9:2:16],:),2);
AllRes(:,4,:)=mean(Seq_DF(:,[10:2:16],:),2);
AllRes(:,5,:)=mean(Seq_DF(:,[17:2:24],:),2);
AllRes(:,6,:)=mean(Seq_DF(:,[18:2:24],:),2);



figure; hold on;
for j=1:NumBrain
for i=1:6
subplot(3,2,i);hold on;
Allbrain=squeeze(AllRes(:,i,:));
plot(Allbrain(:,j));
ylim([-50 150]);
end
end


triggertiming=[18,47,75,103,131,157,185,214,241,270];
odoronset=triggertiming;
odoroffset=triggertiming+8;

    
ColP=[1,0,1;
0,1,0;
1,0.1,0.6;
0.1,0.6,0.1;
0.8,0.6,0.8;
0.7,0.9,0.7];

figure; hold on;
for i=1:6
subplot(3,2,i);hold on;
Allbrain=squeeze(AllRes(1:155,i,:));
plot(mean(Allbrain,2),'Color','k',"LineWidth",1);
sdSeq_DF=std(Allbrain,0,2);
ylim([-50 150]);
plot(mean(Allbrain,2)+sdSeq_DF,'Color',[0.4,0.4,0.4],"LineWidth",0.5);
ylim([-50 150]);
plot(mean(Allbrain,2)-sdSeq_DF,'Color',[0.4,0.4,0.4],"LineWidth",0.5);
ylim([-50 150]);

    for j=1:5
    Square_coloring([odoronset(j) odoroffset(j)],ColP(i,:));
    end
    
end

    
%% Total response    
 
triggertiming=[18,47,75,103,131]
WR=zeros(5,6,NumBrain);

for i=1:8
    WR=WR+AllRes([triggertiming+i-1],:,:)-AllRes([triggertiming-1],:,:);
end   

    %WRD=(WR(:,:,:)-WR(1,:,:))/4;
    WRD=WR(:,:,:)./WR(1,:,:);
    WRM=mean(WRD,3);
    WRE=std(WRD,0,3)/sqrt(size(WRD,3));
    
    
    figure;
    subplot(1,2,1)
    hold on
    errorbar(WRM(:,1),WRE(:,1),'-s','Color',[1,0,1],"LineWidth",2); 
    errorbar(WRM(:,3),WRE(:,3),'-s','Color',[1,0.1,0.6],"LineWidth",2); 
    errorbar(WRM(:,5),WRE(:,5),'-s','Color',[0.8,0.6,0.8],"LineWidth",2); 
    
    ylim([0 1])
    yticks([0:0.2:1]);
    xticks([1:5]) ;
    xlabel({'stmulus repeat'},'Fontsize',16,'Rotation',0)
    ylabel({'Odor response'},'Fontsize',16,'Rotation',90)
    %legend('saline','SCH 10μM', 'wash','Fontsize',12,'Location', 'eastoutside' )
    
    
    subplot(1,2,2)
    hold on
    errorbar(WRM(:,2),WRE(:,2),'-o','Color',[0,1,0],"LineWidth",2); 
    errorbar(WRM(:,4),WRE(:,4),'-o','Color',[0.1,0.6,0.1],"LineWidth",2); 
    errorbar(WRM(:,6),WRE(:,6),'-o','Color',[0.7,0.9,0.7],"LineWidth",2); 
    
    ylim([0 1])
    yticks([0:0.2:1]);
    xticks([1:5]) ;
    xlabel({'stmulus repeat'},'Fontsize',16,'Rotation',0)
    ylabel({'Odor response'},'Fontsize',16,'Rotation',90)
    %legend('saline','SCH 10μM', 'wash','Fontsize',12,'Location', 'eastoutside' )
    
MBON=[squeeze(WRD(2:5,1,:))';squeeze(WRD(2:5,2,:))'];
[p,tbl] = anova2(MBON,5);
[~,~,stats] = anova2(MBON,5,'off')
c = multcompare(stats,'Estimate','row')
tbl
     
MBON=[squeeze(WRD(2:5,1,:))';squeeze(WRD(2:5,3,:))';squeeze(WRD(2:5,5,:))'];

[p,tbl] = anova2(MBON,5);

[~,~,stats] = anova2(MBON,5,'off')
tbl
figure;
c = multcompare(stats)
figure;
c = multcompare(stats,'Estimate','row')


MBON=[squeeze(WRD(2:5,2,:))';squeeze(WRD(2:5,4,:))';squeeze(WRD(2:5,6,:))'];

[p,tbl] = anova2(MBON,5);
tbl
[~,~,stats] = anova2(MBON,5,'off')

figure;
c = multcompare(stats)
figure;
c = multcompare(stats,'Estimate','row')
    
Res1=WRD(2,1,:) ;
Res2=WRD(2,2,:) ; 
[h,p]=ttest2(Res1,Res2)  
[Res1,Res2]
    %% Normalized response
    
    
    
    triggertiming=[18,47,74,102,130,157,185,214,241,270]%+8

WR=zeros(10,6,NumBrain);
for i=1:8
    WR=WR+AllRes([triggertiming+i],:,:)%-AllRes([triggertiming-1],:,:);
end   

    WRD=(WR(:,:,:)-WR(1,:,:))/2;
    WRM=mean(WRD,3);
    WRE=std(WRD,0,3)/sqrt(size(WRD,3));
    
    
    figure;
    hold on
    errorbar(WRM(:,1),WRE(:,1),'-s','Color',[1,0,1],"LineWidth",2); 
    errorbar(WRM(:,3),WRE(:,3),'-s','Color',[1,0.1,0.6],"LineWidth",2); 
    errorbar(WRM(:,5),WRE(:,5),'-s','Color',[0.8,0.6,0.8],"LineWidth",2); 
    
    ylim([-350 120])
    xticks([1:10]) 
    xlabel({'Number of odor application'},'Fontsize',16,'Rotation',0)
    ylabel({'Normalized response'},'Fontsize',16,'Rotation',90)
    %legend('saline','SCH 10μM', 'wash','Fontsize',12,'Location', 'eastoutside' )
    
    
    figure;
    hold on
    errorbar(WRM(:,2),WRE(:,2),'-o','Color',[0,1,0],"LineWidth",2); 
    errorbar(WRM(:,4),WRE(:,4),'-o','Color',[0.1,0.6,0.1],"LineWidth",2); 
    errorbar(WRM(:,6),WRE(:,6),'-o','Color',[0.7,0.9,0.7],"LineWidth",2); 
    
    ylim([-350 120])
    xticks([1:10]) 
    xlabel({'Number of odor application'},'Fontsize',16,'Rotation',0)
    ylabel({'Normalized response'},'Fontsize',16,'Rotation',90)
    %legend('saline','SCH 10μM', 'wash','Fontsize',12,'Location', 'eastoutside' )
    
    
    
    
    
    
    

    
     
     
    

    
        figure;
    hold on
    errorbar(WRM(:,1),WRE(:,1),'-s','Color',[1,0,1],"LineWidth",2); 
    errorbar(WRM(:,2),WRE(:,2),'-o','Color',[0,1,0],"LineWidth",2); 

    ylim([-180 50])
    xticks([1:10]) 
    xlabel({'Number of odor application'},'Fontsize',16,'Rotation',0)
    ylabel({'Normalized response'},'Fontsize',16,'Rotation',90)
    legend('aversive','attractive','av SCH 10μM', 'at SCH 10μM','av wash', 'at wash','Fontsize',12,'Location', 'eastoutside' )
    
    
    
    
    figure;
    hold on
    errorbar(WRM(:,2),WRE(:,2),'-o','Color',[0,1,0],"LineWidth",2); 
    errorbar(WRM(:,4),WRE(:,4),'-o','Color',[0.1,0.6,0.1],"LineWidth",2); 
    errorbar(WRM(:,6),WRE(:,6),'-o','Color',[0.7,0.9,0.7],"LineWidth",2); 
    
    ylim([-180 50])
    xticks([1:10]) 
    xlabel({'Number of odor application'},'Fontsize',16,'Rotation',0)
    ylabel({'Normalized response'},'Fontsize',16,'Rotation',90)
    legend('aversive','attractive','av SCH 10μM', 'at SCH 10μM','av wash', 'at wash','Fontsize',12,'Location', 'eastoutside' )
    
    
    
    
   figure;
    hold on
    errorbar(WRM(:,2),WRE(:,2),'-o','Color',[0,1,0],"LineWidth",2); 
    errorbar(WRM(:,4),WRE(:,4),'-o','Color',[0.1,0.6,0.1],"LineWidth",2); 
    errorbar(WRM(:,6),WRE(:,6),'-o','Color',[0.7,0.9,0.7],"LineWidth",2); 
    
    ylim([-180 50])
    xticks([1:10]) 
    xlabel({'Number of odor application'},'Fontsize',16,'Rotation',0)
    ylabel({'Normalized response'},'Fontsize',16,'Rotation',90)
    legend('aversive','attractive','av SCH 10μM', 'at SCH 10μM','av wash', 'at wash','Fontsize',12,'Location', 'eastoutside' )
    
    
    
    
    
AV=squeeze(WRD(:,1,:));
AP=squeeze(WRD(:,2,:));
MBON=[AV';AP']
[p,tbl] = anova2(MBON,6);

[~,~,stats] = anova2(MBON,6,'off')

figure;
c = multcompare(stats)
figure;
c = multcompare(stats,'Estimate','row')



MBON=[squeeze(WRD(1:10,1,:))';squeeze(WRD(1:10,2,:))';squeeze(WRD(1:10,3,:))';squeeze(WRD(1:10,4,:))';squeeze(WRD(1:10,5,:))';squeeze(WRD(1:10,6,:))'];
[p,tbl] = anova2(MBON,6);

[~,~,stats] = anova2(MBON,6,'off')

figure;
c = multcompare(stats)
figure;
c = multcompare(stats,'Estimate','row')



    
    
meanSeq_DF=mean(Seq_DF,3);
sdSeq_DF=std(Seq_DF,0,3);

figure;
for q=1:NumFileNamesIndividual
subplot(3,8,q); hold on;
plot(meanSeq_DF(:,q));
%plot(meanSeq_DF(:,q)+sdSeq_DF(:,q),'k');
%plot(meanSeq_DF(:,q)-sdSeq_DF(:,q),'k');
ylim([-30 100])
end



AllRes=zeros(300,6);
AllRes(:,1)=mean(meanSeq_DF(:,[1:2:8]),2);
AllRes(:,2)=mean(meanSeq_DF(:,[2:2:8]),2);
AllRes(:,3)=mean(meanSeq_DF(:,[9:2:16]),2);
AllRes(:,4)=mean(meanSeq_DF(:,[10:2:16]),2);
AllRes(:,5)=mean(meanSeq_DF(:,[17:2:24]),2);
AllRes(:,6)=mean(meanSeq_DF(:,[18:2:24]),2);

ymin=-150;
ymax=20;

triggertiming=[18,47,74,102,130,158,185,213,241,269];

WR=zeros(10,6);
for i=1:10
    WR=WR+AllRes([triggertiming+i],:);
end    
    

figure;
plot(WR);

figure;
plot((WR(:,1:4)-WR(1,1:4))/10);




AllRes=zeros(300,6,NumBrain);
AllRes(:,1,:)=mean(Seq_DF(:,[3:2:8],:),2);
AllRes(:,2,:)=mean(Seq_DF(:,[4:2:8],:),2);
AllRes(:,3,:)=mean(Seq_DF(:,[11:2:16],:),2);
AllRes(:,4,:)=mean(Seq_DF(:,[12:2:16],:),2);
AllRes(:,5,:)=mean(Seq_DF(:,[19:2:24],:),2);
AllRes(:,6,:)=mean(Seq_DF(:,[20:2:24],:),2);


AllRes=zeros(300,6,5);
AllRes(:,1,:)=mean(Seq_DF(:,[1:2:8],4:8),2);
AllRes(:,2,:)=mean(Seq_DF(:,[2:2:8],4:8),2);
AllRes(:,3,:)=mean(Seq_DF(:,[9:2:16],4:8),2);
AllRes(:,4,:)=mean(Seq_DF(:,[10:2:16],4:8),2);
AllRes(:,5,:)=mean(Seq_DF(:,[17:2:24],4:8),2);
AllRes(:,6,:)=mean(Seq_DF(:,[18:2:24],4:8),2);

AllRes=zeros(300,6,3);
AllRes(:,1,:)=mean(Seq_DF(:,[1:2:8],1:3),2);
AllRes(:,2,:)=mean(Seq_DF(:,[2:2:8],1:3),2);
AllRes(:,3,:)=mean(Seq_DF(:,[9:2:16],1:3),2);
AllRes(:,4,:)=mean(Seq_DF(:,[10:2:16],1:3),2);
AllRes(:,5,:)=mean(Seq_DF(:,[17:2:24],1:3),2);
AllRes(:,6,:)=mean(Seq_DF(:,[18:2:24],1:3),2);



