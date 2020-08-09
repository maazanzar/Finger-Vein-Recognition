function [ patternSplit ] = pattern( veinExt , fingerExt )
%PATTERN Takes the pattern Extracted From finger and pattern of vein and
%split pattern of vein in output image
%  veinExt = vein pattern Extracted from finger
%  fingerExt = finger pattern Extracted form scanned image

[r,c] = size(veinExt);
patternSplit=zeros([r,c]);

for i=1:r
    for j=1:c
       if(fingerExt(i,j)==1 && veinExt(i,j)==0)
               patternSplit(i,j)=1;
       end
    end
end

end

