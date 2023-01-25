function TestCreate(Robot)
% TestCreate: runs a quick test of communication and sensors
% 
%   INPUTS
%   Robot       Struct from running CreatePiInit
%
%   The function will try to send commands to the Create and retrieve sensor data
%   sensor data will be printed to the terminal
% 
%  
%   Cornell University
%   Liran Spring 2022, 2023


% Check input
if nargin < 1
    disp('ERROR: Robot object not provided.');
    return;
end


%Beep once to start
BeepCreate(Robot)
pause(0.2);

% read truth pose (from overhead localization system)
[Overhead_poseX, Overhead_poseY, Overhead_poseTheta] = OverheadLocalizationCreate(Robot)
pause(0.2);

%Create sensors:

%read odometry distance & angle
Odom_DistanceSensor = DistanceSensorRoomba(Robot.CreatePort)
Odom_AngleSensor = AngleSensorRoomba(Robot.CreatePort)
pause(0.2);

% read bump data
[BumpRight BumpLeft DropRight DropLeft DropCaster BumpFront] = ...
    BumpsWheelDropsSensorsRoomba(Robot.CreatePort)
pause(0.2);

%read depth data
Depth = RealSenseDist(Robot)
pause(0.2);

%read tags data (beacons)
Tags = RealSenseTag(Robot)
pause(0.2);

% turn a bit
TurnCreate(Robot, 0.2, 30);
pause(0.5);

% move a bit
TravelDistCreate(Robot, 0.1, 0.1);
pause(0.5);

%Beep twice to end
BeepCreate(Robot);
pause(0.5);
BeepCreate(Robot);


end	