function [state] = VirtualWallSensorCreate(serPort)
% Specifies the state of the virtual wall detector sensor
% Note that the force field on top of the Home Base also trips this sensor
% Either triggered or not triggered

% Salzberger 7/6/10
% % % Liran 2025 new TCP implementation

%Initialize Preliminary return values
state = nan;

try

    %Flush Buffer
    flush(serPort);

    warning off
    global td

    write(serPort, [142 13],'uint8');
    pause(td)
    % write(serPort,13,'uint8');
    % pause(td)

    virtWall = dec2bin(read(serPort, 1, "uint8"));
    state = bin2dec(virtWall(end));
    pause(td)

catch
    disp(append('WARNING: function ', mfilename, ' did not execute correctly'));
end