function InitSSH_Connection(remoteHost, Remote_Command)
%
% InitSSH_Connection(remoteHost, Remote_Command))
%
% Initialize SSH connection with the Rasp Pi and run Remote_Command on the Pi
% Will open a separate command window 
% remoteHost is a string containing the name or IP address of the Pi
% Remote_Command is the initial script to run on the Pi
%
% Example - 
% InitSSH_Connection('WallE', './robot') or 
% InitSSH_Connection('10.253.194.101', './debug')
% 
% Liran 1/2019, 2020

% Connect to host <remoteHost> using Plink (part of Putty)
% Verbose for debug:
% plink = '"C:\Program Files (x86)\PuTTY\plink.exe" -v';
% Silent:
plink = '"C:\Program Files\PuTTY\plink.exe"';

% Log in using user:create, p/w:AMRobot
user = 'create';
PW = 'AMRobot';

% For multiple remote host commands use Commands.txt file:
% Commands.txt has to be in the same folder
% Commands.txt contains the commands to run on the remote host:
%[PATHSTR,NAME,EXT] = fileparts(mfilename('fullpath'));
%CommandFile = [PATHSTR '\Commands.txt'];
%Str = [plink ' -l ' user ' -pw ' PW ' -t ' remoteHost, ' -m ' CommandFile];

% For a single command on remote host enter it directly to the string:
Command = Remote_Command;
Str2 = ['echo yes | ' plink ' -l ' user ' -pw ' PW ' -t ' remoteHost,' ', Command];

% Call it in a separate command window
system([Str2 '&']);

end
