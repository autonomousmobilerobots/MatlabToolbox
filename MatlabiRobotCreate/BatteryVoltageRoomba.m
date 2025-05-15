function [Voltage] = BatteryVoltageRoomba(serPort)
%Indicates the voltage of Create's battery in Volts


% By; Joel Esposito, US Naval Academy, 2011
% Modified by: Chuck Yang, ty244, 2012

%Initialize preliminary return values
% % % Liran 2025 new TCP implementation

Voltage = nan;

try

    %Flush Buffer
    flush(serPort);

    warning off
    global td

    write(serPort, [142 25], "uint8");

    Voltage = read(serPort, 1, 'uint16')/1000;

    pause(td)
catch
    disp(append('WARNING: function ', mfilename, ' did not execute correctly'));
end