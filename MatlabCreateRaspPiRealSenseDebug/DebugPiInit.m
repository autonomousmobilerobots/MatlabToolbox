function port = DebugPiInit(remoteHost)
%port = DebugPiInit(remoteHost)
%
% This file initializes a tcp port for use with iRobot Create
% port - tcp port for commands to the create and receive images
% from Realsense camera
%
% remoteHost is a string with the name or IP address of the Pi
% ex. port = CreatePiInit('192.168.1.141') or Ports = CreatePiInit('eve') 
%
% The tcp/ip server must be running on the Raspberry Pi before running this
% code.
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

% Open SSH connection to the Create, and start the script
InitSSH_Connection(remoteHost, './debug');
% Patience
pause (3);

% use TCP for control commands and data from the Create
% huge buffer for 640x480 32bit image
port = tcpip(remoteHost, CreatePort, 'inputbuffersize', 1228800);

warning off

disp('Opening connection to iRobot Create...');
	fopen(port);
	pause(0.5)
% udp ports are opened and closed in the tag and dist functions

%% Confirm two way connumication
disp('Setting iRobot Create to Control Mode...');
% Start! and see if its alive
fwrite(port,128);
pause(0.1)

% Set the Create in Full Control mode
% This code puts the robot in CONTROL(132) mode, which means does NOT stop 
% when cliff sensors or wheel drops are true; can also run while plugged 
% into charger
fwrite(port,132);
pause(0.1)

% light LEDS
fwrite(port,[139 25 0 128]);

% set song
fwrite(port, [140 1 1 48 20]);
pause(0.1)

% sing it
fwrite(port, [141 1])

pause(0.1)

end
