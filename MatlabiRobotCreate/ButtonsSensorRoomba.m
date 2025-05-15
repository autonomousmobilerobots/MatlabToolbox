function [ButtonAdv,ButtonPlay] = ButtonsSensorRoomba(serPort)
%[ButtonAdv,ButtonPlay] = ButtonsSensorRoomba(serPort)
%Displays the state of Create's Play and Advance buttons, either pressed or
%not pressed.

%initialize preliminary return values
ButtonAdv = nan;
ButtonPlay = nan;

% By; Joel Esposito, US Naval Academy, 2011
% Modified by: Chuck Yang, ty244, 2012
% % % Liran 2025 new TCP implementation
try

    %Flush Buffer
    flush(serPort);

    warning off
    global td


    write(serPort, [142 18], "uint8");

    Buttons = dec2bin(read(serPort, 1, "uint8"),8);
    ButtonAdv = bin2dec(Buttons(end-2));
    ButtonPlay = bin2dec(Buttons(end));

    pause(td)
catch
    disp(append('WARNING: function ', mfilename, ' did not execute correctly'));
end