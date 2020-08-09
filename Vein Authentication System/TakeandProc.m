function [adjImg,imgPat,imgPat5,splitPat1,thin1]=TakeandProc(exposure)
%TAKEANDPROC Summary of this function goes here
%   Detailed explanation goes here


cam=ReadyCam(exposure);
adjImg=takeimage(cam);

imbw=removingPixel(bradley(adjImg, [555 415], 5),800,1); 
imRe=removingNoise(adjImg,imbw);

imgPat=bradley(imRe, [3 25], .01);
imgPat1=bwmorph(bwmorph(imgPat,'clean','Inf'),'fill','Inf');

imgPat2=imfilter(imgPat1,fspecial('average',[5 5]));

imgPat5=removingPixel(imgPat2,20,1);

%imgPat5=vien ext and removingP.. =fing ext
splitPat=patternSplit(imgPat5,removingPixel(imgPat5,0,20));

splitPat1=bwareaopen(splitPat,500);
 
 for j=1:size(splitPat1)
     splitPat1(1,j)=0;
     splitPat1(size(splitPat1,2),j)=0;
 end
 
filImg=~bwareaopen(~splitPat1,15);
splitPat1=filImg;
%skeletonized image
thin1=thinLines(filImg);


end

