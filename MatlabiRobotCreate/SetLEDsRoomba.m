function [] = SetLEDsRoomba(serPort, LED,Color, Intensity)
%[] = SetLEDsRoomba(serPort, LED,Color, Intensity)
% Manipulates LEDS
% LED = 0 both off
% LED = 1 Play on
% LED = 2 Advance on
% LED = 3 Both on
% Color determines which color(Red/Green) that the Power LED will
% illuminate as, from 0-100%
% 0 is pure green, 100 is pure red.
% Intensity determines how bright the Power LED appears from 1-100%


% By; Joel Esposito, US Naval Academy, 2011
% Modified by: Chuck Yang, ty244, 2012
% % % Liran 2025 new TCP implementation

%Flush Buffer
flush(serPort);

warning off
global td
%fwrite(serPort, [139, 2,0, 255])
if(LED==0)
    LED=bin2dec('00000000');
end
if(LED==2)
    LED=bin2dec('00001000');
end
if(LED==1)
    LED=bin2dec('00000010');
end
if (LED==3)
    LED=bin2dec('00001010');
end


L= LED;
aColor= (Color/100)*255;
aIntensity = (Intensity/100)*255;

write(serPort, [139 L aColor aIntensity], "uint8");
disp('LEDs Changing')
pause(td)

end