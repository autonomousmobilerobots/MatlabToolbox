function Pose = Create_Optitrack_Pose(RobotName, OverheadLocClient)
% Create_Optitrack_Pose retrieves the Create pose from Optitrack
%
% RobotName is a string (equal to one of the rigid body assets defined in Motive)
% OverheadLocClient is a Motive client created by Init_OverheadLocClient()
%
% Ex. 
% Pose = Create_Optitrack_Pose('eve', OverheadLocClient)
% Ex. in the lab:
% Pose = Create_Optitrack_Pose(Robot.Name, Robot.OL_Client)
%
% Pose is of the form [X Y Theta Timestamp]
% X,Y in meters
% Theta in radians
% Timestamp in seconds, counted from start of Motive session
%
% If the requested robot name is not valid or is not currently being tracked, returns P=[]
%
% Liran 2020

    if nargin<2
        error('Missing arguments.  See help Create_Optitrack_Pose'); 
    elseif nargin>2
        error('Too many arguments.  See help Create_Optitrack_Pose');
    end

    %Pose = zeros(1,5);
    
    % get the asset descriptions for the tracked asset names
	model = OverheadLocClient.getModelDescription;
    if ( model.RigidBodyCount < 1 )
        fprintf( 'No Robots found\n' )
		return
    end
    
    % get current frame
    data = OverheadLocClient.getFrame; 
    if (isempty(data.RigidBody(1)))
		fprintf( 'Packet is empty or stale\n' )
		return
    end
        
    % find your robot in the packet by name. Case insensitive compare
    num = 0;
    for i = 1:model.RigidBodyCount
        if ( strcmpi(model.RigidBody( i ).Name, RobotName) )
            num = i;
            break
        end    
    end
    
    Pose = [];
    % check if RobotName exists in the optitrack packet
    if (num == 0)
        fprintf( '\t%s is not a valid robot name\n', RobotName )
    else
        % check if it's being tracked
        if (data.RigidBody( num ).Tracked == 1)
            format short g;
            % Position
            Pose(1) = data.RigidBody( num ).x ;
            Pose(2) = data.RigidBody( num ).y ;
            % Calculate Theta from quaternions
            OL_q = quaternion( data.RigidBody( num ).qx, data.RigidBody( num ).qy, data.RigidBody( num ).qz, data.RigidBody( num ).qw );
            qRot = quaternion( 0, 0, 0, 1 );
            q = mtimes( OL_q, qRot );
            angles = EulerAngles( q , 'zyx' );
            Pose(3) = -angles( 3 );
            % Optitrack time stamp
            Pose(4) = data.Timestamp;
        else
            fprintf( '\t%s is not currently tracked\n', model.RigidBody( num ).Name )
        end
    end
end
