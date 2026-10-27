// scripts\mp\common\utility\rejoin_utility.gsc  (hash_21a04df18edbd7c9.gscc) (size: 13800 Bytes / 0x35e8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbd174553 (3172418899)
// size ...... 13800 (0x35e8)
// includes .. 8   (offset: 0x3218)
// strings ... 21  (offset: 0x3258)
// dev strs .. 46  (offset: 0x3378)
// exports ... 39  (offset: 0x21f0)
// cseg ...... 0x21b + 0x1fd5 (0x21f0)
// imports ... 74  (offset: 0x2808)
// animtree1 . 0   (offset: 0x35e8)
// animtree2 . 0   (offset: 0x35e8)
#using script_3cb3908b3094b567;
#using scripts\common\ae_utility;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\challenges;
#using scripts\mp\playerachievements;

#namespace rejoin_utility;

// Namespace rejoin_utility
// Params 0
// Checksum 0x538b2760, Offset: 0x239
// Size: 0x147
function main()
{
    if ( !getdvarint( @"hash_22eddf44003baf9", 0 ) )
    {
        return;
    }
    
    level.lobbyid = getlobbyid();
    level.rejoingametype = getmatchmakinggametype();
    level.var_467e8dcf8aed924f = undefined;
    level.var_9d3c45bc520fe7d1 = [];
    level.var_d07d9cc2df831431 = getdvarint( @"hash_35fe3b926d86a034", 1 );
    level.var_ad0ce3b7be0a4ebf = getdvarint( @"hash_d5ff0d8a153049ed", 1 );
    level.var_302ed97406d6a2bf = getdvarint( @"hash_52278a2e894c7b5b", 0 );
    level.var_14cf8f3dc7322363 = getdvarint( @"hash_730841e9076cb2d7", 1 ) == 1;
    level.var_c9deb3d896fc1790 = getdvarint( @"hash_5d13c057b0e9cc7b", 0 ) == 1;
    level.var_d71feeda79e7a947 = getdvarint( @"hash_ae52a11cd305ab26", 1 ) == 1;
    level.var_8de0fb85e5c63004 = getdvarfloat( @"hash_522795feb86c7c2a", 1 );
    level.var_f273bb54bec80b46 = getdvarint( @"hash_a0ff245e856f1777", 1 ) == 1;
    level.var_e64f720a5c73712d = undefined;
    level.var_ec7da16a6197e342 = undefined;
    
    if ( !isdefined( game[ "rejoinedPlayers" ] ) )
    {
        game[ "rejoinedPlayers" ] = [];
    }
    
    level thread function_417893db1199acc7();
    level thread kickDisconnectedPlayers();
}

// Namespace rejoin_utility
// Params 0
// Checksum 0x506963ee, Offset: 0x388
// Size: 0x6c
function function_64baf5672b324eaf()
{
    if ( !isdefined( level.var_55ff2693f4f190ff ) )
    {
        level.var_55ff2693f4f190ff = level.projectbundle.var_6e9a2bee4ff12c69 > 0 ? level.projectbundle.var_6e9a2bee4ff12c69 : 53896;
    }
    
    var_9bf902903ac35624 = getdvarint( @"hash_3c26c38af324c343", level.var_55ff2693f4f190ff );
    return var_9bf902903ac35624;
}

// Namespace rejoin_utility
// Params 0
// Checksum 0xfdef48fe, Offset: 0x3fd
// Size: 0x10
function function_5ed88373949103a8()
{
    return getdvarint( @"hash_22eddf44003baf9", 0 );
}

// Namespace rejoin_utility
// Params 1
// Checksum 0x1a13e0fa, Offset: 0x416
// Size: 0x17
function function_d60b587d531ea116( callbackfn )
{
    level.var_467e8dcf8aed924f = callbackfn;
}

// Namespace rejoin_utility
// Params 1
// Checksum 0xe3bdffde, Offset: 0x435
// Size: 0x4c
function function_70467cdf042579e5( callbackfn )
{
    if ( !getdvarint( @"hash_22eddf44003baf9", 0 ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_9d3c45bc520fe7d1 ) )
    {
        level.var_9d3c45bc520fe7d1 = [];
    }
    
    level.var_9d3c45bc520fe7d1[ level.var_9d3c45bc520fe7d1.size ] = callbackfn;
}

// Namespace rejoin_utility
// Params 1
// Checksum 0x46a20573, Offset: 0x489
// Size: 0x2a
function function_833ae7f0f564dbc1( callbackfn )
{
    if ( !getdvarint( @"hash_22eddf44003baf9", 0 ) )
    {
        return;
    }
    
    level.var_e64f720a5c73712d = callbackfn;
}

// Namespace rejoin_utility
// Params 1
// Checksum 0xb1c7a664, Offset: 0x4bb
// Size: 0x2a
function function_68642548b18c49c8( callbackfn )
{
    if ( !getdvarint( @"hash_22eddf44003baf9", 0 ) )
    {
        return;
    }
    
    level.var_ec7da16a6197e342 = callbackfn;
}

// Namespace rejoin_utility
// Params 1
// Checksum 0x37624a74, Offset: 0x4ed
// Size: 0x29
function function_a8427c2573a6274b( aeeventname )
{
    if ( isdefined( level.var_467e8dcf8aed924f ) )
    {
        return [[ level.var_467e8dcf8aed924f ]]( self, aeeventname );
    }
    
    return [];
}

// Namespace rejoin_utility
// Params 1
// Checksum 0x911d1fc5, Offset: 0x51f
// Size: 0x2a
function function_9eaa89e9a9712502( disconnectreason )
{
    if ( isdefined( level.var_e64f720a5c73712d ) )
    {
        return [[ level.var_e64f720a5c73712d ]]( self, disconnectreason );
    }
    
    return 1;
}

// Namespace rejoin_utility
// Params 1
// Checksum 0x589f3968, Offset: 0x552
// Size: 0x28
function function_158d57dded20e382( aeeventname )
{
    if ( isdefined( level.var_ec7da16a6197e342 ) )
    {
        return [[ level.var_ec7da16a6197e342 ]]( aeeventname );
    }
    
    return [];
}

// Namespace rejoin_utility
// Params 0
// Checksum 0x8256be2, Offset: 0x583
// Size: 0x30, Type: bool
function function_ab1eb191e5cbfd2f()
{
    if ( level.var_ad0ce3b7be0a4ebf )
    {
        return ( ( level.teamdata[ self.team ][ "aliveCount" ] ?? 0 ) > 0 );
    }
    
    return true;
}

// Namespace rejoin_utility
// Params 0
// Checksum 0x47711c8, Offset: 0x5bc
// Size: 0xc8, Type: bool
function function_34321209fb4483f3()
{
    if ( level.var_302ed97406d6a2bf >= 1 )
    {
        teamsremaining = 0;
        
        foreach ( entry in level.teamnamelist )
        {
            alivecount = level.teamdata[ entry ][ "aliveCount" ];
            
            if ( alivecount > 0 )
            {
                teamsremaining++;
            }
            
            if ( teamsremaining >= level.var_302ed97406d6a2bf )
            {
                return true;
            }
        }
        
        return false;
    }
    
    return true;
}

// Namespace rejoin_utility
// Params 1
// Checksum 0x51d2b440, Offset: 0x68d
// Size: 0x1b2, Type: bool
function function_c728287c89d803eb( var_b5a798314313c162 )
{
    var_20ab6f31d1a424e4 = 0;
    
    switch ( var_b5a798314313c162 )
    {
        case 0:
            var_20ab6f31d1a424e4 = 0;
            break;
        case 1:
        case 2:
            var_20ab6f31d1a424e4 = getdvarint( @"hash_1839b10b70a97d91", 0 );
            break;
        case 3:
            var_20ab6f31d1a424e4 = getdvarint( @"hash_f690f29f47f7a379", 0 );
            break;
        case 6:
            var_20ab6f31d1a424e4 = getdvarint( @"hash_b37dbaa903c45ccd", 1 );
            break;
        case 7:
            var_20ab6f31d1a424e4 = getdvarint( @"online_rejoin_allow_inactivity", 0 );
            
            if ( var_20ab6f31d1a424e4 && !self isfireteamleader() )
            {
                var_20ab6f31d1a424e4 = getdvarint( @"hash_7b93fc0921b32cde", 0 );
            }
            
            break;
        case 14:
            var_20ab6f31d1a424e4 = getdvarint( @"online_rejoin_allow_force_disconnect", 0 );
            break;
        default:
            var_20ab6f31d1a424e4 = 1;
            break;
    }
    
    if ( !var_20ab6f31d1a424e4 )
    {
        /#
            logstring( "<dev string:x24>" + self getxuid() + "<dev string:x79>" + var_b5a798314313c162 );
        #/
        
        return false;
    }
    
    var_20ab6f31d1a424e4 = function_9eaa89e9a9712502( var_b5a798314313c162 );
    
    if ( !var_20ab6f31d1a424e4 )
    {
        /#
            logstring( "<dev string:x24>" + self getxuid() + "<dev string:x84>" );
        #/
        
        return false;
    }
    
    var_20ab6f31d1a424e4 = function_34321209fb4483f3();
    
    if ( !var_20ab6f31d1a424e4 )
    {
        /#
            logstring( "<dev string:x24>" + self getxuid() + "<dev string:xa3>" );
        #/
        
        return false;
    }
    
    var_20ab6f31d1a424e4 = function_ab1eb191e5cbfd2f();
    
    if ( !var_20ab6f31d1a424e4 )
    {
        /#
            logstring( "<dev string:x24>" + self getxuid() + "<dev string:xc9>" );
        #/
        
        return false;
    }
    
    return true;
}

// Namespace rejoin_utility
// Params 1
// Checksum 0x9d3192c6, Offset: 0x848
// Size: 0xd2
function function_1bb448ec60f0fe28( disconnectreason )
{
    player = self;
    player.pers[ #"hash_f1ad586476829628" ] = { #playerteam:player.team, #var_5c6965693aa60943:gettime(), #playerorigin:player.origin, #var_6167bb7aa9d4cd5:player usinggamepad(), #var_3fc96699436e7dcf:player ispcplayer(), #isplayerinwater:player isswimming(), #isplayerinvehicle:player vehicle::is_in_vehicle(), #isplayeronground:player isonground(), #var_86a196615967b3ef:disconnectreason, #var_ba069afba327931f:0, #var_538118c7a2893edc:1 };
}

// Namespace rejoin_utility
// Params 1
// Checksum 0x9b1f4137, Offset: 0x922
// Size: 0x30a
function function_59a5b9e87473d7( isrejoinsuccessful )
{
    player = self;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( !isdefined( player.pers[ #"hash_f1ad586476829628" ] ) )
    {
        return;
    }
    
    var_dfbdc207cde145c1 = player.pers[ #"hash_f1ad586476829628" ];
    
    if ( !var_dfbdc207cde145c1.var_538118c7a2893edc )
    {
        return;
    }
    
    eventparams = [];
    eventparams[ eventparams.size ] = "is_rejoin_successful";
    eventparams[ eventparams.size ] = isrejoinsuccessful;
    eventparams[ eventparams.size ] = "rejoin_type";
    eventparams[ eventparams.size ] = var_dfbdc207cde145c1.var_86a196615967b3ef;
    eventparams[ eventparams.size ] = "rejoin_duration";
    rejoinduration = -1;
    
    if ( isdefined( var_dfbdc207cde145c1.var_5c6965693aa60943 ) )
    {
        rejoinduration = ( gettime() - var_dfbdc207cde145c1.var_5c6965693aa60943 ) / 1000;
    }
    
    eventparams[ eventparams.size ] = int( rejoinduration );
    eventparams[ eventparams.size ] = "player_x";
    eventparams[ eventparams.size ] = var_dfbdc207cde145c1.playerorigin[ 0 ];
    eventparams[ eventparams.size ] = "player_y";
    eventparams[ eventparams.size ] = var_dfbdc207cde145c1.playerorigin[ 1 ];
    eventparams[ eventparams.size ] = "player_z";
    eventparams[ eventparams.size ] = var_dfbdc207cde145c1.playerorigin[ 2 ];
    eventparams[ eventparams.size ] = "squad_size";
    numteammates = -1;
    
    if ( isdefined( level.teamdata ) )
    {
        numteammates = int( level.teamdata[ var_dfbdc207cde145c1.playerteam ][ "players" ].size );
    }
    
    eventparams[ eventparams.size ] = numteammates;
    eventparams[ eventparams.size ] = "player_platform";
    eventparams[ eventparams.size ] = var_dfbdc207cde145c1.var_3fc96699436e7dcf;
    eventparams[ eventparams.size ] = "player_input";
    eventparams[ eventparams.size ] = var_dfbdc207cde145c1.var_6167bb7aa9d4cd5;
    eventparams[ eventparams.size ] = "match_alive_players_left";
    alivecounttotal = -1;
    
    if ( isdefined( level.teamnamelist ) && isdefined( level.teamdata ) )
    {
        foreach ( entry in level.teamnamelist )
        {
            alivecounttotal += level.teamdata[ entry ][ "aliveCount" ];
        }
        
        alivecounttotal++;
    }
    
    eventparams[ eventparams.size ] = alivecounttotal;
    eventparams[ eventparams.size ] = "is_player_swimming";
    eventparams[ eventparams.size ] = var_dfbdc207cde145c1.isplayerinwater;
    eventparams[ eventparams.size ] = "is_player_in_vehicle";
    eventparams[ eventparams.size ] = var_dfbdc207cde145c1.isplayerinvehicle;
    eventparams[ eventparams.size ] = "is_player_on_ground";
    eventparams[ eventparams.size ] = var_dfbdc207cde145c1.isplayeronground;
    player dlog_recordplayerevent( "dlog_event_br_disconnect_rejoin", eventparams );
    var_dfbdc207cde145c1.var_ba069afba327931f = 1;
    var_dfbdc207cde145c1.var_538118c7a2893edc = 0;
}

// Namespace rejoin_utility
// Params 2
// Checksum 0x16d691d8, Offset: 0xc34
// Size: 0x44
function function_d0971a04cc9cdde8( kvparray, key )
{
    i = 0;
    
    while ( i < kvparray.size - 1 )
    {
        if ( kvparray[ i ] == key )
        {
            return i;
        }
        
        i += 2;
    }
}

// Namespace rejoin_utility
// Params 3
// Checksum 0x513f3c39, Offset: 0xc81
// Size: 0x1a3
function combinekvparrays( array1, array2, var_4d6e62204178e453 )
{
    combined = [];
    
    if ( !isarray( array1 ) || array1.size % 2 != 0 || !isarray( array2 ) || array2.size % 2 != 0 )
    {
        utility::error( "called rejoin_utility::combineKVPArrays with invalid array" );
        return combined;
    }
    
    keys = [];
    values = [];
    i = 0;
    j = 0;
    
    while ( i < array1.size - 1 || j < array2.size - 1 )
    {
        if ( i < array1.size - 1 && !arraycontains( keys, array1[ i ] ) )
        {
            keys[ keys.size ] = array1[ i ];
            values[ values.size ] = array1[ i + 1 ];
        }
        
        if ( j < array2.size - 1 && !arraycontains( keys, array2[ j ] ) )
        {
            keys[ keys.size ] = array2[ j ];
            values[ values.size ] = array2[ j + 1 ];
        }
        
        i += 2;
        j += 2;
    }
    
    preferredarray = var_4d6e62204178e453 ? array2 : array1;
    i = 0;
    
    while ( i < preferredarray.size - 1 )
    {
        key = preferredarray[ i ];
        dupindex = function_f02c63b99c9614c9( keys, key );
        
        if ( isdefined( dupindex ) )
        {
            values[ dupindex ] = preferredarray[ i + 1 ];
        }
        
        i += 2;
    }
    
    for ( i = 0; i < keys.size ; i++ )
    {
        combined[ combined.size ] = keys[ i ];
        combined[ combined.size ] = values[ i ];
    }
    
    return combined;
}

// Namespace rejoin_utility
// Params 10
// Checksum 0xc4401184, Offset: 0xe2d
// Size: 0x1a1
function function_5e5a4b7d5451b95f( eventparams, aeeventname, rejoinactive, reason, gametype, gamemode, lobbyid, expiry, playlistversion, var_1ed0897997cfed8a )
{
    rejoinkey = ae_utility::function_70b8bc68f3d8031e( aeeventname, #"rejoin_is_active" );
    reasonkey = ae_utility::function_70b8bc68f3d8031e( aeeventname, #"disconnect_reason" );
    gametypekey = ae_utility::function_70b8bc68f3d8031e( aeeventname, #"leagueplay_gametype" );
    gamemodekey = ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" );
    var_c1298551f9386ac2 = ae_utility::function_70b8bc68f3d8031e( aeeventname, #"rejoin_lobby_id" );
    expirykey = ae_utility::function_70b8bc68f3d8031e( aeeventname, #"rejoin_expiry" );
    versionkey = ae_utility::function_70b8bc68f3d8031e( aeeventname, #"playlist_version" );
    var_34487fbc7fec1ec1 = ae_utility::function_70b8bc68f3d8031e( aeeventname, #"netcode_version" );
    
    if ( !isdefined( eventparams[ rejoinkey ] ) )
    {
        eventparams[ rejoinkey ] = rejoinactive;
    }
    
    if ( !isdefined( eventparams[ reasonkey ] ) )
    {
        eventparams[ reasonkey ] = reason;
    }
    
    if ( !isdefined( eventparams[ gametypekey ] ) )
    {
        eventparams[ gametypekey ] = gametype;
    }
    
    if ( !isdefined( eventparams[ gamemodekey ] ) )
    {
        eventparams[ gamemodekey ] = gamemode;
    }
    
    if ( !isdefined( eventparams[ var_c1298551f9386ac2 ] ) )
    {
        eventparams[ var_c1298551f9386ac2 ] = lobbyid;
    }
    
    if ( !isdefined( eventparams[ expirykey ] ) )
    {
        eventparams[ expirykey ] = expiry;
    }
    
    if ( !isdefined( eventparams[ versionkey ] ) )
    {
        eventparams[ versionkey ] = playlistversion;
    }
    
    if ( !isdefined( eventparams[ var_34487fbc7fec1ec1 ] ) )
    {
        eventparams[ var_34487fbc7fec1ec1 ] = var_1ed0897997cfed8a;
    }
    
    return eventparams;
}

// Namespace rejoin_utility
// Params 0
// Checksum 0xb6bb262, Offset: 0xfd7
// Size: 0x53
function rejoin_matchstart()
{
    if ( !level.onlinegame )
    {
        println( "<dev string:xef>" );
        return;
    }
    
    if ( !getdvarint( @"hash_22eddf44003baf9", 0 ) )
    {
        return;
    }
    
    rejoinallowed = getdvarint( @"hash_925f7dceb8e6205e", 0 );
    function_bf028e9e4a180ae7( rejoinallowed );
}

// Namespace rejoin_utility
// Params 0
// Checksum 0xd353b92f, Offset: 0x1032
// Size: 0x2b
function rejoin_matchend()
{
    if ( !getdvarint( @"hash_22eddf44003baf9", 0 ) )
    {
        return;
    }
    
    level notify( #"hash_d9eeb249e507fd71" );
    function_bf028e9e4a180ae7( 0, 1 );
}

// Namespace rejoin_utility
// Params 0
// Checksum 0x4bad8683, Offset: 0x1065
// Size: 0x90
function function_15fb2aded9cc3a03()
{
    if ( !level.onlinegame )
    {
        println( "<dev string:x128>" );
        return;
    }
    
    if ( !getdvarint( @"hash_22eddf44003baf9", 0 ) )
    {
        return;
    }
    
    rejoinallowed = getdvarint( @"hash_925f7dceb8e6205e", 0 );
    println( "<dev string:x167>" + rejoinallowed );
    aeeventname = #"connection_update";
    
    if ( rejoinallowed )
    {
        function_fc17c87ddeb1d12f( 0, 0, 1, aeeventname, [] );
        return;
    }
    
    setlobbynotrejoinable( 0, 1, aeeventname, [] );
}

// Namespace rejoin_utility
// Params 1
// Checksum 0x70bc2ab0, Offset: 0x10fd
// Size: 0x27
function function_d9013cdee100bb2a( xuid )
{
    if ( !isdefined( game[ "rejoinedPlayers" ] ) )
    {
        return 0;
    }
    
    return arraycontains( game[ "rejoinedPlayers" ], xuid );
}

// Namespace rejoin_utility
// Params 0
// Checksum 0xddd107a9, Offset: 0x112d
// Size: 0x219
function function_ac16d309f31e42a()
{
    self endon( #"disconnect" );
    level endon( #"hash_d9eeb249e507fd71" );
    
    if ( !getdvarint( @"hash_22eddf44003baf9", 0 ) )
    {
        return;
    }
    
    xuid = self getxuid();
    
    if ( getdvarint( @"online_rejoin_wait_for_streaming", 0 ) )
    {
        if ( isdefined( level.var_3c4eb636fe7d9813 ) )
        {
            self thread [[ level.var_3c4eb636fe7d9813 ]]();
        }
        
        if ( isdefined( level.var_d473ce16938624c2 ) )
        {
            self [[ level.var_d473ce16938624c2 ]]();
        }
    }
    
    if ( !function_d9013cdee100bb2a( xuid ) )
    {
        println( "<dev string:x1a0>" + self.name + "<dev string:x1c8>" + xuid + "<dev string:x1cb>" );
        
        if ( !isdefined( game[ "rejoinedPlayers" ] ) )
        {
            game[ "rejoinedPlayers" ] = [];
        }
        
        game[ "rejoinedPlayers" ][ game[ "rejoinedPlayers" ].size ] = xuid;
    }
    else
    {
        println( "<dev string:x1e5>" + self.name + "<dev string:x1c8>" + xuid + "<dev string:x206>" );
    }
    
    function_5a2ac7936556e701( undefined, 0, undefined );
    thread function_59a5b9e87473d7( 1 );
    self notify( #"afk_tracking_resume" );
    
    if ( level.var_f273bb54bec80b46 )
    {
        self.pers[ "distTrackingPassedOrResetTime" ] = mp_afk::function_a10af3f5e26c28da();
        self.var_64484dbc6cb3dff6 = 1;
    }
    
    self.var_5875cc527b6de6cd = 0;
    
    if ( isdefined( self.var_3ac39ef107e8744a ) && self.var_3ac39ef107e8744a )
    {
        self.var_3ac39ef107e8744a = 0;
    }
    
    if ( isdefined( level.var_d47d77389e8e75e2 ) )
    {
        self [[ level.var_d47d77389e8e75e2 ]]();
    }
    
    if ( isdefined( level.var_9d3c45bc520fe7d1 ) )
    {
        foreach ( callback in level.var_9d3c45bc520fe7d1 )
        {
            [[ callback ]]( self );
        }
    }
}

// Namespace rejoin_utility
// Params 2
// Checksum 0xca43f7c0, Offset: 0x134e
// Size: 0x265
function rejoin_ondisconnect( disconnectreason, allowrejoin )
{
    aeeventname = #"connection_update";
    additionalkvps = function_a8427c2573a6274b( aeeventname );
    rejoinallowed = getdvarint( @"hash_925f7dceb8e6205e", 0 );
    
    if ( getdvarint( @"hash_22eddf44003baf9", 0 ) != 0 && rejoinallowed )
    {
        var_b5a798314313c162 = function_3c29720c0519d8c7( disconnectreason );
        function_5a2ac7936556e701( undefined, istrue( allowrejoin ), undefined );
        rejoinable = 0;
        
        if ( var_b5a798314313c162 != 0 && !self isplayerheadless() )
        {
            rejoinable = function_c728287c89d803eb( var_b5a798314313c162 );
            
            if ( rejoinable )
            {
                xuid = self getxuid();
                println( "<dev string:x237>" + self.name + "<dev string:x1c8>" + xuid + "<dev string:x255>" );
                
                if ( function_d9013cdee100bb2a( xuid ) )
                {
                    var_b5a798314313c162 = 5;
                    additionalkvps[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"disconnect_reason" ) ] = var_b5a798314313c162;
                    rejoinable = getdvarint( @"online_rejoin_allow_repeated_disconnect", 0 );
                    println( "<dev string:x237>" + self.name + "<dev string:x1c8>" + xuid + "<dev string:x295>" + ( rejoinable ? "<dev string:x2c1>" : "<dev string:x2c2>" ) + "<dev string:x2c6>" );
                }
            }
        }
        
        if ( !allowrejoin )
        {
            rejoinable = 0;
        }
        
        if ( rejoinable )
        {
            function_fc17c87ddeb1d12f( var_b5a798314313c162, 1, 1, aeeventname, additionalkvps );
            function_1bb448ec60f0fe28( var_b5a798314313c162 );
            self.var_5875cc527b6de6cd = 1;
            
            if ( level.var_14cf8f3dc7322363 )
            {
                wait level.var_8de0fb85e5c63004;
                vehicle = self.vehicle;
                
                if ( isdefined( vehicle ) )
                {
                    driver = vehicle_occupancy::get_driver( vehicle );
                    
                    if ( isdefined( driver ) && driver == self )
                    {
                        thread vehicle_occupancy::exit( vehicle, undefined, self, undefined, 1 );
                    }
                }
            }
            
            if ( level.var_c9deb3d896fc1790 )
            {
                wait level.var_8de0fb85e5c63004;
                self suicide();
            }
        }
        else
        {
            setlobbynotrejoinable( var_b5a798314313c162, 1, aeeventname, additionalkvps );
            thread function_59a5b9e87473d7( 0 );
        }
    }
    else if ( getdvarint( @"hash_e5ad75d059b063", 1 ) == 1 )
    {
        var_b5a798314313c162 = function_3c29720c0519d8c7( disconnectreason );
        function_3f54ec84b16bd38a( var_b5a798314313c162, aeeventname, additionalkvps );
    }
    else
    {
        function_c2376828d6dec3ff( aeeventname, additionalkvps );
    }
    
    thread challenges::function_21b5f21603591966( self );
}

// Namespace rejoin_utility
// Params 0, eflags: 0x4
// Checksum 0x3ee4ab44, Offset: 0x15bb
// Size: 0x187
function private function_417893db1199acc7()
{
    level endon( #"hash_d9eeb249e507fd71" );
    var_2d3d7207c0ccd0c9 = getdvarint( @"hash_a799c3f7e51b5934", 1 );
    
    if ( var_2d3d7207c0ccd0c9 <= 1 )
    {
        var_2d3d7207c0ccd0c9 = 1;
    }
    
    wait var_2d3d7207c0ccd0c9;
    
    /#
        logstring( "<dev string:x2da>" );
    #/
    
    while ( true )
    {
        /#
            logstring( "<dev string:x32d>" );
        #/
        
        var_1843c4be02ac44fe = [];
        
        if ( !isdefined( level.players ) || level.players.size == 0 )
        {
            /#
                logstring( "<dev string:x381>" );
            #/
        }
        else
        {
            foreach ( player in level.players )
            {
                if ( isdefined( player ) && player function_e421863f0f4de34() )
                {
                    if ( player function_8572dd98c6c59dc4() )
                    {
                        /#
                            logstring( "<dev string:x3e5>" + player getxuid() + "<dev string:x421>" );
                        #/
                        
                        var_1843c4be02ac44fe[ var_1843c4be02ac44fe.size ] = player;
                    }
                }
            }
        }
        
        if ( var_1843c4be02ac44fe.size > 0 )
        {
            var_9bf902903ac35624 = function_64baf5672b324eaf();
            function_6e150ba45a6aa08( var_1843c4be02ac44fe, var_9bf902903ac35624 );
        }
        
        waitdelayseconds = getdvarint( @"hash_cb027608b7396745", 30 );
        
        if ( waitdelayseconds <= 10 )
        {
            waitdelayseconds = 10;
        }
        
        wait waitdelayseconds;
    }
}

// Namespace rejoin_utility
// Params 0, eflags: 0x4
// Checksum 0x5b916ef6, Offset: 0x174a
// Size: 0x1b1
function private kickDisconnectedPlayers()
{
    level endon( #"hash_d9eeb249e507fd71" );
    waitdelayseconds = getdvarint( @"hash_e1b1c0bfb40859f", 1 );
    
    if ( waitdelayseconds <= 1 )
    {
        waitdelayseconds = 1;
    }
    
    var_bb83ea67c648abba = int( ceil( getmaxclients() / waitdelayseconds / level.framedurationseconds ) );
    throttle_gate = throttle::function_ac02df3f2e81cbab( "kickDisconnectedPlayers", var_bb83ea67c648abba, undefined, waitdelayseconds );
    
    while ( true )
    {
        throttle::function_706ed379a3746335( throttle_gate );
        
        if ( !isdefined( level.players ) || level.players.size == 0 )
        {
            continue;
        }
        
        foreach ( player in level.players )
        {
            throttle::function_1302aa73badc74f0( throttle_gate );
            
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( player function_14857c4b0deab0a4() )
            {
                if ( player.pers[ #"hash_f1ad586476829628" ].var_ba069afba327931f == 1 )
                {
                    kick( player getentitynumber(), &"exe/playerkicked_rejoin" );
                }
                
                continue;
            }
            
            if ( player function_e421863f0f4de34() )
            {
                if ( !player function_8572dd98c6c59dc4() )
                {
                    /#
                        logstring( "<dev string:x43c>" + player getxuid() + "<dev string:x488>" );
                    #/
                    
                    kick( player getentitynumber(), &"exe/playerkicked_rejoin" );
                }
            }
        }
    }
}

// Namespace rejoin_utility
// Params 2
// Checksum 0x5c8c91ae, Offset: 0x1903
// Size: 0x182
function function_ad8206146833a442( achievementid, progressdata )
{
    var_9bf902903ac35624 = function_64baf5672b324eaf();
    
    if ( achievementid == var_9bf902903ac35624 )
    {
        reason_id = playerachievements::function_a550b9c75bcbee5e( "reason" );
        reason = 0;
        
        for ( index = 0; index < progressdata.progress_values.size ; index++ )
        {
            progress_id = progressdata.progress_values[ index ].progress_id;
            
            if ( reason_id == progress_id )
            {
                reason = progressdata.progress_values[ index ].progress;
                break;
            }
        }
        
        println( "<dev string:x4ad>" + self.name + "<dev string:x4ee>" + achievementid + "<dev string:x4f8>" + reason );
        
        if ( reason == 10 )
        {
            /#
                logstring( "<dev string:x502>" + self getxuid() + "<dev string:x542>" );
            #/
            
            function_5a2ac7936556e701( undefined, undefined, 1 );
            thread function_59a5b9e87473d7( 0 );
            return;
        }
        
        if ( reason == 16 )
        {
            /#
                logstring( "<dev string:x502>" + self getxuid() + "<dev string:x55f>" );
            #/
            
            function_5a2ac7936556e701( undefined, undefined, 1 );
            thread function_59a5b9e87473d7( 0 );
            return;
        }
        
        if ( reason == 11 )
        {
            /#
                logstring( "<dev string:x502>" + self getxuid() + "<dev string:x55f>" );
            #/
            
            function_5a2ac7936556e701( undefined, undefined, 1 );
            thread function_59a5b9e87473d7( 0 );
        }
    }
}

// Namespace rejoin_utility
// Params 3
// Checksum 0x61741a52, Offset: 0x1a8d
// Size: 0xcd
function function_5a2ac7936556e701( var_fadd4f8a748eaea7, var_797beb3c52ef77ad, rejoinrejected )
{
    if ( !isdefined( self.pers[ #"hash_681a2bd6f1948ba7" ] ) )
    {
        self.pers[ #"hash_681a2bd6f1948ba7" ] = { #rejoinrejected:istrue( rejoinrejected ), #var_797beb3c52ef77ad:istrue( var_797beb3c52ef77ad ), #var_fadd4f8a748eaea7:istrue( var_fadd4f8a748eaea7 ) };
        return;
    }
    
    var_be31e08e4cb3e694 = self.pers[ #"hash_681a2bd6f1948ba7" ];
    
    if ( isdefined( var_fadd4f8a748eaea7 ) )
    {
        var_be31e08e4cb3e694.var_fadd4f8a748eaea7 = var_fadd4f8a748eaea7;
    }
    
    if ( isdefined( var_797beb3c52ef77ad ) )
    {
        var_be31e08e4cb3e694.var_797beb3c52ef77ad = var_797beb3c52ef77ad;
    }
    
    if ( isdefined( rejoinrejected ) )
    {
        var_be31e08e4cb3e694.rejoinrejected = rejoinrejected;
    }
}

// Namespace rejoin_utility
// Params 0
// Checksum 0x515ee66e, Offset: 0x1b62
// Size: 0x20, Type: bool
function function_8572dd98c6c59dc4()
{
    return istrue( self.pers[ #"hash_681a2bd6f1948ba7" ].var_fadd4f8a748eaea7 );
}

// Namespace rejoin_utility
// Params 0
// Checksum 0xa74ff7f1, Offset: 0x1b8b
// Size: 0x20, Type: bool
function function_e421863f0f4de34()
{
    return istrue( self.pers[ #"hash_681a2bd6f1948ba7" ].var_797beb3c52ef77ad );
}

// Namespace rejoin_utility
// Params 0
// Checksum 0x67514ce2, Offset: 0x1bb4
// Size: 0x20, Type: bool
function function_14857c4b0deab0a4()
{
    return istrue( self.pers[ #"hash_681a2bd6f1948ba7" ].rejoinrejected );
}

// Namespace rejoin_utility
// Params 2
// Checksum 0xe2ed2d1a, Offset: 0x1bdd
// Size: 0x13e
function function_bf028e9e4a180ae7( rejoinable, var_ca3cdd1dbcb9fbd7 )
{
    rejoinallowed = getdvarint( @"hash_925f7dceb8e6205e", 0 );
    aeeventname = #"connection_update";
    canrejoin = rejoinallowed && rejoinable;
    var_762a1032bb7a3833 = [];
    
    foreach ( player in level.players )
    {
        var_762a1032bb7a3833[ var_762a1032bb7a3833.size ] = player;
        
        if ( canrejoin )
        {
            player function_fc17c87ddeb1d12f( 0, 0, 0, aeeventname, [] );
            continue;
        }
        
        if ( var_ca3cdd1dbcb9fbd7 && player function_e421863f0f4de34() )
        {
            additionalkvps = function_158d57dded20e382( aeeventname );
            player setlobbynotrejoinable( 17, 0, aeeventname, additionalkvps );
            continue;
        }
        
        player setlobbynotrejoinable( 0, 0, aeeventname, [] );
    }
    
    if ( var_762a1032bb7a3833.size > 0 )
    {
        function_1d896b82d2846d1a( var_762a1032bb7a3833, canrejoin );
    }
}

// Namespace rejoin_utility
// Params 0
// Checksum 0x47d3c733, Offset: 0x1d23
// Size: 0x45
function function_b47f0ab881878ae5()
{
    now = getsystemtime();
    rejoin_duration = getdvarint( @"online_rejoin_expiry_time_s", 0 );
    rejoin_expiry = rejoin_duration == 0 ? 0 : now + rejoin_duration;
    return rejoin_expiry;
}

// Namespace rejoin_utility
// Params 5
// Checksum 0x45a704a9, Offset: 0x1d71
// Size: 0x194
function function_fc17c87ddeb1d12f( reason, setexpiry, var_f0848d8fcd2c903b, aeeventname, additionalkvps )
{
    if ( !level.onlinegame )
    {
        println( "<dev string:x580>" );
        return;
    }
    
    if ( !getdvarint( @"hash_925f7dceb8e6205e", 0 ) )
    {
        println( "<dev string:x5bf>" + self.name + "<dev string:x5f2>" );
        return;
    }
    
    if ( !isdefined( reason ) )
    {
        println( "<dev string:x5bf>" + self.name + "<dev string:x60e>" );
        return;
    }
    
    if ( !isint( reason ) )
    {
        println( "<dev string:x5bf>" + self.name + "<dev string:x62a>" );
        return;
    }
    
    function_5a2ac7936556e701( 1, undefined, undefined );
    gamemode = challenges::getchallengegamemode();
    rejoin_expiry = 0;
    
    if ( setexpiry )
    {
        rejoin_expiry = function_b47f0ab881878ae5();
        println( "<dev string:x644>" + self.name + "<dev string:x79>" + reason + "<dev string:x678>" + level.rejoingametype + "<dev string:x685>" + level.lobbyid + "<dev string:x691>" + rejoin_expiry );
    }
    
    eventparams = function_5e5a4b7d5451b95f( additionalkvps, aeeventname, 1, reason, level.rejoingametype, gamemode, level.lobbyid, rejoin_expiry, getplaylistversion(), function_883f9fba1c9f7576() );
    function_c2376828d6dec3ff( aeeventname, eventparams );
    
    if ( var_f0848d8fcd2c903b )
    {
        self function_7dc3bff06456ba67( 1, rejoin_expiry );
    }
}

// Namespace rejoin_utility
// Params 4
// Checksum 0xfa46d093, Offset: 0x1f0d
// Size: 0x100
function setlobbynotrejoinable( reason, var_f0848d8fcd2c903b, aeeventname, additionalkvps )
{
    if ( !level.onlinegame )
    {
        println( "<dev string:x6a1>" );
        return;
    }
    
    if ( !isdefined( reason ) )
    {
        println( "<dev string:x6db>" + self.name + "<dev string:x60e>" );
        return;
    }
    
    if ( !isint( reason ) )
    {
        println( "<dev string:x6db>" + self.name + "<dev string:x62a>" );
        return;
    }
    
    function_5a2ac7936556e701( 0, undefined, undefined );
    gamemode = challenges::getchallengegamemode();
    rejoin_expiry = 0;
    eventparams = function_5e5a4b7d5451b95f( additionalkvps, aeeventname, 0, reason, level.rejoingametype, gamemode, level.lobbyid, rejoin_expiry, getplaylistversion(), function_883f9fba1c9f7576() );
    function_c2376828d6dec3ff( aeeventname, eventparams );
    
    if ( var_f0848d8fcd2c903b )
    {
        self function_7dc3bff06456ba67( 0 );
    }
}

// Namespace rejoin_utility
// Params 3
// Checksum 0x51d4241e, Offset: 0x2015
// Size: 0xe1
function function_3f54ec84b16bd38a( reason, aeeventname, additionalkvps )
{
    if ( !level.onlinegame )
    {
        println( "<dev string:x715>" );
        return;
    }
    
    if ( !isdefined( reason ) )
    {
        println( "<dev string:x755>" + self.name + "<dev string:x60e>" );
        return;
    }
    
    if ( !isint( reason ) )
    {
        println( "<dev string:x791>" + self.name + "<dev string:x62a>" );
        return;
    }
    
    gamemode = challenges::getchallengegamemode();
    rejoin_expiry = 0;
    eventparams = function_5e5a4b7d5451b95f( additionalkvps, aeeventname, 0, reason, level.rejoingametype, gamemode, level.lobbyid, rejoin_expiry, getplaylistversion(), function_883f9fba1c9f7576() );
    function_c2376828d6dec3ff( aeeventname, eventparams );
}

// Namespace rejoin_utility
// Params 2
// Checksum 0x72691a68, Offset: 0x20fe
// Size: 0x4c
function function_c2376828d6dec3ff( aeeventname, kvparray )
{
    if ( !( isdefined( kvparray ) && isdefined( kvparray.size ) ) || kvparray.size < 2 )
    {
        return;
    }
    
    utility::callsharedfunc( #"challenges", #"reportchallengeuserserializeddicteventinternal", self, aeeventname, kvparray, 0 );
}

// Namespace rejoin_utility
// Params 1
// Checksum 0x8439dbde, Offset: 0x2152
// Size: 0x9d
function function_3c29720c0519d8c7( disconnectreason )
{
    if ( disconnectreason == %"EXE/PLAYERKICKED_TEAMKILLS" )
    {
        return 3;
    }
    else if ( disconnectreason == %"exe/disconnected" )
    {
        return 14;
    }
    else if ( disconnectreason == %"exe/leaving" )
    {
        return 2;
    }
    else if ( disconnectreason == %"hash_7194ffe36169ca7" )
    {
        return 2;
    }
    else if ( disconnectreason == %"hash_5b309dc0bff1f44d" )
    {
        return 2;
    }
    else if ( disconnectreason == %"exe/timedout" )
    {
        return 6;
    }
    else if ( disconnectreason == %"EXE/PLAYERKICKED_INACTIVE" )
    {
        return 7;
    }
    
    return 0;
}

