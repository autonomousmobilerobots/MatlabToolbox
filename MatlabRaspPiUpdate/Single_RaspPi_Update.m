function Single_RaspPi_Update(remoteHost)
%
% Single_RaspPi_Update(remoteHost)
%
% Open SSH session with the Rasp Pi and run PyUpdate to update
% from github
% remoteHost is a string containing the name or IP address of the Pi
%
% Example - 
% Single_RaspPi_Update('WallE') or 
% Single_RaspPi_Update('10.253.194.101')
% 
% Liran 2020

% Connect to host <remoteHost> using Plink (part of Putty)
plink = '"C:\Program Files\PuTTY\plink.exe"';

% Log in using user:create, p/w:AMRobot
user = 'create';
PW = 'AMRobot';

% For a single command on remote host enter it directly to the string:
Command = './PyUpdate';
Str = ['echo yes | ' plink ' -l ' user ' -pw ' PW ' -t ' remoteHost,' ', Command];

% Call it in a separate command window
system([Str '&']);

end
