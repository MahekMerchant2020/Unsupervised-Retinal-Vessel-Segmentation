function accuracy = SegmentationAccuracy()
truth = imread('24_manual1.gif');
xout = imread('RVS_24_training.tif');

[h,w] = size(xout);
tst = zeros(h,w);
tst(xout==truth)=1;
accuracy = 100*sum(sum(tst))/(h*w);
figure(8); imshow(tst, []);
