function [ RotImg ] = RotateImg( img,angle)
%ROTATEIMG Summary of this function goes here
%   Detailed explanation goes here

J=imrotate(img,angle,'bilinear');
x=(size(J,2)-size(img,2));
y=(size(J,1)-size(img,1));
RotImg=imcrop(J,[x/2 y/2 size(img,1) size(img,2)]);
% findAngle(img)
% J=imrotate(skelImg,-(angle1-angle),'bilinear');

%Since Both dim have same size
if(size(RotImg,1)>size(img,1))
    RotImg=imcrop(RotImg,[2 2 size(img,1) size(img,2)]);
end

end
