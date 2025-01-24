function [] = SetFwdVelRadiusRoomba(serPort, FwdVel, Radius)
%[] = SetFwdVelRadiusRoomba(serPort, FwdVel, Radius)

%  Moves Roomba by setting forward vel and turn radius
%  serPort is a serial port object created by Roombainit
%  FwdVel is forward vel in m/sec [-0.5, 0.5],
%  Radius in meters, postive turns left, negative turns right [-2,2].
%  Special cases: Straight = inf
%  Turn in place clockwise = -eps
%  Turn in place counter-clockwise = eps

% By; Joel Esposito, US Naval Academy, 2011
% Modified by: Chuck Yang, ty244, 2012
% % % Liran 2025 new TCP implementation

try

    %Flush Buffer
    flush(serPort);

    warning off
    global td

    %% Convert to millimeters
    FwdVelMM = min( max(FwdVel,-.5), .5)*1000;
    if isinf(Radius)
        RadiusMM = 32768;
    elseif Radius == eps
        RadiusMM = 1;
    elseif Radius == -eps
        RadiusMM = -1;
    else
        RadiusMM = min( max(Radius*1000,-2000), 2000);
    end

    [computerType, maxSize, endian] = computer;
    isLittleEndian = (endian == 'L');
    if (isLittleEndian)
        FwdVelMM = typecast(swapbytes(int16(FwdVelMM)),'uint8');
        RadiusMM = typecast(swapbytes(int16(RadiusMM)),'uint8');
    else
        FwdVelMM = typecast(int16(FwdVelMM),'uint8');
        RadiusMM = typecast(int16(RadiusMM),'uint8');
    end

    write(serPort, [137 FwdVelMM RadiusMM], "uint8");
    disp('moving!')
    pause(td)
catch
    disp(append('WARNING: function ', mfilename, ' did not execute correctly'));
end

