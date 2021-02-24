function depth_array = RealSenseDist(serPort)
% RealSenseDist(serPort) returns an array of 10 floats. 
%
% serPort: udp port to read distance telemetry
%
% The first represents the time elapsed since the image was captured
% The remaining elements represent the depth of 9 point in meters from the camera.
%   Inputs: 
%       serPort: udp port to read distance telemetry
%   Outputs:
%       depth_array:  
%       [10 x 1] matrix of floats. 
%       depth_array(1) = delay from image taken
%       depth_array(2:10) = depth to 9 points
%         depth_array(2) is left most point (~27 degrees from center)
%         depth_array(10) is right most point (~-27 degrees from center)
%
% Note the minimum effective distance for the depth sensor is 0.175m, and
% the maximum effective distance is ~10 meters. 
%
% % Note: if running this in lab serPort = Robot.DistPort
 
if nargin<1
	error('Missing serPort argument.  See help RealSenseDist'); 
end

% Port should be closed. If it is open close it first 
if (strcmpi(serPort.status,'open'))
		fclose(serPort);
end 

% Open the port	
fopen(serPort);

warning off

num_points = 10; % delay + 9 distance values

while serPort.BytesAvailable==0
    %pause(0.1); 
end

%Read packet
resp = fread(serPort, serPort.BytesAvailable);

fclose(serPort);

if resp == 99
    disp('No camera connected, cannot call this function')
    depth_array = [];
else
    %convert the response to string
    to_str = char(resp.');
    
    %split by empty space and convert to array of data
    cell_array = strsplit(to_str, ' ');
    
    depth_array = zeros(num_points, 1);
    for i=1:num_points
        depth_array(i) = str2double(cell_array(i));
    end
end

end
