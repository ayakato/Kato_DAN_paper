%Analysis for fig1

load('Fig1_analysis20210904.mat');
%% 
% 

img_ind = load_nii('C:\Users\ayaka\Dropbox\ImageRegistration\ind0606_2.nii.gz');
img_ind = single(img_ind.img);

Temp= load_nii('C:\Users\ayaka\Dropbox\ImageRegistration\Temp0606_2.nii.gz');
Temp = single(Temp.img);

img_move2 = (single(img_ind)./max(single(img_ind(:)))).^0.5;
img_fix = (single(Temp)./max(single(Temp(:)))).^0.5;

img_move2_2D = squeeze(max(img_move2,[],3));
img_fix2D = squeeze(max(img_fix,[],3));

figure;imshowpair(img_fix2D, img_move2_2D, 'ColorChannels','green-magenta')


img_ind = load_nii('C:\Users\ayaka\Dropbox\ImageRegistration\ind0606_2.nii.gz');
img_ind = single(img_ind.img);


Temp= load_nii('C:\Users\ayaka\Dropbox\DANpaper_All_Materials\Fig1 DAN data\DA_190606_2.nii.gz');
Temp = single(Temp.img);

img_move2 = (single(img_ind)./max(single(img_ind(:)))).^0.5;
img_fix = (single(Temp)./max(single(Temp(:)))).^0.3;

img_move2_2D = squeeze(max(img_move2,[],3));
img_fix2D = squeeze(max(img_fix,[],3));

figure;imshowpair(img_fix2D, img_move2_2D,'ColorChannels','green-magenta')



%% 
% 

%% BrainMeanArranged (15 20,27,4) brain mean
%% size(Arranged) 15    20    27     4    21 all raw data

TrialMean=mean(BrainMeanArranged,4);
figure;
subplot(1,3,1)
imagesc(TrialMean(:,3:20,3),[-10 30]);
yticks([1:15])
set(gca,'YTickLabel',CP_Label,'Fontsize',15);
h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
subplot(1,3,2)
imagesc(TrialMean(:,3:20,26),[-10 30]);
yticks([1:15])
set(gca,'YTickLabel',CP_Label,'Fontsize',15);
h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
subplot(1,3,3)
imagesc(TrialMean(:,3:20,27),[-10 30]);
yticks([1:15])
set(gca,'YTickLabel',CP_Label,'Fontsize',15);
h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
colormap gray


MeanOnset=squeeze(mean(BrainMeanArranged(:,5:9,:,:),2));

MeanOnset4trials = reshape(MeanOnset,15,108);

valence=VIall;
CaRes=MeanOnset4trials';

Contribu= CaRes'.*Gbeta(2:16);

figure;
imagesc(Contribu,[-0.2, 0.2])
yticks([1:15])
set(gca,'YTickLabel',CP_Label,'Fontsize',15);
%xticks([1:27])
%set(gca,'XTickLabel',OdorLabel,'Fontsize',15);
%xtickangle(45)
h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];


OdorLabel = {   
'2-pentanone',...
'Banana Essence',...
'2-butanone',...
'Pentyl Acetate',...
'Apple cider vinegar',...
'propionic acid',...
'Methyl Salicilate',...
'water',...
'Mineral Oil',...
'ethyl acetate',...
'Isopentyl Acetate',...
'Benzyl Alcohol',...
'1-butanol',...
'ethyl butyrate',...
'air',...
'Linalool',...
'g-butyrolactone',...
'Methanoic acid',...
'3-methylthio-1-propanol',...
'MCH',...
'3-octanol',...
'Hexyl Acetate',...
'1-octanol',...
'Acetophenone',...
'Butanal',...
'BNZ',...
'2-methylphenol'
};
%%

figure; colormap gray
imagesc(mean(MeanOnset,3),[-10 40]);
yticks([1:15])
set(gca,'YTickLabel',CP_Label,'Fontsize',15);
xticks([1:27])
set(gca,'XTickLabel',OdorLabel,'Fontsize',15);
xtickangle(45)
h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];

%%

figure; colormap parula
imagesc(mean(MeanOnset,3),[-10 40]);
yticks([1:15])
set(gca,'YTickLabel',CP_Label,'Fontsize',15);
xticks([1:27])
set(gca,'XTickLabel',OdorLabel,'Fontsize',15);
xtickangle(45)
h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];

%%

figure; colormap cool
imagesc(mean(MeanOnset,3),[-10 30]);
yticks([1:15])
set(gca,'YTickLabel',CP_Label,'Fontsize',15);
xticks([1:27])
set(gca,'XTickLabel',OdorLabel,'Fontsize',15);
xtickangle(45)
h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
%%
figure; colormap parula

for i=1:15
    subplot(3,5,i)
imagesc(squeeze(MeanOnset(i,:,:)),[-10 30]);
h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
end

%%

CorrValue=zeros(3,15);
for j=1:3
for i=1:15
First=BrainMeanArranged(i,:,:,1);
Other=BrainMeanArranged(i,:,:,j+1);
CorrValue(j,i)=corr2(permute(First,[2 3 1]),permute(Other,[2 3 1]));
end
end
figure;imagesc(CorrValue',[0,1]);
h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
colormap gray;
xticks([1:3])
set(gca,'XTickLabel',{'2','3','4'},'Fontsize',12);
xlabel('Target block#')
yticks([1:15])
set(gca,'YTickLabel',CP_Label,'Fontsize',12);
daspect([1 1 1]); 
colorbar;


CorrValue=zeros(3,27);
for j=1:3
for i=1:27
First=BrainMeanArranged(:,:,i,1);
Other=BrainMeanArranged(:,:,i,j+1);
CorrValue(j,i)=corr2(permute(First,[2 1 3]),permute(Other,[2 1 3]));
end
end

figure;imagesc(CorrValue',[0,1]);
h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
colormap parula;
xticks([1:3])
set(gca,'XTickLabel',{'2','3','4'},'Fontsize',12);
xlabel('Target block#')
yticks([1:27])
set(gca,'YTickLabel',OdorLabel,'Fontsize',12);
daspect([1 1 1]); 
colorbar;
%%
MeanOnset=squeeze(mean(BrainMeanArranged(:,5:9,:,:),2));

CorrValue=zeros(3,15);
for j=1:3
for i=1:15
First=MeanOnset(i,:,1);
Other=MeanOnset(i,:,j+1);
CorrValue(j,i)=corr2(permute(First,[2 1 3]),permute(Other,[2 1 3]));
end
end
figure;imagesc(CorrValue',[0,1]);
h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
colormap gray;
xticks([1:3])
set(gca,'XTickLabel',{'2','3','4'},'Fontsize',12);
xlabel('Target block#')
yticks([1:15])
set(gca,'YTickLabel',CP_Label,'Fontsize',12);
daspect([1 1 1]); 
colorbar;


CorrValue=zeros(3,27);
for j=1:3
for i=1:27
First=MeanOnset(:,i,1);
Other=MeanOnset(:,i,j+1);
CorrValue(j,i)=corr2(permute(First,[2 1 3]),permute(Other,[2 1 3]));
end
end

figure;imagesc(CorrValue',[0,1]);
h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
colormap parula;
xticks([1:3])
set(gca,'XTickLabel',{'2','3','4'},'Fontsize',12);
xlabel('Target block#')
yticks([1:27])
set(gca,'YTickLabel',OdorLabel,'Fontsize',12);
daspect([1 1 1]); 
colorbar;
%%
CorrValue=zeros(3,15,100);
for g=1:100
for j=1:3
rng(g)
for i=1:15
Randi=randperm(27);
First=BrainMeanArranged(i,:,:,1);
Other=BrainMeanArranged(i,Randi,:,j+1);
CorrValue(j,i,g)=corr2(permute(First,[2 3 1]),permute(Other,[2 3 1]));
end
end
end

mCorrValue=mean(CorrValue,3)

figure;imagesc(mCorrValue',[0,1]);
h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
colormap gray;
xticks([1:3])
set(gca,'XTickLabel',{'2','3','4'},'Fontsize',12);
xlabel('Target block#')
yticks([1:15])
set(gca,'YTickLabel',CP_Label,'Fontsize',12);
daspect([1 1 1]); 
colorbar;

CorrValue=zeros(3,27);
for j=1:3
rng(i)
for i=1:27
Randi=randperm(27);
First=BrainMeanArranged(:,:,i,1);
Other=BrainMeanArranged(:,:,Randi(i),j+1);
CorrValue(j,i)=corr2(permute(First,[2 1 3]),permute(Other,[2 1 3]));
end
end

figure;imagesc(CorrValue',[0,1]);
h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
colormap gray;
xticks([1:3])
set(gca,'XTickLabel',{'2','3','4'},'Fontsize',12);
xlabel('Target block#')
yticks([1:27])
set(gca,'YTickLabel',OdorLabel,'Fontsize',12);
daspect([1 1 1]); 
colorbar;

%%


MeanOnset=squeeze(mean(BrainMeanArranged(:,5:9,:,:),2));

CorrValue=zeros(3,15);
for j=1:3
    rng(i)
for i=1:15
    Randi=randperm(15);
First=MeanOnset(i,:,1);
Other=MeanOnset(Randi(i),:,j+1);
CorrValue(j,i)=corr2(permute(First,[2 1 3]),permute(Other,[2 1 3]));
end
end
figure;imagesc(CorrValue',[0,1]);
h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
colormap gray;
xticks([1:3])
set(gca,'XTickLabel',{'2','3','4'},'Fontsize',12);
xlabel('Target block#')
yticks([1:15])
set(gca,'YTickLabel',CP_Label,'Fontsize',12);
daspect([1 1 1]); 
colorbar;


CorrValue=zeros(3,27);
for j=1:3
    rng(i)
for i=1:27
    Randi=randperm(27);
First=MeanOnset(:,i,1);
Other=MeanOnset(:,Randi(i),j+1);
CorrValue(j,i)=corr2(permute(First,[2 1 3]),permute(Other,[2 1 3]));
end
end

figure;imagesc(CorrValue',[0,1]);
h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
colormap parula;
xticks([1:3])
set(gca,'XTickLabel',{'2','3','4'},'Fontsize',12);
xlabel('Target block#')
yticks([1:27])
set(gca,'YTickLabel',OdorLabel,'Fontsize',12);
daspect([1 1 1]); 
colorbar;
%%
MeanOnset=squeeze(mean(BrainMeanArranged(:,5:9,:,:),2));

CorrValue=zeros(3,15);
for j=1:3
for i=1:15

First=MeanOnset(i,:,1);
Other=MeanOnset(i,:,j+1);
CorrValue(j,i)=corr(permute(First,[2 1 3]),permute(Other,[2 1 3]),"Type","Spearman");
end
end
figure;imagesc(CorrValue',[0,1]);
h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
colormap parula;
xticks([1:3])
set(gca,'XTickLabel',{'2','3','4'},'Fontsize',12);
xlabel('Target block#')
yticks([1:15])
set(gca,'YTickLabel',CP_Label,'Fontsize',12);
daspect([1 1 1]); 
colorbar;

CorrValue=zeros(3,27);
for j=1:3
for i=1:27
First=MeanOnset(:,i,1);
Other=MeanOnset(:,i,j+1);
CorrValue(j,i)=corr(permute(First,[2 1 3])',permute(Other,[2 1 3])',"Type","Spearman");
end
end

figure;imagesc(CorrValue',[0,1]);
h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
colormap parula;
xticks([1:3])
set(gca,'XTickLabel',{'2','3','4'},'Fontsize',12);
xlabel('Target block#')
yticks([1:27])
set(gca,'YTickLabel',OdorLabel,'Fontsize',12);
daspect([1 1 1]); 
colorbar;
%%
% %amplitude



FirstValue=zeros(1,15);
OtherValue=zeros(3,15);
CorrValue=zeros(3,15);
for j=1:3
for i=1:15
First=MeanOnset(i,:,1);
Other=MeanOnset(i,:,j+1);
FirstA=permute(First,[2 1 3]);
OtherA=permute(Other,[2 1 3]);
CorrValue(j,i)=mean(OtherA./FirstA);
FirstValue(i)=mean(FirstA);
OtherValue(j,i)=mean(OtherA);
end
end

figure;imagesc(AllFO,[-1 1]);
h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
colormap gray;
xticks([1:4])
set(gca,'XTickLabel',{'1','2','3','4'},'Fontsize',12);
yticks([1:15])
set(gca,'YTickLabel',CP_Label,'Fontsize',12);
daspect([1 1 1]);

AllFO=[FirstValue',OtherValue']./FirstValue';
figure;imagesc(CorrValue',[0,1]);
h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
colormap parula;
xticks([1:3])
set(gca,'XTickLabel',{'2','3','4'},'Fontsize',12);
xlabel('Target block#')
yticks([1:15])
set(gca,'YTickLabel',CP_Label,'Fontsize',12);
daspect([1 1 1]); 
colorbar;


FirstValue=zeros(1,27);
CorrValue=zeros(3,27);
for j=1:3
for i=1:27
First=MeanOnset(:,i,1);
Other=MeanOnset(:,i,j+1);
FirstA=permute(First,[2 1 3]);
OtherA=permute(Other,[2 1 3]);
CorrValue(j,i)=mean(OtherA./FirstA);
FirstValue(i)=mean(FirstA);
end
end

 figure;imagesc(FirstValue');
yticks([1:27])
set(gca,'YTickLabel',OdorLabel,'Fontsize',12);
daspect([1 1 1]); 

figure;imagesc(CorrValue',[0,1]);
h=gca; h.XAxis.TickLength = [0 0];h.YAxis.TickLength = [0 0];
colormap parula;
xticks([1:3])
set(gca,'XTickLabel',{'2','3','4'},'Fontsize',12);
xlabel('Target block#')
yticks([1:27])
set(gca,'YTickLabel',OdorLabel,'Fontsize',12);
daspect([1 1 1]); 
colorbar;


%%


MeanOnset=squeeze(mean(BrainMeanArranged(:,5:9,:,:),2));

dFO=[FirstValue',OtherValue']-[FirstValue',FirstValue',FirstValue',FirstValue']

AllFO=dFO./FirstValue'*100;

AllFO=[FirstValue',OtherValue']

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

set(0,'defaultAxesFontName', 'Arial')
figure;
    for i = 1:15
        hold on;
        plot(AllFO(i,:),'color',ColorPallet(i,:));
    end
xticks([1:4])
set(gca,'XTickLabel',{'1','2','3','4'},'Fontsize',12);
xlabel('Target block#')
daspect([1 4 1]);