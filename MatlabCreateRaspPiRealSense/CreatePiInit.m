function ports = CreatePiInit(remoteHost)
%port = CreatePiInit(remoteHost)
%
% This file initializes a NatNet class client to get Optitrack data
% ports.OL_Client - Optitrack NatNet client
%
% This file initializes 3 ports for use with iRobot Create
% ports.create - tcp port for commands to the create
% ports.dist - udp port for distance telemetry from the Create
% ports.tag - udp port for tag telemetry from the Create
%
% remoteHost is a string with the name or IP address of the Pi
% ex. Ports = CreatePiInit('192.168.1.141') or Ports = CreatePiInit('eve') 
%
% The tcp/ip server must be running on the Raspberry Pi before running this
% function.
% If you receive the error "Unsuccessful open: Connection refused: connect"
% ensure that the server code is running properly on the Raspberry Pi
%
% An optional time delay can be added after all commands
% if your code crashes frequently.  15 ms is recommended by iRobot
%
% By: Chuck Yang, ty244, 2012
% Modified By: Alec Newport, acn55, 2018
% Liran, 2019, 2020

global td
td = 0.015;

CreatePort = 8865; % TCP
DistPort = 8833; % UDP
TagPort = 8844; % UDP

%Init NatNet client and connect to Optitrack server
ports.OL_Client = Init_OverheadLocClient();

% Open SSH connection to the Create, and start the script
InitSSH_Connection(remoteHost, './robot');
% Patience
pause (3);

% use TCP for control commands and data from the Create
ports.create = tcpip(remoteHost, CreatePort, 'inputbuffersize', 64);

% use UDP for distance and tag reading
ports.dist = udp(remoteHost, DistPort, 'LocalPort', DistPort);
ports.tag = udp(remoteHost, TagPort, 'LocalPort', TagPort);

ports.dist.ReadAsyncMode = 'continuous';
set(ports.dist,'Timeout',1);
ports.dist.inputbuffersize = 512;

ports.tag.ReadAsyncMode = 'continuous';
set(ports.tag,'Timeout',1);
ports.tag.inputbuffersize = 512;

warning off

disp('Opening connection to iRobot Create...');
	fopen(ports.create);
	pause(0.5)
% udp ports are opened and closed in the tag and dist functions

%% Confirm two way connumication
disp('Setting iRobot Create to Control Mode...');
% Start! and see if its alive
fwrite(ports.create,128);
pause(0.1)

% Set the Create in Full Control mode
% This code puts the robot in CONTROL(132) mode, which means does NOT stop 
% when cliff sensors or wheel drops are true; can also run while plugged 
% into charger
fwrite(ports.create,132);
pause(0.1)

% light LEDS
fwrite(ports.create,[139 25 0 128]);

% set song
fwrite(ports.create, [140 1 1 48 20]);
pause(0.1)

% sing it
fwrite(ports.create, [141 1])

pause(0.1)

end