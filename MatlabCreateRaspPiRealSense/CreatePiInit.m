function Robot = CreatePiInit(remoteHost)
% Robot = CreatePiInit(remoteHost)
% This function Initializes an Optitrack client and SSH communication with the Create
% Defines communication ports between the PC and the Create
% Puts the Create in full control mode 
%
% Returns the Robot struct:
% Robot.Name is a string containing the robot name
% Robot.OL_Client - Optitrack NatNet client for overhead localization data
% Robot.CreatePort - tcp port for commands to the Create and sensor data from the Create
% Robot.DistPort - udp port for distance telemetry from the RealSense camera
% Robot.TagPort - udp port for tag telemetry from the RealSense camera
%
% remoteHost is a string with the name or IP address of the Pi
% example: 
% Robot = CreatePiInit('192.168.1.141') or 
% Robot = CreatePiInit('eve') 
%
% Before running this function make sure:
% The Motive server must be running on the Optitrack PC
% The tcp/ip server must be running on the Raspberry Pi 
%
% An optional time delay can be added after all commands
% if your code crashes frequently.  15 ms is recommended by iRobot
%
% By: Chuck Yang, ty244, 2012
% Modified By: Alec Newport, acn55, 2018
% Liran, 2019, 2020

if nargin<1
	error('Missing remoteHost argument.  See help CreatePiInit'); 
end
    
global td
td = 0.015;

Robot.Name = remoteHost;

%Init NatNet client and connect to Optitrack server
Robot.OL_Client = Init_OverheadLocClient();

CreatePortNumber = 8865; % TCP
DistPortNumber = 8833; % UDP
TagPortNumber = 8844; % UDP

% Set up UDP port for distance telemetry
Robot.DistPort = udp(remoteHost, DistPortNumber, 'LocalPort', DistPortNumber);
Robot.DistPort.ReadAsyncMode = 'continuous';
set(Robot.DistPort,'Timeout',1);
Robot.DistPort.inputbuffersize = 512;
try 
    fopen(Robot.DistPort);
    fclose(Robot.DistPort);
catch
    disp('Problem setting up Dist port. Restart Matlab and the robot and run Iit again');
    Robot = [];
    return;
end

% Set up UDP port for tag telemetry
Robot.TagPort = udp(remoteHost, TagPortNumber, 'LocalPort', TagPortNumber);
Robot.TagPort.ReadAsyncMode = 'continuous';
set(Robot.TagPort,'Timeout',1);
Robot.TagPort.inputbuffersize = 512;
try % Check you can open the port
    fopen(Robot.TagPort);
    fclose(Robot.TagPort);
catch
    disp('Problem setting up Tag port. Restart Matlab and the robot and run Init again');
    Robot = [];
    return 
end

% Open SSH connection to the Create, and start the script
InitSSH_Connection(remoteHost, './robot');
% Patience
pause (3);

% Set up TCP port for control commands and data from the Create
Robot.CreatePort = tcpip(remoteHost, CreatePortNumber, 'inputbuffersize', 64);

warning off

disp('Opening connection to iRobot Create...');
try
    fopen(Robot.CreatePort);
    pause(0.5);
catch
    disp('Problem setting up TCP Create port. Restart Matlab and the robot and run Init again');
    Robot = [];
    return
end

%% Confirm two way connumication
disp('Setting iRobot Create to Control Mode...');
% Start! and see if its alive
fwrite(Robot.CreatePort,128);
pause(0.1)

% Set the Create in Full Control mode
% This code puts the robot in CONTROL(132) mode, which means does NOT stop 
% when cliff sensors or wheel drops are true; can also run while plugged 
% into charger
fwrite(Robot.CreatePort,132);
pause(0.1)

% light LEDS
fwrite(Robot.CreatePort,[139 25 0 128]);

% set song
fwrite(Robot.CreatePort, [140 1 1 48 20]);
pause(0.1)

% sing it
fwrite(Robot.CreatePort, [141 1])

pause(0.1)

end
