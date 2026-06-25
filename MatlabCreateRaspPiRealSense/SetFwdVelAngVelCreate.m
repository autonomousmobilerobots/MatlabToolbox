function [] = SetFwdVelAngVelCreate(Robot, FwdVel, AngVel )
% Wrapper for SetFwdVelAngVelRoomba.
%
% Robot is the robot struct created by CretePiInit
%
% See SetFwdVelAngVelRoomba for more details
%
%% Liran 2026


try

    SetFwdVelAngVelRoomba(Robot.CreatePort, FwdVel, AngVel )
	
catch
    disp(append('WARNING: function ', mfilename, ' did not execute correctly'));
end