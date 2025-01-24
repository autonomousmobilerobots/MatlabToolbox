function [AngleR] = AngleSensorRoomba(serPort)
%[AngleR] = AngleSensorRoomba(serPort)
% Displays the angle in radians and degrees that Create has turned since the angle was last requested.
% Counter-clockwise angles are positive and Clockwise angles are negative.


% By; Joel Esposito, US Naval Academy, 2011
% Modified by: Chuck Yang, ty244, 2012
% % % Liran 2025 new TCP implementation

%Initialize preliminary return values
AngleR = nan;

try

    %Flush Buffer
    flush(serPort);

    warning off
    global td

    write(serPort, [142 20], "uint8");
    while serPort.NumBytesAvailable == 0
        %pause(0.1);
    end
    AngleR = read(serPort, 1, 'int16')*pi/180;
    pause(td)
catch
    disp(append('WARNING: function ', mfilename, ' did not execute correctly'));
end