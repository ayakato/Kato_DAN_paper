
% MainDir='D:\Analysis201211-\Rawdata\MBON_SCH\220119\';
% folderInfo = dir('D:\Analysis201211-\Rawdata\MBON_SCH\220119'); 

    x=64;
    y=64;
    z=20;
    t=300;
    
MainDir='C:\Users\ayaka\Dropbox\DANpaper_All_Materials\Fig5 MBON plasticity\MBONa3\';
folderInfo = dir('C:\Users\ayaka\Dropbox\DANpaper_All_Materials\Fig5 MBON plasticity\MBONa3'); 

folderInfo = folderInfo(~ismember({folderInfo.name}, {'.', '..'}));
folderlist = folderInfo([folderInfo.isdir]);
NfileList = numel(folderlist);

for fileN=21

FoldName=folderInfo(fileN).name;
FoldName_s = FoldName; %extractAfter(FoldName,'20');
data.pathname= [MainDir FoldName];
    
DirOutputIndividual = dir(fullfile([data.pathname '/*.lsm']));
FileNamesIndividual = {DirOutputIndividual.name}';
NumFileNamesIndividual = numel(FileNamkkklesIndividual);  
IntensityAll = zeros([z t NumFileNamesIndividual],'double');
DeltaFOverFAll = zeros([z t NumFileNamesIndividual],'double');

for q=1:NumFileNamesIndividual

    FileNameDirOutputIndividual = fullfile(data.pathname,FileNamesIndividual{q});
    OriginalImage = tiffread30(FileNameDirOutputIndividual, []);
        
    % Create image sequence arrayi

    Int_Sequence = zeros([x y z t]);
    
    for t = 1:300
        for i = 1:z
           % display(['image sequence array ' num2str(size(ImSize.TimeLapsenumRows)), num2str(size(ImSize.TimeLapsenumRowsReduced))]);
            Int_Sequence(:,:,i,t) = OriginalImage(1,z*(t-1)+i).data;
        end
    end
    
    if q == 1
    Temp=Int_Sequence(:,:,:,1);
    end
    
    Registered = zeros(x,y,z,t);
    for tloop = 1:t
        [sequenceRegisteredTemp,ShiftSizeTemp] = ThreeDimensionalRegistration3DinterHighRes(Int_Sequence(:,:,:,tloop),Temp);
        Registered(:,:,:, tloop) = sequenceRegisteredTemp;
    end
    
    
I=mean(Int_Sequence,1);
I2=mean(I,2);

Int=permute(I2,[3,4,2,1]);
% figure;
% imagesc(Int);

%DendriteInt=sum(Int);
baseline=mean(Int(:,6:15),2);
DeltaF=zeros(20,300);

for loopt=1:300
 DeltaF(:,loopt)= (Int(:,loopt)-baseline)./baseline*100;
end

% figure;
% imagesc(DeltaF);

IntensityAll(:,:,q)=Int;
DeltaFOverFAll(:,:,q)=DeltaF;

end
    
   figure;
for q=1:NumFileNamesIndividual

subplot(3,8,q)
imagesc(DeltaFOverFAll(:,:,q));
end

save( [data.pathname '.mat'],'DeltaFOverFAll','IntensityAll');
 
    
    
end  







