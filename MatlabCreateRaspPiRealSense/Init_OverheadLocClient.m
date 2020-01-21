function OverheadLocClient = Init_OverheadLocClient()
    % This function initializes a NatNet Client to read streaming object tracking data
    % from the Optitrack Motive server
    % The NatNet SDK from Optitrack has to be in the Matlab Path

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
    OverheadLocClient.HostIP = '128.253.194.102';
    OverheadLocClient.ClientIP = myIP;
    OverheadLocClient.ConnectionType = 'Multicast';
    OverheadLocClient.connect;
    
    if ( OverheadLocClient.IsConnected == 0 )
        fprintf( '\tNatEnt Client failed to connect\n' )
        fprintf( '\tMake sure the Optitrack host is connected and streaming\n' )
    else
        fprintf( '\tConnected to the Optitrack server\n' ) 
    end
end
