clc;
clear;
close;
%reading the input 
I=imread('IITG.jpg');
I1 = rgb2gray(I);%converting image rgb into gray scale
%intializing input 
Ord=1;
Threshold =600;
Sigma = 1;
order=2*Ord+1;
% derivative masks
fx = [1,1,1;0,0,0;-1,-1,-1];
fy = [1,0,-1;1,0,-1;1,0,-1];
imshow(I1),hold on
% derivative of image 
Ix = conv2(double(I1),fx,'same');
Iy = conv2(double(I1),fy,'same');
Ixy=Ix.*Iy;
Ixx=Ix.*Ix;
Iyy=Iy.*Iy;

%smoothing using gaussian filter
g=fspecial('gaussian',15,Sigma);
Ix2 = conv2(Ixx,g,'same');
Iy2 = conv2(Iyy,g,'same');
Ixy = conv2(Ixy,g,'same');
%computing harris measure
R=(Ix2.*Iy2 - Ixy.^2)./(Ix2 +Iy2);
%finding local maxima
LocalMaxima=ordfilt2(R,order.^2,ones(order));
%thesholding
corner_points=(R==LocalMaxima) & (R> Threshold);
[rows,cols]=find(corner_points);
plot(cols,rows,'.','color','red');

