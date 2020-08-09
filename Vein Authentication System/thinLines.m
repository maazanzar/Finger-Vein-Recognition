function [ thin ] = thinLines( img )
%takes image of pattern and thin their lines
%   Detailed explanation goes here

imgSkel=bwmorph(img,'skel','Inf');
% img=removingSmallBraches( imgSkel ,10);
img=imgSkel;
img=bwmorph(bwmorph(img,'dilate',1),'erode',1);
img=removingSmallBraches(img,10);
img=bwmorph(bwmorph(img,'dilate',1),'skel','Inf');
img=removingSmallBraches( img ,10);

img=bwmorph(img,'skel','Inf');
thin=bwmorph(img,'spur');



end