function [ minAvg, maxAvg ] = MatchMinMax( minArr1, minArr2, maxArr1, maxArr2 )
%MATCHMINMAX Summary of this function goes here
%   Detailed explanation goes here

ResMin=zeros(size(minArr1));
ResMax=zeros(size(minArr1));

for i=1:size(minArr1,2)
    if(minArr1(i)>0&&minArr2(i)>0)
        
        if(minArr1(i)>minArr2(i))
            ResMin(i)=minArr2(i)/minArr1(i);
        else
            ResMin(i)=minArr1(i)/minArr2(i);
        end
    else
        ResMin(i)=0;
    end  
      
    if(maxArr1(i)>0&&maxArr2(i)>0)
        if(maxArr1(i)>maxArr2(i))
            ResMax(i)=maxArr2(i)/maxArr1(i);
        else
            ResMax(i)=maxArr1(i)/maxArr2(i);
        end
    else
        ResMax(i)=0;
    end
    
end
    
% ResultMax=ResMax(ResMax>0);
% ResultMin=ResMin(ResMin>0);

minAvg=sum(ResMin)/size(ResMin,2);
maxAvg=sum(ResMax)/size(ResMax,2);

end

