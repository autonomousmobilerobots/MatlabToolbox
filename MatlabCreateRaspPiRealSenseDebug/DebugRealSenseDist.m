function depth_array = DebugRealSenseDist(serPort)
% DebugRealSenseDist(serPort) returns an array of floats, each 
% element of [depth_array] represents the depth of the point in meters,
% from the camera. 
% Requires:
% serPort is a tcp port initialized by DebugPiInit
    
%Flush Buffer    
N = serPort.BytesAvailable();
while(N~=0) 
fread(serPort,N);
N = serPort.BytesAvailable();
end


warning off
global td

num_points = 9;
height = 20;

data_to_send = uint8(strcat('dist  ',num2str(num_points), '  ', num2str(height)));
fwrite(serPort, data_to_send);

disp('waiting for response');
while serPort.BytesAvailable==0
    pause(0.1);
    
end
resp = fread(serPort, serPort.BytesAvailable); % Get response and convert to char array
%convert the response to string 
to_str = char(resp.');
%split by empty space and convert to array of data
cell_array = strsplit(to_str, ' ');

depth_array = zeros(num_points, 1);
for i=1:num_points
    depth_array(i) = str2double(cell_array(i));
end

pause(td)
return
end
