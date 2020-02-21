function CreatePiShutdown(Robot)
% This function terminates communication with the create and closes and
% deletes the ports
%
% The object 'Robot' must first be initialized with the 
% CreatePiInit function 
%
% By: Liran 1/2019, 2020

if nargin<1
	error('Missing argument.  See help CreatePiShutdown'); 
end

% Stop robot and control loop
try 
    
    % Before closing communication stop the robot in case it is moving
    SetFwdVelAngVelCreate(Robot.CreatePort, 0,0);
    pause(1);
    
    % Send stop command to terminate the control loop on the Pi
    data_to_send = ('stop');
    fwrite(Robot.CreatePort, data_to_send);
    pause(1);
    
catch
    disp('No longer connected to the robot');
end
 
 
 % Clean up
try
    
    if (Robot.OL_Client ~= 0) 
        Robot.OL_Client.disconnect;
        pause(0.1);
    end
    
    if (strcmpi(Robot.CreatePort.status,'open'))
        fclose(Robot.CreatePort);
        pause(0.1);
    end
    	
	if (strcmpi(Robot.DistPort.status,'open'))
		fclose(Robot.DistPort);
        pause(0.1);
    end
	
	if (strcmpi(Robot.TagPort.status,'open'))
		fclose(Robot.TagPort);
		pause(0.1);
    end	
    
    delete(Robot.CreatePort);
    delete(Robot.DistPort);
	delete(Robot.TagPort);
    
    disp('Shutdown Completed')
    
catch
    disp('WARNING: Shutdown encountered an error while closing resources')
end

end
