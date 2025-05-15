function [Charge, Capacity, Percent] = BatteryChargeReaderRoomba(serPort)
% Displays the current percent charge remaining in Create's Battery

% By; Joel Esposito, US Naval Academy, 2011
% Modified by: Chuck Yang, ty244, 2012
% % % Liran 2025 new TCP implementation

%Initialize preliminary return values
Charge = nan;
Capacity = nan;
Percent = nan;

try

    %Flush Buffer
    flush(serPort);

    warning off
    global td
    write(serPort, [142 25], "uint8");
    Charge =  read(serPort, 1, 'uint16');
    write(serPort, [142 26], "uint8");
    Capacity =  read(serPort, 1, 'uint16');

    Percent=Charge/Capacity*100;

    pause(td)
catch
    disp(append('WARNING: function ', mfilename, ' did not execute correctly'));
end
