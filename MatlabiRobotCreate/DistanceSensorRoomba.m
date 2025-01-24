function [Distance] = DistanceSensorRoomba(serPort)
%[Distance] = DistanceSensorRoomba(serPort)
% Gives the distance traveled in meters since last requested. Positive
% values indicate travel in the forward direction. Negative values indicate
% travel in the reverse direction. If not polled frequently enough, it is
% capped at its minimum or maximum of +/- 32.768 meters.


% By; Joel Esposito, US Naval Academy, 2011
% Modified by: Chuck Yang, ty244, 2012
% % % Liran 2025 new TCP implementation

%Initialize preliminary return values
Distance = nan;

try

    %Flush Buffer
    flush(serPort);

    warning off
    global td

    write(serPort, [142 19], "uint8");

    while serPort.NumBytesAvailable == 0
        %pause(0.1);
    end

    Distance = read(serPort, 1, "int16")/1000;
    if (Distance > 32) || (Distance <-32)
        disp('Warning:  May have overflowed')
    end

    pause(td)
catch
    disp(append('WARNING: function ', mfilename, ' did not execute correctly'));
end
