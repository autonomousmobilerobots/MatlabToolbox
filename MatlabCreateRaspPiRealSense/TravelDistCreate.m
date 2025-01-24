function[] = TravelDistCreate(Robot, Speed, Distance)
% Wrapper for travelDist.
%
% Robot is the robot struct created by CretePiInit
% Speed should be between 0.025 and 0.5 m/s
% Distance in meters
%
% See travelDist for more details
%
%% Liran 2023



try
    travelDist(Robot.CreatePort, Speed, Distance)
catch
    disp(append('WARNING: function ', mfilename, ' did not execute correctly'));
end

end