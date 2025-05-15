function [BumpRight,BumpLeft,WheDropRight,WheDropLeft,WheDropCaster,BumpFront] = BumpsWheelDropsSensorsRoomba(serPort);
%[BumpRight,BumpLeft,WheDropRight,WheDropLeft,WheDropCaster,BumpFront] = BumpsWheelDropsSensorsRoomba(serPort)
% Specifies the state of the bump and wheel drop sensors, either triggered
% or not triggered.

% By; Joel Esposito, US Naval Academy, 2011
% Modified by: Chuck Yang, ty244, 2012
% % % Liran 2025 new TCP implementation

%Initialize preliminary return values
BumpRight = nan;
BumpLeft = nan;
WheDropRight = nan;
WheDropLeft = nan;
WheDropCaster = nan;
BumpFront = nan;

BmpWheDrps = '00000000';

try

    %Flush Buffer
    flush(serPort);

    warning off
    global td

    write(serPort, [142 7],"uint8");
    while serPort.NumBytesAvailable == 0
        %     pause(0.1);
    end

    BmpWheDrps = dec2bin(read(serPort, 1,"uint8"),8);

    pause(td)
catch
    disp(append('WARNING: function ', mfilename, ' did not execute correctly'));
end

try
    BumpRight = bin2dec(BmpWheDrps(end));
    BumpLeft = bin2dec(BmpWheDrps(end-1));
    WheDropRight = bin2dec(BmpWheDrps(end-2));
    WheDropLeft = bin2dec(BmpWheDrps(end-3));
    WheDropCaster = bin2dec(BmpWheDrps(end-4));
    BumpFront=(BumpRight*BumpLeft);
    if BumpFront==1
        BumpRight =0;
        BumpLeft =0;
    end
catch
    disp(append('WARNING: function ', mfilename, ' did not execute correctly'))
end