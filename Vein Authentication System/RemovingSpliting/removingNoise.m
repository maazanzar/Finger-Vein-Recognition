function [ denoisedimg ] = removingNoise( img,bw )
%REMOVINGNOISE turn black those pixels which are black in bw image 
%   Detailed explanation goes here

[r,c]=size(img);
denoisedimg=img;
for i=1:r
    for j=1:c
        if(bw(i,j)==0)
            denoisedimg(i,j)=0;
        end
    end
end

end

