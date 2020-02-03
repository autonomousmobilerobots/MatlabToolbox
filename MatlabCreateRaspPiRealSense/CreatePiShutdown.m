function CreatePiShutdown(Robot)
%
%   The object 'Robot' must first be initialized with the 
%   CreatePiInit command 
%
% By: Liran 1/2019, 2020

% Before closing communication stop the robot in case it is moving
SetFwdVelAngVelCreate(Robot.CreatePort, 0,0);
pause(1);

% Send stop command to terminate the loop on the Pi
data_to_send = ('stop');
fwrite(Robot.CreatePort, data_to_send);
pause(1);
 
 
 % Clean up
try
    
    Robot.OL_Client.disconnect;
    
    if (strcmp(Robot.CreatePort.status,'open'))
        fclose(Robot.CreatePort);
        pause(0.1);
    end
    	
	if (strcmp(Robot.DistPort.status,'open'))
		fclose(Robot.DistPort);
        pause(0.1);
    end
	
	if (strcmp(Robot.TagPort.status,'open'))
		fclose(Robot.TagPort);
		pause(0.1);
    end	
    
    delete(Robot.CreatePort);
    delete(Robot.DistPort);
	delete(Robot.TagPort);
    
catch
    disp('WARNING:  Function did not terminate correctly.  Output may be unreliable.')
end

end
