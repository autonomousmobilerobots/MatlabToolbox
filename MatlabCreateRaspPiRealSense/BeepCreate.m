function[] = BeepCreate(Robot)
% Wrapper for BeepRoomba.
% 
% Robot is the robot struct created by CretePiInit
%
%
%% Liran 2023
  


	try
		BeepRoomba(Robot.CreatePort)
	catch
		disp(append('WARNING: function ', mfilename, ' did not execute correctly'));    
	end

end