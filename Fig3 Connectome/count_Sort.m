

NconutG1 = readmatrix('NconutG1_5.csv');

NconutG1_order=NconutG1;

NconutG1_order(:,7)=NconutG1(:,10);
NconutG1_order(:,8)=NconutG1(:,10);
NconutG1_order(:,9)=NconutG1(:,10);
NconutG1_order(:,10)=NconutG1(:,10);
NconutG1_order(:,11)=NconutG1(:,10);

S_NconutG1=sortrows(NconutG1,[2,3,4,5,6,7,8,9,10],'descend') ;
figure;imagesc(S_NconutG1(:,2:12),[0,1]);
set(gca,'YTick',[1:6]);
set(gca,'YTickLabel',Gro_Label,'Fontsize',10);

NconutG2 = readmatrix('NconutG2_5.csv');

S_NconutG2=sortrows(NconutG2,[2,3,4,5,6,7,8,9,10],'descend');
figure;imagesc(S_NconutG2(:,2:12),[0,1]);

NconutG3 = readmatrix('NconutG3_5.csv');

S_NconutG3=sortrows(NconutG3,[2,3,4,5,6,7,8,9,10],'descend') ;
figure;imagesc(S_NconutG3(:,2:12),[0,1]);


Gro_Label = {
'DM4',...
'DM1',...
'VA1v',...
'DC3'...
'VA6',...
'DL5'
};



NconutG1 = readmatrix('conutG1_ordered_groupNo.csv');

NconutG1_order=NconutG1;
NconutG1_order(:,4)=NconutG1(:,4)/15;
NconutG1_order(:,8)=NconutG1(:,10);
NconutG1_order(:,9)=NconutG1(:,9);
NconutG1_order(:,10)=NconutG1(:,8);

S_NconutG1=sortrows(NconutG1_order,[4,5,6,7,8,9,10],{'ascend' 'descend' 'descend' 'descend' 'descend' 'descend' 'descend'}) ;
figure;imagesc(-S_NconutG1(:,5:10)+1,[0,1]);
set(gca,'XTick',[1:6]);
set(gca,'XTickLabel',Gro_Label,'Fontsize',10);
colormap gray;

NconutG1 = readmatrix('conutG2_ordered_groupNo.csv');

NconutG1_order=NconutG1;
NconutG1_order(:,4)=NconutG1(:,4)/15;
NconutG1_order(:,8)=NconutG1(:,10);
NconutG1_order(:,9)=NconutG1(:,9);
NconutG1_order(:,10)=NconutG1(:,8);

S_NconutG1=sortrows(NconutG1_order,[4,5,6,7,8,9,10],{'ascend' 'descend' 'descend' 'descend' 'descend' 'descend' 'descend'}) ;
figure;imagesc(-S_NconutG1(:,5:10)+1,[0,1]);
set(gca,'XTick',[1:6]);
set(gca,'XTickLabel',Gro_Label,'Fontsize',10);
colormap gray;

NconutG1 = readmatrix('conutG3_ordered_groupNo.csv');

NconutG1_order=NconutG1;
NconutG1_order(:,4)=NconutG1(:,4)/40;
NconutG1_order(:,8)=NconutG1(:,10);
NconutG1_order(:,9)=NconutG1(:,9);
NconutG1_order(:,10)=NconutG1(:,8);

S_NconutG1=sortrows(NconutG1_order,[4,5,6,7,8,9,10],{'ascend' 'descend' 'descend' 'descend' 'descend' 'descend' 'descend'}) ;
figure;imagesc(-S_NconutG1(:,5:10)+1,[0,1]);
set(gca,'XTick',[1:6]);
set(gca,'XTickLabel',Gro_Label,'Fontsize',10);
colormap gray;

NconutG1 = readmatrix('conutDAN_T.csv');

NconutG1_order=NconutG1;
NconutG1_order(:,4)=NconutG1(:,4);
NconutG1_order(:,8)=NconutG1(:,10);
NconutG1_order(:,9)=NconutG1(:,9);
NconutG1_order(:,10)=NconutG1(:,8);

S_NconutG1=sortrows(NconutG1_order,[4,5,6,7,8,9,10],{'ascend' 'descend' 'descend' 'descend' 'descend' 'descend' 'descend'}) ;
figure;imagesc(-S_NconutG1(:,5:10)+1,[0,1]);
set(gca,'XTick',[1:6]);
set(gca,'XTickLabel',Gro_Label,'Fontsize',10);
colormap gray;



NconutG1 = readmatrix('conutG3_ordered_groupNo.csv');

NconutG1_order=NconutG1;
NconutG1_order(:,4)=NconutG1(:,4)/40;
NconutG1_order(:,8)=NconutG1(:,10);
NconutG1_order(:,9)=NconutG1(:,9);
NconutG1_order(:,10)=NconutG1(:,8);

S_NconutG1=sortrows(NconutG1_order,[4,5,6,7,8,9,10],{'ascend' 'descend' 'descend' 'descend' 'descend' 'descend' 'descend'}) ;
figure;imagesc(S_NconutG1(:,4:10),[0,1]);
set(gca,'XTick',[1:7]);
set(gca,'XTickLabel',Gro_Label,'Fontsize',10);
colormap gray;





N_NconutG2 = readmatrix('conutG2_ordered_groupNo.csv');
S_NconutG2=sortrows(N_NconutG2,[4,5,6,7,8,9,10],'descend') ;
figure;imagesc(S_NconutG2(:,4:10),[0,1]);


N_NconutG3 = readmatrix('conutG3_ordered_groupNo.csv');
S_NconutG3=sortrows(N_NconutG3,[4,5,6,7,8,9,10],'descend') ;
figure;imagesc(S_NconutG3(:,5:10),[0,1]);


set(gca,'XTickLabel',Gro_Label,'Fontsize',10);