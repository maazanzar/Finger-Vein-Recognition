function  [ cam ] = ReadyCam(varargin  )

list=webcamlist;
if(size(list)==1)

   cam=webcam(1);
else
    cam=webcam('USB2.0 Camera');
end
cam.ExposureMode='manual';
if(length(varargin)==1)
    exposure= cell2mat(varargin(1));
cam.Exposure= exposure;
else
 cam.Exposure=-4;   
end


cam.Brightness=45;
% cam.Brightness=50;
cam.Contrast=127;
cam.Sharpness=12-6;

% cam.Gamma=126;

end