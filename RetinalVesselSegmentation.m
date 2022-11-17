function output_image = RetinalVesselSegmentation(input_image)

I = imread(input_image);
B = imresize(I, [584 565]);
im = im2double(B);
lab = rgb2lab(im);
figure(1); imshow(lab);
f = 0;

wlab = reshape(bsxfun(@times,cat(3,1-f,f/2,f/2),lab),[],3);
[~,S] = pca(wlab);
S = reshape(S,size(lab));
S = S(:,:,1);
gray = (S-min(S(:)))./(max(S(:))-min(S(:)));

J = adapthisteq(gray,'numTiles',[8 8],'nBins',128);
figure(2); imshow(J);

% Apply Average Filter
h = fspecial('average', [9 9]);
JF = imfilter(J, h);
figure(3); imshow(JF);

Z = imsubtract(JF, J);
figure(4); imshow(Z);

A = im2uint8(Z(:));
[counts,N]=imhist(A);
i=1;

mu=cumsum(counts);
T(i)=(sum(N.*counts))/mu(end);
T(i)=round(T(i));

mu2=cumsum(counts(1:T(i)));
MBT=sum(N(1:T(i)).*counts(1:T(i)))/mu2(end);
mu3=cumsum(counts(T(i):end));
MAT=sum(N(T(i):end).*counts(T(i):end))/mu3(end);
i=i+1;

T(i)=round((MAT+MBT)/2);

while abs(T(i)-T(i-1))>=1
    mu2=cumsum(counts(1:T(i)));
    MBT=sum(N(1:T(i)).*counts(1:T(i)))/mu2(end);
    
    mu3=cumsum(counts(T(i):end));
    MAT=sum(N(T(i):end).*counts(T(i):end))/mu3(end);
    
    i=i+1;
    T(i)=round((MAT+MBT)/2); 
    Threshold=T(i);
end
level = (Threshold - 1) / (N(end) - 1);

BW = imbinarize(Z, level-.008);
figure(5); imshow(BW);

BW2 = bwareaopen(BW, 100);
BW2 = imcomplement(BW2);
figure(6); imshow(BW2);

output_image = 1 - BW2;
figure(7); imshow(output_image);
imwrite(output_image, strcat('RVS_', input_image));

% Tyler Coye (2022). Novel Retinal Vessel Segmentation Algorithm: Fundus Images 
% (https://www.mathworks.com/matlabcentral/fileexchange/50839-novel-retinal-vessel-segmentation-algorithm-fundus-images), 
% MATLAB Central File Exchange. Retrieved November 3, 2022.
