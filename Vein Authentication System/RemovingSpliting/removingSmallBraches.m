function [ unbrachImg ] = removingSmallBraches( image ,brnchsize)
%Removing Small Branches from skelton image and also removes small loops 
%   Detailed explanation goes here

% image=bwmorph(bwmorph(image,'dilate',1),'erode',1);
% 
% image=bwmorph(bwmorph(image,'dilate',1),'skel','Inf');

Dmask=zeros(size(image));
B =  bwmorph(image,'branchpoints');
D = bwdistgeodesic(image,find(B),'quasi');
    Dmask(D < 2) =true;
    skelD=image-Dmask;

img1=bwmorph(image,'spur',brnchsize);

Dmask=zeros(size(img1));
B =  bwmorph(img1,'branchpoints');
D = bwdistgeodesic(img1,find(B),'quasi');
    Dmask(D < 2) =true;
    Dmask1=img1-Dmask;
brach=xor(img1,Dmask1);

unbrachImg=bwareaopen( skelD|brach|Dmask1,10);

unbrachImg=bwareaopen(unbrachImg,10);

% skel= bwmorph(image,'skel',Inf);
% B = bwmorph(skel, 'branchpoints');
% E = bwmorph(skel, 'endpoints');
% [y,x] = find(E);
% B_loc = find(B);
% Dmask = false(size(skel));
% for k = 1:numel(x)
%     D = bwdistgeodesic(skel,x(k),y(k));
%     distanceToBranchPt = min(D(B_loc));
%     if(distanceToBranchPt<9)
%     Dmask(D < distanceToBranchPt) =true;
%     end
% end
% skelD = skel - Dmask;
% figure,imshow(skelD);
% hold all;
% [y,x] = find(B); plot(x,y,'ro')

% Dmask=zeros(size(image));
% B =  bwmorph(image,'branchpoints');
% [i,j] = find(bwmorph(image,'endpoints'));
% D = bwdistgeodesic(image,find(B),'quasi');
% distanceToBranchPt = min(D(find(B)));
%     Dmask(D < sizimg) =true;
%     skelD=image-Dmask;
% figure,imshow(skelD);
% for n = 1:numel(i)
%     text(j(n),i(n),num2str(D(i(n),j(n))),'color','g');
% end


end

