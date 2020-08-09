function [ bw ] = removingPixel( bw,pixelArea,Size )
%REMOVINGPIXEL remove the noise of specified small pixel
%   bw=binary image, pixelArea= specified pixels size, diskSize= Size of disk

if(pixelArea>0)
% remove all object containing fewer than 30 pixels
bw = bwareaopen(bw,pixelArea);
end

if(Size>0)
% fill a gap in the pen's cap
se = strel('disk',Size);
bw = imclose(bw,se);

% fill any holes, so that regionprops can be used to estimate
% the area enclosed by each of the boundaries
bw = imfill(bw,'holes');
end

end

