function DebugPiShutdown(Port)
%
%   The object 'Port' must first be initialized with the 
%   DebugPiInit command 
%
% By: Liran 2/2020

% Before closing communication stop the robot in case it is moving
SetFwdVelAngVelCreate(Port, 0,0);
pause(1);

% Send stop command to terminate the loop on the Pi
data_to_send = ('stop');
fwrite(Port, data_to_send);
pause(1);
 
 
 % Clean up
try
    
    if (strcmpi(Port.status,'open'))
        fclose(Port);
        pause(0.1);
    end
    	
    delete(Port);
    
catch
    disp('WARNING:  Function did not terminate correctly.  Output may be unreliable.')
end

end
