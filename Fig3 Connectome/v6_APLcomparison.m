


figure;
      imagesc(zscore(DA(:,3:17)',0,2));
        set(gca,'YTick',[1:15]);
        set(gca,'XTick',[1:24]);
        h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
        set(gca,'YTickLabel',CP_Label,'Fontsize',15);
        set(gca,'XTickLabel',Odor_Label,'Fontsize',10)
        xtickangle(45)
    colormap gray;

    
figure;
   subplot(1,2,1)
    EM = readmatrix('v7_mean_NT_DbyPN_All_APLp8_10_Mock100.csv'); 
      imagesc(EM(:,2:25));
        set(gca,'YTick',[1:15]);
        set(gca,'XTick',[1:24]);
        h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
        set(gca,'YTickLabel',CP_Label,'Fontsize',10);
        set(gca,'XTickLabel',Odor_Label,'Fontsize',6)
        xtickangle(45)
     corrv=corr2(DA(:,3:17)',EM(:,2:25)); 
    title(['NT Corr2 = ', num2str(corrv)])
    colormap gray;

   subplot(1,2,2)
    EM = readmatrix('v6_mean_NT_DbyPN_All_APLp8_10.csv');   
    imagesc(EM(:,2:25));
        set(gca,'YTick',[1:15]);
        set(gca,'XTick',[1:24]);
        h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
        set(gca,'YTickLabel',CP_Label,'Fontsize',10);
        set(gca,'XTickLabel',Odor_Label,'Fontsize',6)
        xtickangle(45)
     corrv=corr2(DA(:,3:17)',EM(:,2:25)); 
     title(['Prev Corr2 = ', num2str(corrv)])
    colormap gray;
    
    
    


    
figure;
   subplot(1,3,1)
    EM = readmatrix('v6_mean_NT_DbyPN_All_APLp10_10_noKC.csv'); 
      imagesc(EM(:,2:25));
        set(gca,'YTick',[1:15]);
        set(gca,'XTick',[1:24]);
        h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
        set(gca,'YTickLabel',CP_Label,'Fontsize',10);
        set(gca,'XTickLabel',Odor_Label,'Fontsize',6)
        xtickangle(45)
     corrv=corr2(DA(:,3:17)',EM(:,2:25)); 
    title(['noKC = ', num2str(corrv)])
    colormap gray;

   subplot(1,3,2)
    EM = readmatrix('v6_mean_NT_DbyPN_All_APLp10_10_noLH.csv');   
    imagesc(EM(:,2:25));
        set(gca,'YTick',[1:15]);
        set(gca,'XTick',[1:24]);
        h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
        set(gca,'YTickLabel',CP_Label,'Fontsize',10);
        set(gca,'XTickLabel',Odor_Label,'Fontsize',6)
        xtickangle(45)
     corrv=corr2(DA(:,3:17)',EM(:,2:25)); 
     title(['noLH = ', num2str(corrv)])
    colormap gray;
    
    
    subplot(1,3,3)
    EM = readmatrix('v7_mean_NT_DbyPN_All_APLp8_10_Mock50.csv');   
    imagesc(EM(:,2:25));
        set(gca,'YTick',[1:15]);
        set(gca,'XTick',[1:24]);
        h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
        set(gca,'YTickLabel',CP_Label,'Fontsize',10);
        set(gca,'XTickLabel',Odor_Label,'Fontsize',6)
        xtickangle(45)
     corrv=corr2(DA(:,3:17)',EM(:,2:25)); 
     title(['All Corr = ', num2str(corrv)])
    colormap gray;
    
%%zscore
 DAz=zscore(DA(:,3:17)',0,2);
 clim=[-2 2];   
    figure;
   subplot(1,3,1)
    %EM = readmatrix('v7_mean_NT_DbyPN_All_APLp8_10_Mock50.csv'); 
    EM = readmatrix('v7_mean_NT_DbyPN_All_APLp8_10.csv');
      imagesc(zscore(EM(:,2:25),0,2),clim);
        set(gca,'YTick',[1:15]);
        set(gca,'XTick',[1:24]);
        h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
        set(gca,'YTickLabel',CP_Label,'Fontsize',15);
        set(gca,'XTickLabel',Odor_Label,'Fontsize',10)
        xtickangle(45)
     corrv=corr2(DAz,zscore(EM(:,2:25),0,2)); 
    title(['All z = ', num2str(corrv)])
    colormap gray;

   subplot(1,3,2)
    EM = readmatrix('v6_mean_NT_DbyPN_All_APLp8_10_noLH.csv');   
    imagesc(zscore(EM(:,2:25),0,2),clim);
        set(gca,'YTick',[1:15]);
        set(gca,'XTick',[1:24]);
        h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
        set(gca,'YTickLabel',CP_Label,'Fontsize',15);
        set(gca,'XTickLabel',Odor_Label,'Fontsize',10)
        xtickangle(45)
     corrv=corr2(DAz,zscore(EM(:,2:25),0,2)); 
     title(['noLH z = ', num2str(corrv)])
    colormap gray;
    
    subplot(1,3,3)
    EM = readmatrix('v6_mean_NT_DbyPN_All_APLp8_10_noKC.csv');   
    imagesc(zscore(EM(:,2:25),0,2),clim);
        set(gca,'YTick',[1:15]);
        set(gca,'XTick',[1:24]);
        h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
        set(gca,'YTickLabel',CP_Label,'Fontsize',15);
        set(gca,'XTickLabel',Odor_Label,'Fontsize',10)
        xtickangle(45)
     corrv=corr2(DAz,zscore(EM(:,2:25),0,2)); 
     title(['noKC z = ', num2str(corrv)])
    colormap gray;


%% Corr by odors
   
     DAN_predict = readmatrix('v6_mean_NT_DbyPN_All_APLp8_10_noKC.csv');
    for i=1:24
    [CCF,P,RL,RU]=corrcoef(DA(i,3:17)',DAN_predict(:,i+1));
    CorrbyOdor(i)=CCF(1,2);
    end    
    CP_KC=CorrbyOdor
      
   
    DAN_predict = readmatrix('v6_mean_NT_DbyPN_All_APLp8_10_noLH.csv');
    for i=1:24
    [CCF,P,RL,RU]=corrcoef(DA(i,3:17)',DAN_predict(:,i+1));
    CorrbyOdor(i)=CCF(1,2);
    end    
    CP_LH=CorrbyOdor
    
    DAN_predict = readmatrix('v6_mean_NT_DbyPN_All_APLp8_10.csv');
    for i=1:24
    [CCF,P,RL,RU]=corrcoef(DA(i,3:17)',DAN_predict(:,i+1));
    CorrbyOdor(i)=CCF(1,2);
    end    
    CP_All=CorrbyOdor
       
   
 figure;hold on;
    plot(CP_All,'Color',[0,0,0],"LineWidth",1)
    plot(CP_KC,'Color',[0.5,0,0],"LineWidth",1)
    plot(CP_LH,'Color',[0,0.5,0],"LineWidth",1)
    AllCorr=[CP_All;CP_KC;CP_LH];
    set(gca,'XTick',[1:24]);
    set(gca,'XTickLabel',Odor_Label,'Fontsize',15)
    
    
   DAN_predict = readmatrix('v6_mean_NT_DbyPN_All_APLp8_10_noKC.csv');
    for i=1:15
    [CCF,P,RL,RU]=corrcoef(DA(:,i+2)',DAN_predict(i,2:25));
    CorrbyCompartment(i)=CCF(1,2);
    end    
    CP_KC=CorrbyCompartment
      
   
    DAN_predict = readmatrix('v6_mean_NT_DbyPN_All_APLp8_10_noLH.csv');
    for i=1:15
    [CCF,P,RL,RU]=corrcoef(DA(:,i+2)',DAN_predict(i,2:25));
    CorrbyCompartment(i)=CCF(1,2);
    end    
    CP_LH=CorrbyCompartment
    
    DAN_predict = readmatrix('v6_mean_NT_DbyPN_All_APLp8_10.csv');
    for i=1:15
    [CCF,P,RL,RU]=corrcoef(DA(:,i+2)',DAN_predict(i,2:25));
    CorrbyCompartment(i)=CCF(1,2);
    end    
    CP_All=CorrbyCompartment
       
   
 figure;hold on;
    plot(CP_All,'Color',[0,0,0],"LineWidth",1)
    plot(CP_KC,'Color',[0.5,0,0],"LineWidth",1)
    plot(CP_LH,'Color',[0,0.5,0],"LineWidth",1)
    AllCorr=[CP_All;CP_KC;CP_LH];
    set(gca,'XTick',[1:24]);
    set(gca,'XTickLabel',CP_Label,'Fontsize',15)
  AllCorr=[CP_All;CP_KC;CP_LH];
    
        figure;
    for i=1:15
    subplot(3,5,i)
    b=bar(AllCorr(:,i));
    b.FaceColor = 'flat';
    b.CData(2,:) = [.7 0 .7];
    b.CData(3,:) = [0 .7 0];
    ylim([-0.1 0.8])
    xticklabels({'All', 'no KCs', 'noLHNs'})
    title([CP_Label(i)])
    end
    