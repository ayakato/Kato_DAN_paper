
%% Loading the template and individual VOIs

% Currently the representative glomeruli are DM5, VM2, DA2, DL3, which are
% brightly labeled by NP225-Gal4 and positioned at the surface of the AL.

% 160 x 256 high resolution image and 40 x 64 functional imaging images.
% 160 x 256 image will be embedded to the blank 256 x 256 image and
% 40 x 64 image will be embedded to the blank 64 x 64 image.
% 565 ms per volume and 40 cycles

% Performs subpixel registration by resizing 64 x 64 x 33 image to
% 128 x 128 x 99 image.

tic

%% Load the images


TempToInd = load_nii('C:\Users\ayaka\Dropbox\ImageRegistration\Temp1121_1s.nii.gz');
TempToInd = single(TempToInd.img);   

MB = load_nii('C:\Users\ayaka\Dropbox\ImageRegistration\ind1121_1.nii.gz');
MB = single(MB.img);   

%Selecting and loading the delineeated representative glomeruli from an individual AL
addpath(genpath([cd '\RawData']));
[data.filename,data.pathname] = uigetfile([cd '\RawData' '\*.tif'],...
    'Select a tif file containing delineated glomeruli');
IndividualImage = tiffread30([data.pathname data.filename], []);
J = IndividualImage(1,1).data;                    % J is 256 x 256 image
JSize = size(J);
IndividualImageSize = size(IndividualImage);

%% Setting the parameters
load('Parameters.mat');
%ImSize.CTpixelSize = PixelSizeXY;
ImSize.CTpixelSize = 6.3 ; % pixel size (x and y) in microns, digital zoom = 4.8    
ImSize.CTsliceThickness = SliceThickness;          % slice thickness in microns
ImSize.CTnumRows = JSize(1,2);
ImSize.CTnumSlices = IndividualImageSize(1,2);
ImSize.MRpixelSize = ImSize.CTpixelSize;
ImSize.MRsliceThickness = ImSize.CTsliceThickness;
ImSize.MRnumRows = ImSize.CTnumRows;
ImSize.MRnumRowsReduced = JSize(1,1);        % smaller number of rows to reduce the acquisition time
ImSize.MRnumSlices = ImSize.CTnumSlices;
%numZFramesTemplate = ImSize.CTnumSlices;

BaselineDuration = 4;

% Preallocate the array
IndividualRepresentativeVOI = zeros([ImSize.MRnumRows ImSize.MRnumRows ImSize.MRnumSlices],'uint8');

% Selecting the lsm file containing the high resolution image
[HighResFilename,HighResPathname] = uigetfile([data.pathname '*.tif'],'Select an lsm file containing the high resolution image');

% Create image sequence array
% Place 160 x 256 image in the middle of 256 x 256 image
% (ImSize.MRnumRows-ImSize.MRnumRowsReduced)/2

%EdgeOfImage = (ImSize.MRnumRows-ImSize.MRnumRowsReduced)/2+1;

for i = 1:ImSize.CTnumSlices
    IndividualRepresentativeVOI(:,:,i) = IndividualImage(1,i).data;
end

load('T_paramsInitial.mat');

%% Calculating the extent of VOI overlap

LabeledTemp = find(TempToInd(:,:,:) > 8);
LabeledIndividual = find(MB(:,:,:) > 8);
NumLabeledTemp = numel(LabeledTemp);
NumLabeledIndividual = numel(LabeledIndividual);
NumCommon = numel(intersect(LabeledTemp, LabeledIndividual));
PercentOverlap = NumCommon/NumLabeledTemp;
PercentOverlap2 = NumCommon/NumLabeledIndividual;
display(['Percent overlap is ' num2str(PercentOverlap)]);
display(['Percent overlap2 is ' num2str(PercentOverlap2)]);

%% Extraction of parameters about 4D image
DirOutputIndividual = dir(fullfile([data.pathname '*.lsm']));
FileNamesIndividual = {DirOutputIndividual.name}';
NumFileNamesIndividual = numel(FileNamesIndividual);    % excluding the lsm file containing the high resolution image

FileNameDirOutputIndividual = fullfile(data.pathname,FileNamesIndividual{1});
TemplateImage = tiffread30(FileNameDirOutputIndividual, []);
I = TemplateImage(1,1).data;                    % I is 64 x 64 image

ImSize.TimeLapsepixelSize = TemplateImage(1,1).lsm.VoxelSizeX*10^6;
ImSize.TimeLapsesliceThickness = TemplateImage(1,1).lsm.VoxelSizeZ*10^6;
ImSize.TimeLapsenumRows = TemplateImage(1,1).lsm.DimensionX;
ImSize.TimeLapsenumRowsReduced = TemplateImage(1,1).lsm.DimensionY;
ImSize.TimeLapseSlices = TemplateImage(1,1).lsm.DimensionZ;
ImSize.TimeLapsenumCycle = TemplateImage(1,1).lsm.DimensionTime;
ImSize.numTFrames = ImSize.TimeLapsenumCycle;

%% Creation of template for InterVolume2DRegistration2 from a high resolution image
HighResImage = tiffread30([HighResPathname HighResFilename], []);
K = HighResImage(1,1).data;
% K is 160 x 256 image
% Preallocate the array   bbbbbfssss
HighResolution = zeros([ImSize.MRnumRows ImSize.MRnumRows ImSize.CTnumSlices],'uint8');

% Create image sequence array
for i = 1:ImSize.CTnumSlices
    %HighResolution((EdgeOfImage:(EdgeOfImage+ImSize.MRnumRowsReduced-1)),:,i) = HighResImage(1,ImSize.CTnumSlices+1-i).data;
    %HighResolution (:,:,i)= HighResImage(1,ImSize.CTnumSlices+1-i).data;
    HighResolution (:,:,i)= HighResImage(1,i).data; % from top to bottom
end

HighResolution=uint8(resize(HighResolution,...    % Image size is 128 x 128 x 99
    [(size(HighResolution,1)/2)...
    (size(HighResolution,2)/2)...
    size(HighResolution,3)]));

%% Conversion of the template in 8bit RGB to masks in binary
display('Converting the template to masks...');

load('LabeledColor.mat');          % Load the color info for labels for all 50 VOIs
NumGlomeruliAll = 15;
DimensionOfImage = zeros([ImSize.CTnumRows ImSize.CTnumRows],'uint8');
LabeledArea = DimensionOfImage;
LabeledAreaOneDimension = DimensionOfImage(:);

numZFramesTemplate=136;

for j = 1:NumGlomeruliAll
    for i = 1:numZFramesTemplate
         LabeledPixels = find(TempToInd(:,:,i)==j+50);
        if numel(LabeledPixels) ~= 0
            LabeledAreaOneDimension(LabeledPixels) = 1;
            LabeledArea = reshape(LabeledAreaOneDimension,ImSize.CTnumRows,ImSize.CTnumRows);
            ListOfMasks{j}{i} = LabeledArea;
        else
            ListOfMasks{j}{i} = 0;
        end   
        clear LabeledPixels;
        LabeledAreaOneDimension = DimensionOfImage(:);
    end
end

%% Resize the VOI to match the size of time lapse images
[ListOfMasksResized] = ResizemasksHighRes(NumGlomeruliAll,ListOfMasks,ImSize);

%% 3D registration between HighResolution image and the baseline image of each trial
display('Performing 3D registration for each trials...');

% Preallocate the array
sequenceOriginal = zeros([ImSize.TimeLapsenumRows ImSize.TimeLapsenumRows ImSize.TimeLapseSlices ImSize.numTFrames],'uint8');
Intensity = zeros([NumGlomeruliAll ImSize.numTFrames],'double');
DeltaFOverF = zeros([NumGlomeruliAll ImSize.numTFrames],'double');
DeltaFOverFAll = zeros([NumGlomeruliAll ImSize.numTFrames NumFileNamesIndividual],'double');
IntensityAll = zeros([NumGlomeruliAll ImSize.numTFrames NumFileNamesIndividual],'double');
ShiftSize = zeros([NumFileNamesIndividual ImSize.numTFrames 3],'double');
sequenceRegistered = zeros([size(HighResolution,1) size(HighResolution,2) size(HighResolution,3) ImSize.numTFrames],'single');

display(['Percent overlap is ' num2str(PercentOverlap)]);


for q = 1:NumFileNamesIndividual
    Intensity = zeros([NumGlomeruliAll ImSize.numTFrames],'double');
    
    FileNameDirOutputIndividual = fullfile(data.pathname,FileNamesIndividual{q});
    OriginalImage = tiffread30(FileNameDirOutputIndividual, []);
    
    % Create image sequence arrayi
    for t = 1:ImSize.numTFrames;
        for i = 1:ImSize.TimeLapseSlices
           % display(['image sequence array ' num2str(size(ImSize.TimeLapsenumRows)), num2str(size(ImSize.TimeLapsenumRowsReduced))]);
            sequenceOriginal(((ImSize.TimeLapsenumRows-ImSize.TimeLapsenumRowsReduced)/2+1):...
        ((ImSize.TimeLapsenumRows-ImSize.TimeLapsenumRowsReduced)/2+ImSize.TimeLapsenumRowsReduced),:,i,t)...
        = OriginalImage(1,ImSize.TimeLapseSlices*(t-1)+i).data;
        end
    end
    
    q
    for t = 1:ImSize.numTFrames;
        sequenceOriginalTemp = uint8(resize(sequenceOriginal(:,:,:,t),...
        [size(HighResolution,1) size(HighResolution,2) size(HighResolution,3)]));
        
        [sequenceRegisteredTemp,ShiftSizeTemp] = ThreeDimensionalRegistration3DinterHighRes(sequenceOriginalTemp,HighResolution);
        sequenceRegistered(:,:,:,t) = sequenceRegisteredTemp;
        ShiftSize(q,t,:) = ShiftSizeTemp;
    end
    
    %%
    %sequenceRegistered(:,:,70:80,5:6)=255;
    
    for j = 1:NumGlomeruliAll
        for t = 1:ImSize.numTFrames;
            for i = 1:ImSize.CTnumSlices
                Intensity(j,t) = Intensity(j,t) + sum(sum(sequenceRegistered(:,:,i,t).*ListOfMasksResized{j}{i}));
            end
        end
    end
    
    Baseline = sum(Intensity(:,2:4),2)/3;
    
    for t = 1:ImSize.numTFrames;
        DeltaFOverF(:,t) = (Intensity(:,t)-Baseline)./Baseline;
    end
    
    DeltaFOverFAll(:,:,q) = DeltaFOverF*100;
    IntensityAll(:,:,q)=Intensity;
    
    data.ImSize = ImSize;
    data.T_paramsInitial = T_paramsInitial;
    data.PercentOverlap = PercentOverlap;
    data.DeltaFOverFAll = DeltaFOverFAll;
    data.sequenceRegistered = sequenceRegistered;
    data.IntensityAll = IntensityAll;
    data.ShiftSize = ShiftSize;
    data.MB_RegisteredImages = MB;
    data.IndividualRepresentativeVOI = IndividualRepresentativeVOI;
    data.ListOfMasksResized = ListOfMasksResized;
    data.BaselineDuration = BaselineDuration;
    data.HighResolution = HighResolution;
    
    save([data.pathname 'TempAnts2' '.mat'],'data');
    
end

run verification.m
toc

figure;

for i = 1:NumFileNamesIndividual
    subplot(16,ceil(NumFileNamesIndividual/16),i);
    pcolor(1:size(DeltaFOverFAll,2),1:size(DeltaFOverFAll,1),DeltaFOverFAll(:,:,i))
    shading flat
    caxis([-20 80]);
end

display(['Percent overlap is ' num2str(PercentOverlap)]);

data.ImSize = ImSize;
data.T_paramsInitial = T_paramsInitial;
data.PercentOverlap = PercentOverlap;
data.DeltaFOverFAll = DeltaFOverFAll;
data.sequenceRegistered = sequenceRegistered;
data.Intensity = Intensity;
data.ShiftSize = ShiftSize;
data.MB_RegisteredImages = MB;
data.IndividualRepresentativeVOI = IndividualRepresentativeVOI;
data.ListOfMasksResized = ListOfMasksResized;
data.BaselineDuration = BaselineDuration;
data.HighResolution = HighResolution;

newfilename = strrep(data.pathname, [cd '\RawData\'],'');
data.newfilename = newfilename;
save([data.pathname 'ANTs_s' '.mat'],'data');

 run PCA16odorsDA_0515.m

