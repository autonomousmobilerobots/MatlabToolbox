function [Current] = CurrentTesterRoomba(serPort)
%[Current] = CurrentTesterRoomba(serPort)
% Displays the current (in amps) flowing into or out of Create's battery.
% Negative currents indicate that current is flowing out of the battery.
% Positive currents indicate that current is flowing into the battery.


% By; Joel Esposito, US Naval Academy, 2011
% Modified by: Chuck Yang, ty244, 2012
% % % Liran 2025 new TCP implementation

%Initialize preliminary return values
Current = nan;

try

    %Flush Buffer
    flush(serPort);

    warning off
    global td

    write(serPort, [142 23], "uint8");

    Current = read(serPort, 1, 'int16')/1000;

    pause(td)
catch
    disp(append('WARNING: function ', mfilename, ' did not execute correctly'));
end
