function [Signal] = CliffLeftSignalStrengthRoomba(serPort)
%[Signal] = CliffLeftSignalStrengthRoomba(serPort)
%Displays the strength of the left cliff sensor's signal.
%Ranges between 0-100 percent signal



% By; Joel Esposito, US Naval Academy, 2011
% Modified by: Chuck Yang, ty244, 2012
% % % Liran 2025 new TCP implementation

%Initialize preliminary return values
Signal = nan;

try

    %Flush Buffer
    flush(serPort);

    warning off
    global td
    write(serPort, [142 28], "uint8");

    Strength =  read(serPort, 1, 'uint16');
    Signal=(Strength/4095)*100;


    pause(td)
catch
    disp(append('WARNING: function ', mfilename, ' did not execute correctly'));
end

