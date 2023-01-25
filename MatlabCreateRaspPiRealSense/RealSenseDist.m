function depth_array = RealSenseDist(Robot)
% RealSenseDist(Robot) returns an array of 10 floats. 
%
% Robot is the robot struct created by CretePiInit
%
% The first number represents the time elapsed since the image was captured
% The remaining elements represent the depth of 9 point in meters from the camera.
%   Inputs: 
%       Robot : robot struct created by Robot = CretePiInit('Hostname')
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
% % Liran 2019, 2023

 
if nargin<1
	error('Missing serPort argument.  See help RealSenseDist'); 
end

depth_array = [];
serPort = Robot.DistPort;

try
    
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
    
catch
    disp(append('WARNING: function ', mfilename, ' did not execute correctly'));
end

end %function