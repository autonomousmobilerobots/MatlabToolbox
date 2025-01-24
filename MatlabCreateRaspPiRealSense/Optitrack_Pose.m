function Pose = Optitrack_Pose(ObjectName, OverheadLocClient)
% Optitrack_Pose retrieves the Object pose from Optitrack
%
% ObjectName is a string (equal to one of the rigid body assets defined in Motive)
% OverheadLocClient is a Motive client created by Init_OverheadLocClient()
%
% Ex.
% Pose = Optitrack_Pose('eve', OverheadLocClient)
%
% Pose is of the form [X Y Z angleX angleY angleZ]
% If the requested object name is not valid or is not currently being tracked, returns Pose = NaNs
%
% Liran 2020, 2022, 2024

if nargin<2
    error('Missing arguments.  See help Create_Optitrack_Pose');
elseif nargin>2
    error('Too many arguments.  See help Create_Optitrack_Pose');
end

Pose = NaN(4,1);

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
    if ( strcmpi(model.RigidBody( i ).Name, ObjectName) )
        num = i;
        break
    end
end


% check if RobotName exists in the optitrack packet
if (num == 0)
    fprintf( '\t%s is not a valid robot name\n', ObjectName )
else
    % check if it's being tracked
    if (data.RigidBody( num ).Tracked == 1)
        format short g;
        % Position
        Pose(1) = data.RigidBody( num ).x ;
        Pose(2) = data.RigidBody( num ).y ;
        Pose(3) = data.RigidBody( num ).z ;
        % Calculate Theta from quaternions
        OL_q = quaternion( data.RigidBody( num ).qx, data.RigidBody( num ).qy, data.RigidBody( num ).qz, data.RigidBody( num ).qw );
        qRot = quaternion( 0, 0, 0, 1 );
        q = mtimes( OL_q, qRot );
        angles = EulerAngles( q , 'zyx' );
        Pose(4) = -angles( 1 ) * 180 / pi;
        Pose(5) = angles( 2 ) * 180 / pi;
        Pose(6) = -angles( 3 ) * 180 / pi;
        % Optitrack time stamp
        %Pose(4) = data.Timestamp;
    else
        fprintf( '\t%s is not currently tracked\n', model.RigidBody( num ).Name )
    end
end
end