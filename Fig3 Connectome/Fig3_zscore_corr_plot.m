

%%zscore
 DAz=zscore(DA(:,3:17)',0,2);
 clim=[-1 2];
 
 figure;      
imagesc(DAz,clim);
        set(gca,'YTick',[1:15]);
        set(gca,'XTick',[1:24]);
        h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
        set(gca,'YTickLabel',CP_Label,'Fontsize',15);
        set(gca,'XTickLabel',Odor_Label,'Fontsize',10);
        colormap gray;

    figure;
   subplot(2,2,1)
    EM = readmatrix('v6_mean_NT_DbyPN_All_APLp8_10.csv');
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
    
    subplot(2,2,2)
    EM = readmatrix('v7_mean_NT_DbyPN_All_APLp8_10_Mock50.csv'); 
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

   subplot(2,2,4)
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
    
    subplot(2,2,3)
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



DAz=zscore(DA(:,3:17)',0,2);

Corr_A=zeros(10,1);
EMrand = readmatrix('v6_mean_NT_DbyPN_All_APLp8_10_RandA.csv');
EMRand=EMrand(:,2:241);

 for j=1:10   
    ResponseRand=EMRand(:,j*24-23:j*24); 
    corrv=corr2(DAz,zscore(ResponseRand,0,2)); 
    Corr_A(j,1)=corrv; 
 end
Corr_A
mean(Corr_A)
std(Corr_A)
 
Corr_AB=zeros(10,1);
EMrand = readmatrix('v6_mean_NT_DbyPN_All_APLp8_10_RandAB.csv');
EMRand=EMrand(:,2:241);

 for j=1:10   
    ResponseRand=EMRand(:,j*24-23:j*24); 
    corrv=corr2(DAz,zscore(ResponseRand,0,2)); 
    Corr_AB(j,1)=corrv; 
 end
Corr_AB
mean(Corr_AB)
std(Corr_AB)



h




    EM = readmatrix('v6_mean_NT_DbyPN_All_APLp8_10_noLH.csv');   
    imagesc(zscore(EM(:,2:25),0,2));
        set(gca,'YTick',[1:15]);
        set(gca,'XTick',[1:24]);
        h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
        set(gca,'YTickLabel',CP_Label,'Fontsize',15);
        set(gca,'XTickLabel',Odor_Label,'Fontsize',10)
        xtickangle(45)
     corrv=corr2(DAz,zscore(EM(:,2:25),0,2)); 
     title(['noLH z = ', num2str(corrv)])
    colormap gray;
    
    EM = readmatrix('v6_mean_NT_DbyPN_All_APLp8_10_noKC.csv');   
    imagesc(zscore(EM(:,2:25),0,2));
        set(gca,'YTick',[1:15]);
        set(gca,'XTick',[1:24]);
        h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
        set(gca,'YTickLabel',CP_Label,'Fontsize',15);
        set(gca,'XTickLabel',Odor_Label,'Fontsize',10)
        xtickangle(45)
     corrv=corr2(DAz,zscore(EM(:,2:25),0,2)); 
     title(['noKC z = ', num2str(corrv)])
    colormap gray;