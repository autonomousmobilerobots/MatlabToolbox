 function tags = RealSenseTag(serPort)
% RealSenseTag(serPort) returns an array of tags
%   
%   serPort: udp port to read tag telemetry
%
%   The sensor frame is defined as x pointing out of the camera (the normal
%   of the front of the camera) and y to the left
%
% Each row of the array is [dt id x y rot]
%   dt = delay from when the image was taken
%   id = The id of the tag
%   x = The x-distance of the tag from the center of the camera (m)
%   y = The y-distance of the tag from the center of the camera (m)
%   rot = The rotation of the tag about the x axis (rad)
%
%   If no tag detected, returns an empty array
%
% Note: if running this in lab serPort = Robot.TagPort

if nargin<1
	error('Missing serPort argument.  See help RealSenseTag'); 
end

% Port should be closed. If it is open close it first 
if (strcmpi(serPort.status,'open'))
		fclose(serPort);
end 

%Open the port	
fopen(serPort);

warning off

while serPort.BytesAvailable==0
    %pause(0.1);
end

%Read packet
resp = fread(serPort, serPort.BytesAvailable); 

fclose(serPort);

if resp == 99
    disp('No camera connected, cannot call this function')
    tags = [];
else
	to_str = char(resp.');
        dataArr = strsplit(to_str, ' ');
        dt = str2double(dataArr(1));
	if strcmp(dataArr(2),'no')
		tags = [];
		return
	end

	num_tags = (size(dataArr)-1)/5;
	num_tags = num_tags(2);
	tags = [];
	
    for i=1:num_tags
        loopCounter = (i-1)*5+2;
        id = str2double(dataArr(loopCounter+1));
        x = str2double(dataArr(loopCounter+2));
        y = str2double(dataArr(loopCounter+3));
        yaw = str2double(dataArr(loopCounter+4));
        temp = [dt, id, x, y, yaw];
        tags = [tags;temp];
    end
end	

end
