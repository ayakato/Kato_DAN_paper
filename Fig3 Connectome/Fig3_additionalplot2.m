  

AllCorr=[CP_All;CRM_A';CRM_AB'];

    
        figure;
    for i=1:15
    subplot(3,5,i)
    b=bar(AllCorr(:,i));
    errhigh=[0,AllCorr(2,i)+CRE_A(i),AllCorr(3,i)+CRE_AB(i)];
    errlow=[0,AllCorr(2,i)-CRE_A(i),AllCorr(3,i)-CRE_AB(i)];
    b.FaceColor = 'flat';
    b.CData(2,:) = [.7 0 .7];
    b.CData(3,:) = [0 .7 0];
    hold on
    x=1:3;
    er = errorbar(x,AllCorr(:,i),errlow,errhigh);    
    er.Color = [0 0 0];                            
    er.LineStyle = 'none';  
    hold off
    ylim([-0.2 1.1])
    %xticklabels({'Intact', 'GloSh','AllSh'})
    title([CP_Label(i)])
    end        

    
    figure;
    for i=1:3
    subplot(3,1,i);
    b=bar(AllCorr(i,:));
    %errhigh=[0,AllCorr(2,i)+CRE_A(i),AllCorr(3,i)+CRE_AB(i)];
    %errlow=[0,AllCorr(2,i)-CRE_A(i),AllCorr(3,i)-CRE_AB(i)];
    b.FaceColor = 'flat';
    b.CData(2,:) = [.7 0 .7];
    b.CData(3,:) = [0 .7 0];
    hold on
    x=1:3;
    %er = errorbar(x,AllCorr(:,i),errlow,errhigh);    
    %er.Color = [0 0 0];                            
    er.LineStyle = 'none';  
    hold off
    ylim([-0.2 1.1])
    xticklabels({'Intact', 'GloSh','AllSh'})
    title([CP_Label(i)])
    end   