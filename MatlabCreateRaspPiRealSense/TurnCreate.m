function[] = TurnCreate(Robot, Speed, Angle)
% Wrapper for turnAngle.
% 
% Robot is the robot struct created by CretePiInit
% Speed should be between 0 and 0.2
% Angle should be between +/- 360 degrees
%
% See turnAngle for more details
%
%% Liran 2023
  


	try
		turnAngle(Robot.CreatePort, Speed, Angle)
	catch
		disp(append('WARNING: function ', mfilename, ' did not execute correctly'));    
	end

end