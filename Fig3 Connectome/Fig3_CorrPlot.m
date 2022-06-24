%% mean response
DAz=zscore(DA(:,3:17)',0,2) ;

figure;
   subplot(1,2,1)
    EM = readmatrix('NN_byBlock_mean_wEI_1_DbyPN.csv'); 
      imagesc(zscore(EM(:,2:25),0,2));
        set(gca,'YTick',[1:15]);
        set(gca,'XTick',[1:24]);
        h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
        set(gca,'YTickLabel',CP_Label,'Fontsize',10);
        set(gca,'XTickLabel',Odor_Label,'Fontsize',6)
        xtickangle(45)
     corrv=corr2(DAz,zscore(EM(:,2:25),0,2)); 
    title(['NT Corr2 = ', num2str(corrv)])
    colormap gray;

   subplot(1,2,2)
    EM = readmatrix('NN_byBlock_0_100_DbyPN.csv');   
    imagesc(zscore(EM(:,2:25),0,2));
        set(gca,'YTick',[1:15]);
        set(gca,'XTick',[1:24]);
        h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
        set(gca,'YTickLabel',CP_Label,'Fontsize',10);
        set(gca,'XTickLabel',Odor_Label,'Fontsize',6)
        xtickangle(45)
     corrv=corr2(DAz,zscore(EM(:,2:25),0,2)); 
     title(['Prev Corr2 = ', num2str(corrv)])
    colormap gray;
    
EMRand = readmatrix('NN_NT_mean_RandA_10.csv'); 

corrvA=zeros(1,10);

 for j=1:10
       
   ResponseRand=EMRand(:,j*24-23+1:j*24+1);
   corrvA(j)=corr2(DAz,zscore(ResponseRand,0,2));  
 end
[h,p]= ttest(corrvA,0.449)   
     
EMRand = readmatrix('NN_NT_mean_RandAB_10.csv'); 

corrvAB=zeros(1,10);

 for j=1:10
       
   ResponseRand=EMRand(:,j*24-23+1:j*24+1);
   corrvAB(j)=corr2(DAz,zscore(ResponseRand,0,2));  
 end
   
[h,p]= ttest(corrvAB,0.449)    
    
    
   %% Corr by compartment
    
    EMrand = readmatrix('NN_NT_mean_RandA_10.csv');
    EMRand=EMrand(:,2:241);
   
   CorrRand=zeros(15,10);
  
   for j=1:10
       
   ResponseRand=EMRand(:,j*24-23:j*24);
    for i=1:15
    [CCF,P,RL,RU]=corrcoef(DA(:,i+2)',ResponseRand(i,:));
    CorrRand(i,j)=CCF(1,2);
    end
    
   end
   
    EMrand = readmatrix('NN_NT_mean_RandAB_10.csv');
    EMRand=EMrand(:,2:241);
   
   CorrRand2=zeros(15,10);
  
   for j=1:10
       
   ResponseRand=EMRand(:,j*24-23:j*24);
    for i=1:15
    [CCF,P,RL,RU]=corrcoef(DA(:,i+2)',ResponseRand(i,:));
    CorrRand2(i,j)=CCF(1,2);
    end
    
   end
   
   
   
    DAN_predict = readmatrix('NN_byBlock_mean_wEI_1_DbyPN.csv');
    for i=1:15
    [CCF,P,RL,RU]=corrcoef(DA(:,i+2)',DAN_predict(i,2:25));
    CorrbyCompartment(i)=CCF(1,2);
    end    
    CP1=CorrbyCompartment
    
    
   
 figure;hold on;
    plot(CP1,'Color',[0,0,0],"LineWidth",1)
    CRM=mean(CorrRand,2);
    CRE=std(CorrRand,0,2)/sqrt(size(CorrRand,2));
    errorbar(CRM,CRE,'-s','Color',[0.7,0.7,0.7],"LineWidth",1); 
    
    CRM=mean(CorrRand2,2);
    CRE=std(CorrRand2,0,2)/sqrt(size(CorrRand2,2));
    errorbar(CRM,CRE,'-s','Color',[0.5,0.5,0.5],"LineWidth",1);   
    
    
    legend('Intact','GloSh','AllSh')
    ylim([-0.4,1]);
    xlim([0 16]);
        set(gca,'XTick',[1:15]);
        h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
        set(gca,'XTickLabel',CP_Label,'Fontsize',10);
        

        
        
        

%% 4tiral response
DAz=zscore(MeanOnset4trials,0,2) ;

figure;
   subplot(1,2,1)
    EM = readmatrix('NN_byBlock_0_100_4trials_wEI_1.csv');   
    imagesc(zscore(EM(:,2:101),0,2));
        set(gca,'YTick',[1:15]);
        set(gca,'XTick',[1:101]);
        h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
        set(gca,'YTickLabel',CP_Label,'Fontsize',10);
        xtickangle(45)
     corrv=corr2(DAz,zscore(EM(:,2:101),0,2)); 
     title(['new EI_1 Corr2 = ', num2str(corrv)])
    colormap gray;

   subplot(1,2,2)
    EM = readmatrix('NN_byBlock_0_100_4trials.csv');   
    imagesc(zscore(EM(:,2:101),0,2));
        set(gca,'YTick',[1:15]);
        set(gca,'XTick',[1:101]);
        h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
        set(gca,'YTickLabel',CP_Label,'Fontsize',10);
        xtickangle(45)
     corrv=corr2(DAz,zscore(EM(:,2:101),0,2)); 
     title(['Prev Corr2 = ', num2str(corrv)])
    colormap gray;
    
    
     %% 4Trials     

DA_100=MeanOnset4trials;
  
   EMrand = readmatrix('NN_byBlock_0_100_4trials_RandA.csv');
   EMRand=EMrand(:,2:1001);
   
   
   CorrRand=zeros(15,10);
  
   for j=1:10
       
   ResponseRand=EMRand(:,j*100-99:j*100);
    for i=1:15
    [CCF,P,RL,RU]=corrcoef(DA_100(i,:),ResponseRand(i,:));
    CorrRand(i,j)=CCF(1,2);
    end
    
   end
   
   
   
   EMrand = readmatrix('NN_byBlock_0_100_4trials_RandAB_25.csv');
   EMRand=EMrand(:,2:1001);
   
   
   CorrRand2=zeros(15,10);
  
   for j=1:10
       
   ResponseRand=EMRand(:,j*100-99:j*100);
    for i=1:15
    [CCF,P,RL,RU]=corrcoef(DA_100(i,:),ResponseRand(i,:));
    CorrRand2(i,j)=CCF(1,2);
    end
    
   end
      
   

   
    DAN_predict = readmatrix('NN_byBlock_0_100_4trials_wEI_1.csv');
    for i=1:15
    [CCF,P,RL,RU]=corrcoef(DA_100(i,:),DAN_predict(i,2:101));
    CorrbyCompartment(i)=CCF(1,2);
    end
    
    CP1=CorrbyCompartment
   
 figure;hold on;
    plot(CP1,'Color',[0,0,0],"LineWidth",1)
    CRM=mean(CorrRand,2);
    CRE=std(CorrRand,0,2)/sqrt(size(CorrRand,2));
    errorbar(CRM,CRE,'-s','Color',[0.7,0.7,0.7],"LineWidth",1); 
    
    CRM=mean(CorrRand2,2);
    CRE=std(CorrRand2,0,2)/sqrt(size(CorrRand2,2));
    errorbar(CRM,CRE,'-s','Color',[0.5,0.5,0.5],"LineWidth",1);   
    
    
    legend('Intact','GloSh','AllSh')
    ylim([-0.4,1]);
    xlim([0 16]);
        set(gca,'XTick',[1:15]);
        h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
        set(gca,'XTickLabel',CP_Label,'Fontsize',10);