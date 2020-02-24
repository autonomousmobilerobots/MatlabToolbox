function Download_PyUpdate(remoteHost)
%
% Download_PyUpdate(remoteHost)
%
% Open SSH session with the Rasp Pi and download PyUpdate from git
% Will open a separate command window 
% remoteHost is a string containing the name or IP address of the Pi
%
% File 'Commands.txt' has to be in the same folder and contain the following
% 3 lines:
%
% rm PyUpdate
% wget https://raw.githubusercontent.com/autonomousmobilerobots/RaspberryPi/master/PyUpdate
% chmod +x PyUpdate
%
% Liran 2020

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
[PATHSTR,NAME,EXT] = fileparts(mfilename('fullpath'));
CommandFile = [PATHSTR '\Commands.txt'];
Str = ['echo yes | ' plink ' -l ' user ' -pw ' PW ' -t ' remoteHost, ' -m ' CommandFile];

% Call it in a separate command window
system([Str '&']);
end
