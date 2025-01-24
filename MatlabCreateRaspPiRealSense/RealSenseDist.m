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
% % % Liran 2025 new UDP implementation

if nargin<1
    error('Missing serPort argument.  See help RealSenseDist');
end

depth_array = [];
serPort = Robot.DistPort;

num_points = 10; % delay + 9 distance values
PacketSize = num_points * 6 + (num_points- 1); % 6 chars per point + speces between points

try

    warning off


    % Flush existing buffer
    flush(serPort,"input");

    while(serPort.NumBytesAvailable == 0)
    end

    %Read packet
    resp = read(serPort, PacketSize)';

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