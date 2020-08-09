function [ imgC ] = takeimage( cam )
%takes image through webcam and crop and process that image
%   Detailed explanation goes here

img=cam.snapshot();
imgG=rgb2gray(img);
imgC=imcrop(imgG,[280-18 170 200+10 240-30]);

[r,c]=size(imgC);

% imgA1=imcrop(imgC,[34 34 113 223]);
% m=mean(imgA1);
% 
% m=mean(m);


for i=1:r
    for j=1:c
        
        if(imgC(i,j)>250)
            imgC(i,j)=0;
        end 
        
    end
end
  imgC=imadjust(imgC);
end

