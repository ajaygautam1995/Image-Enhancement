clc;
close all;
clear all;
I1= imread('givenhist.jpg');% this is the given image which has to be modified
a=size(I1);
I2= imread('sphist.jpg'); % this is the required imagae
b= size(I2);
L= zeros(256,1,'uint8');%mapping to uint8
histI1 = imhist(I1); %histogram of image I1 which has to be modified
histI2 = imhist(I2);%histogram of image I2 which is required image 
cdfI1 = cumsum(histI1)/numel(I1); % calculation of cdf for image I1
cdfI2 = cumsum(histI2)/numel(I2);% calculation of 


% mapping
for r=1:256
    [~,s] = min(abs(cdfI1(r)-cdfI2));
    L(r) = s-1;     % s-1 here because s goes from 1 to 256 but M(r) ranges from 0 to 255
end

out = L(double(I1)+1);
% mapped output image
out=L(double(I1)+1);
subplot(2,3,1),imshow(I1);
title('givenhist');
subplot(2,3,2),imshow(I2);
title('sphist');
subplot(2,3,4),imhist(I1)
title('histogram of givenhist.jpg');
subplot(2,3,5),imhist(I2);
title('histogram of sphist.jpg');
subplot(2,3,3),imshow(out);
title('matched image');
subplot(2,3,6),imhist(out);
title('histogram of matched image');