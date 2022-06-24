
%% color 15 compartments

MB = load_nii('C:\Users\ayaka\Dropbox\ImageRegistration\C15.nii.gz');
MB = double(MB.img); 
%figure;volshow(MB);
MB(MB>120)=0;

Upper=MB(:,:,1:100);

Upper(Upper>100)=0;

MB(:,:,1:100)=Upper;

MB(256,256,256)=120;

for i=1:256
imcube(:,:,i)=MB(:,:,257-i);
end

%imcube=MB;
figure;
% Pick your color map
cmp = jet;
% Generate your volume object
V = volshow(imcube,...
    'Renderer', 'MaximumIntensityProjection',...
    'Colormap', cmp,...
    'BackgroundColor', [0.5, 0.5, 0.5]);
V.CameraPosition=[4,4,2.5];
V.CameraTarget=[0,0,0];

% Set your new color axis. This does the same thing as caxis normally
% would.
% % % % % % % % % % % % CAXIS EQUIVALENT % % % % % % % % % %
VAxis = [50, 65];
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Generate new scale
newscale = linspace(min(imcube(:)) - min(VAxis(:)),...
    max(imcube(:)) - min(VAxis(:)), size(cmp, 1))/diff(VAxis);
newscale(newscale < 0) = 0;
newscale(newscale > 1) = 1;
% Update colormap in volshow
V.Colormap = interp1(linspace(0, 1, size(cmp, 1)), cmp, newscale);