function [ minArr ,maxArr, NoOnes] = mini_max_dist( skelImg )
%MINI_MAX_DIST returns average of min Max algo.
%   Detailed explanation goes here

NoOnes=zeros([1 20]);
maxArr=zeros([1 20]);
minArr=zeros([1 20]);
for index=1:20
    ones1=find(skelImg(10*index,:)==1);
    sizeOnes=size(ones1,2);
    if(sizeOnes >1)
        
        dist=zeros(size(ones1,1),size(ones1,2)-1);
        
        for i= 1:size(ones1,2)-1
            a1=ones1(i+1);
            a2=ones1(i);
            if(a1-a2>1)
                dist(i)=a1-a2-1;
            end
        end
        
        distance=dist(dist>0);
        
        
        if(size(distance,2)>0)
            NoOnes(index)=size(distance,2)+1;
            maxArr(index)=max(distance);
            minArr(index)=min(distance);
        else
            NoOnes(index)=1;
            maxArr(index)=0;
            minArr(index)=0;
        end
        
        %     else if(size(ones1,2)==1)
        %             ones=zeros(1,3);
        %             ones(1)=1;
        %             ones()=ones1(1);
        %             ones(3)=size(skelImg,2);
        %
        %             dist=zeros(1,2);
        %             dist(1)=ones(2)-ones(1);
        %             dist(2)=ones(3)-ones(2);
        %
        %             maxArr(index)=max(dist);
        %             minArr(index)=min(dist);
        
    else
        maxArr(index)=0;
        minArr(index)=0;
        if(sizeOnes==1)
             NoOnes(index)=1;
        end
    end
end
end

