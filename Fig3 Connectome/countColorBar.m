
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
NconutG1_order(:,4)=NconutG1(:,4);
NconutG1_order(:,8)=NconutG1(:,10);
NconutG1_order(:,9)=NconutG1(:,9);
NconutG1_order(:,10)=NconutG1(:,8);

S_NconutG1=sortrows(NconutG1_order,[4,5,6,7,8,9,10],{'ascend' 'descend' 'descend' 'descend' 'descend' 'descend' 'descend'}) ;
figure;imagesc(S_NconutG1(:,4),[0,max(S_NconutG1(:,4))]);
set(gca,'XTick',[1:6]);
set(gca,'XTickLabel',Gro_Label,'Fontsize',10);
colormap jet;
figure;
barh(S_NconutG1(:,4))

NconutG1 = readmatrix('conutG2_ordered_groupNo.csv');

NconutG1_order=NconutG1;
NconutG1_order(:,4)=NconutG1(:,4);
NconutG1_order(:,8)=NconutG1(:,10);
NconutG1_order(:,9)=NconutG1(:,9);
NconutG1_order(:,10)=NconutG1(:,8);

S_NconutG1=sortrows(NconutG1_order,[4,5,6,7,8,9,10],{'ascend' 'descend' 'descend' 'descend' 'descend' 'descend' 'descend'}) ;
figure;imagesc(S_NconutG1(:,4),[0,max(S_NconutG1(:,4))]);
set(gca,'XTick',[1:6]);
set(gca,'XTickLabel',Gro_Label,'Fontsize',10);
colormap jet;
figure;
barh(S_NconutG1(:,4))

NconutG1 = readmatrix('conutG3_ordered_groupNo.csv');

NconutG1_order=NconutG1;
NconutG1_order(:,4)=NconutG1(:,4);
NconutG1_order(:,8)=NconutG1(:,10);
NconutG1_order(:,9)=NconutG1(:,9);
NconutG1_order(:,10)=NconutG1(:,8);

S_NconutG1=sortrows(NconutG1_order,[4,5,6,7,8,9,10],{'ascend' 'descend' 'descend' 'descend' 'descend' 'descend' 'descend'}) ;
figure;imagesc(S_NconutG1(:,4),[0,max(S_NconutG1(:,4))]);
set(gca,'XTick',[1:6]);
set(gca,'XTickLabel',Gro_Label,'Fontsize',10);
colormap jet;



NconutG1 = readmatrix('conutDAN_T.csv');

NconutG1_order=NconutG1;
NconutG1_order(:,4)=NconutG1(:,4);
NconutG1_order(:,8)=NconutG1(:,10);
NconutG1_order(:,9)=NconutG1(:,9);
NconutG1_order(:,10)=NconutG1(:,8);

S_NconutG1=sortrows(NconutG1_order,[4,5,6,7,8,9,10],{'ascend' 'descend' 'descend' 'descend' 'descend' 'descend' 'descend'}) ;
figure;imagesc(S_NconutG1(:,4),[0,max(S_NconutG1(:,4))]);
set(gca,'XTick',[1:6]);
set(gca,'XTickLabel',Gro_Label,'Fontsize',10);
colormap jet;
figure;
barh(S_NconutG1(:,4))
