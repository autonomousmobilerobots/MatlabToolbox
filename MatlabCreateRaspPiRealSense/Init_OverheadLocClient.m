function OverheadLocClient = Init_OverheadLocClient()
    % This function initializes a NatNet Client to read streaming object tracking data
    % from the Optitrack Motive server
    % The NatNet SDK from Optitrack has to be in the Matlab Path
	% Liran 2020, 2021
	
	
    % find local IP used for natnet client
    [~, result] = system('ipconfig');
    start = strfind(result,'IPv4');
    start = start + 36;
    length = strfind(result(start : start + 18), newline) - 2;
    stop = start+ length;
    myIP = result(start:stop);

    % create an instance of the natnet client class
    fprintf( 'Creating NatNet class object\n' )
    OverheadLocClient = natnet;

    % connect the client to the server (multicast over LAN) -
    % If you have the IP for the Optitrack PC:
    % OverheadLocClient.HostIP = '128.253.115.218';
    
    % If you have the DNS hostname for the Optitrack PC:
    OverheadLocClient.HostIP = resolvehost('optitrack-pc.labs.mae.cornell.edu','address'); 
    
    OverheadLocClient.ClientIP = myIP;
    OverheadLocClient.ConnectionType = 'Multicast';
    OverheadLocClient.connect;
    
    
    if ( OverheadLocClient.IsConnected == 0 )
        fprintf( '\tNatEnt Client failed to connect\n' )
        fprintf( '\tMake sure the Optitrack host is connected and streaming\n' )
        OverheadLocClient = 0;
    else
        fprintf( '\tConnected to the Optitrack server\n' ) 
    end
end
