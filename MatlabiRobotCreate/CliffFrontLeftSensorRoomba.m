function [state] = CliffFrontLeftSensorRoomba(serPort)
%[state] = CliffFrontLeftSensorRoomba(serPort)
% Specifies the state of the Cliff Front Left sensor
% Either triggered or not triggered

% By; Joel Esposito, US Naval Academy, 2011
% Modified by: Chuck Yang, ty244, 2012
% % % Liran 2025 new TCP implementation

%Initialize preliminary return values
state = nan;
try

    %Flush Buffer
    flush(serPort);

    warning off
    global td

    write(serPort, [142 10], "uint8");
    CliffFrntLft = dec2bin(read(serPort, 1, "uint8"));
    state = bin2dec(CliffFrntLft(end));

    pause(td)
catch
    disp(append('WARNING: function ', mfilename, ' did not execute correctly'));
end
