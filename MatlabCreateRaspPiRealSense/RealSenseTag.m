function tags = RealSenseTag(Robot)
% RealSenseTag(Robot) returns an array of tags
%
%   Robot is the robot struct created by CretePiInit
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
% % Liran 2019, 2023
% % % Liran 2025 new UDP implementation


if nargin<1
    error('Missing serPort argument.  See help RealSenseTag');
end

tags = [];
serPort = Robot.TagPort;

try

    warning off

    % Flush existing buffer
    flush(serPort,"input");

    while (serPort.NumBytesAvailable == 0)
    end

    %Read packet
    resp = read(serPort,serPort.NumBytesAvailable)';

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
        first_id = -1;

        for i=1:num_tags
            loopCounter = (i-1)*5+2;
            id = str2double(dataArr(loopCounter+1));
            if id == first_id % stop when already reprted this tag id
                break
            end
            if i==1
                first_id = id; % firts tag reported
            end
            x = str2double(dataArr(loopCounter+2));
            y = str2double(dataArr(loopCounter+3));
            yaw = str2double(dataArr(loopCounter+4));
            temp = [dt, id, x, y, yaw];
            tags = [tags;temp];
        end
    end

catch
    disp(append('WARNING: function ', mfilename, ' did not execute correctly'));
end

end %function