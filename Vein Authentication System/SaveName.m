function SaveName( name,num ,path)
%SAVENAME Summary of this function goes here
%   Detailed explanation goes here

%

%save name
names= importdata(path);
names=strsplit(cell2mat(names(1,:)),',');

names(num)=cellstr(name);
if(strcmp(names(end),''))
names = names(:,1:end-1);
end

newName='';
for i=1:size(names,2)
newName=strcat(newName,names(i),',');
end
newName=cell2mat(newName);

fid = fopen(path,'wt');
fprintf(fid, '%s', newName);

end