
% checkerboard check

img_ind = load_nii('ind0606_2.nii.gz');
img_ind = single(img_ind.img);

Temp= load_nii('Temp0606_2.nii.gz');
Temp = single(Temp.img);

img_move2 = (single(img_ind)./max(single(img_ind(:)))).^0.3;
img_fix = (single(Temp)./max(single(Temp(:)))).^0.5;

img_move2_2D = squeeze(max(img_move2,[],3));
img_fix2D = squeeze(max(img_fix,[],3));

figure;volshow(Temp);
figure;volshow(img_ind);



figure(4);imshowpair(img_move2_2D,img_fix2D)

res = 10;% checkerboard resolution

figure(1);
hold on;

[CB,CB2]=img_cb(img_move2_2D,img_fix2D,res);
subplot(3,2,3)
imagesc(CB)
subplot(3,2,4)
imagesc(CB2)
