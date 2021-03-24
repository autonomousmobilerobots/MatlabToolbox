function StopCreate(Robot)
% This function stops the robot by setting forward velocity and angular
% velocity to zero
%
% The object 'Robot' must first be initialized with the 
% CreatePiInit function 
%
% By: Liran 2021

if nargin<1
	error('Missing argument.  See help StopCreate'); 
end

% Stop robot
try 
    
    % Set velocities to zero
    SetFwdVelAngVelCreate(Robot.CreatePort, 0,0);
    pause(1);
    
catch
    disp('No longer connected to the robot');
end