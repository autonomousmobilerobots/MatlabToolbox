function [] = BeepRoomba(serPort)
%[] = BeepRoomba(serPort)
% Plays a song made by RoombaInit command.

% By; Joel Esposito, US Naval Academy, 2011
% % % Liran 2025 new TCP implementation


% sing it
try
    % flush output buffer
    flush(serPort);

    global td
    write(serPort, [141 1], "uint8")
    pause(td)
catch
    disp(append('WARNING: function ', mfilename, ' did not execute correctly'));
end

end