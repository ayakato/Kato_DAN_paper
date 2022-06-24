
MainDir='E:\Analysis200807-\Rawdata\PE_OPT\201028\';
folderInfo = dir('E:\Analysis200807-\Rawdata\PE_OPT\201028'); 
folderInfo = folderInfo(~ismember({folderInfo.name}, {'.', '..'}));
folderlist = folderInfo([folderInfo.isdir]);
NfileList = numel(folderlist);
ANTsDir='C:\Users\ayaka\Dropbox\ImageRegistration\ind';

numZFramesTemplate=136;
sequenceVOIAll = zeros(256,256,numZFramesTemplate,'uint8');

for fileN=NfileList

FoldName=folderlist(fileN).name;
FoldName_s = FoldName; %extractAfter(FoldName,'20');
pathname= [MainDir FoldName];

str = tiffread30([MainDir FoldName '\MB.tif'], []);
for q = 1:numZFramesTemplate
    sequenceVOIAll(:,:,q) = uint8(str(1,q).data);   
end

sequenceVOIAll(sequenceVOIAll<8)=0;
MB=sequenceVOIAll;

figure;volshow(MB);
%save_nii(make_nii(MB),[ANTsDir FoldName '.nii.gz']);

end







numZFramesTemplate=136;
sequenceVOIAll = zeros(256,256,numZFramesTemplate,'uint8');
%str=tiffread30('C:\Users\ayaka\Documents\ImageAnalysisBadelInternal\RawData\20190809_1\MB.tif')
%str=tiffread30('C:\Users\ayaka\Documents\ImageAnalysis_2019oct\RawData\all_analysis\191218\MB.tif');
str=tiffread30('E:\Analysis200807-\Rawdata\PE_OPT\201028\MB.tif');

%str=tiffread30('C:\Users\ayaka\Documents\ImageAnalysis_2019oct\RawData\200109\2\MB.tif');

% Create image sequence array, template, the end of sequenceTemplate matrix
for q = 1:numZFramesTemplate
    sequenceVOIAll(:,:,q) = uint8(str(1,q).data);   
end

sequenceVOIAll(sequenceVOIAll<3)=0;
MB=sequenceVOIAll;

figure;volshow(MB);
save_nii(make_nii(MB),'C:\Users\ayaka\Dropbox\ImageRegistration\ind201028.nii.gz');

% for z=1:136
% for y=1:256
% for x=1:256
%     MB(x,y,z)=sequenceVOIAll(257-x,257-y,137-z);
% end
% end
% end


figure;volshow(MB);


figure;volshow(TempToInd);

MB = load_nii('C:\Users\ayaka\Dropbox\ImageRegistration\Smooth.nii.gz');
MB = single(MB.img);   

for q = 1:numZFramesTemplate
    sequenceVOIAll(:,:,q) = uint8(cell2mat(str(q).data(2)));   
end

sequenceVOIAll(sequenceVOIAll<8)=0;
MB=sequenceVOIAll;
figure;volshow(MB);
save_nii(make_nii(MB),'C:\Users\ayaka\Dropbox\ImageRegistration\ind1128_2.nii.gz');
