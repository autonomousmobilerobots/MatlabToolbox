function [BumpRight,BumpLeft,WheDropRight,WheDropLeft,WheDropCaster,BumpFront] = BumpsWheelDropsSensorsRoomba(serPort);
%[BumpRight,BumpLeft,WheDropRight,WheDropLeft,WheDropCaster,BumpFront] = BumpsWheelDropsSensorsRoomba(serPort)
% Specifies the state of the bump and wheel drop sensors, either triggered
% or not triggered.

% By; Joel Esposito, US Naval Academy, 2011
% Modified by: Chuck Yang, ty244, 2012

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
flushinput(serPort);

warning off
global td

fwrite(serPort, [142 7]);
while serPort.BytesAvailable==0
%     pause(0.1);
end

BmpWheDrps = dec2bin(fread(serPort, 1),8);
% BumpRight = bin2dec(BmpWheDrps(end));
% BumpLeft = bin2dec(BmpWheDrps(end-1));
% WheDropRight = bin2dec(BmpWheDrps(end-2));
% WheDropLeft = bin2dec(BmpWheDrps(end-3));
% WheDropCaster = bin2dec(BmpWheDrps(end-4));
% BumpFront=(BumpRight*BumpLeft);
% if BumpFront==1
%     BumpRight =0;
%     BumpLeft =0;
% end

pause(td)
catch
    disp('WARNING:  BumpsWheelDropsSensorsRoomba function did not terminate correctly.  Output may be unreliable.')
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
    disp('WARNING: Error here')
end

end