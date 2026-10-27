// script_77873e194e406c6d  (hash_77873e194e406c6d.gscc) (size: 2255 Bytes / 0x8cf / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x36ce4f30 (919490352)
// size ...... 2255 (0x8cf)
// includes .. 3   (offset: 0x7e7)
// strings ... 13  (offset: 0x7ff)
// dev strs .. 4   (offset: 0x89f)
// exports ... 7   (offset: 0x507)
// cseg ...... 0x11f + 0x3e8 (0x507)
// imports ... 16  (offset: 0x61f)
// animtree1 . 0   (offset: 0x8cf)
// animtree2 . 0   (offset: 0x8cf)
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\logging\playtest_logger;
#using scripts\common\utility;

#namespace namespace_634561435cfb3169;

// Namespace namespace_634561435cfb3169
// Params 1
// Checksum 0x2560734e, Offset: 0x13d
// Size: 0x62
function function_562ded5a5af2cce1( var_ca3f65fdba0a9ed2 )
{
    var_ca3f65fdba0a9ed2.var_2ec883b1e0ee497e = playtest_logger::function_81cc4ca859a01d68( @"hash_b4d9cc34a6dfdb1e", @"hash_81082cac2b614784", @"hash_a1b265eb01d79455", @"hash_5d106e01221747b7", @"hash_a9292d2b9ef1340b", @"hash_1a2224f7169c7f1b", @"hash_29a8ff93834df7b8", "[ACTIVITY NEXUS] " );
}

/#

    // Namespace namespace_634561435cfb3169
    // Params 5
    // Checksum 0x3d882d7, Offset: 0x1a7
    // Size: 0x1c4, Type: dev
    function activitynexuslog( logtext, associateddvar, relevantactivityinstance, relevantplayerlist, loglevel )
    {
        if ( !isdefined( associateddvar ) )
        {
            associateddvar = @"hash_4a93c7546965668";
        }
        
        if ( !isdefined( relevantactivityinstance ) )
        {
            relevantactivityinstance = undefined;
        }
        
        if ( !isdefined( relevantplayerlist ) )
        {
            relevantplayerlist = undefined;
        }
        
        if ( !isdefined( loglevel ) )
        {
            loglevel = 1;
        }
        
        var_dbaee5535564961b = getdvarint( @"hash_ec6951bf3fb06da", 0 ) == 1;
        var_7f12d260476e02ea = !isstring( logtext ) || !isdefined( associateddvar ) || getdvarint( associateddvar, 0 ) == 0;
        
        if ( var_dbaee5535564961b || var_7f12d260476e02ea )
        {
            return;
        }
        
        logtext = "<dev string:x24>" + gettime() + "<dev string:x27>" + logtext;
        
        if ( isstruct( relevantactivityinstance ) && activity_instance_common::isactivityinstance( relevantactivityinstance ) )
        {
            logtext += function_76ff83856214495d( relevantactivityinstance );
        }
        
        if ( isarray( relevantplayerlist ) )
        {
            if ( relevantplayerlist.size > 0 )
            {
                logtext += "<dev string:x2b>";
                playerstrings = [];
                
                foreach ( player in relevantplayerlist )
                {
                    if ( isplayer( player ) )
                    {
                        playerstrings[ playerstrings.size ] = function_f8f1cafdaa77b29c( player );
                    }
                }
                
                if ( playerstrings.size > 0 )
                {
                    allplayerstrings = function_5d044133536d0766( "<dev string:x3f>", playerstrings );
                    logtext += allplayerstrings;
                }
            }
        }
        
        var_2ec883b1e0ee497e = function_bfb41a0d5e029e5d();
        playtest_logger::function_b3bbbcdc1984dae9( logtext, loglevel, var_2ec883b1e0ee497e );
    }

#/

// Namespace namespace_634561435cfb3169
// Params 1
// Checksum 0x8728e407, Offset: 0x373
// Size: 0x66
function function_76ff83856214495d( activityinstance )
{
    return " activity: type = " + activityinstance.type + " variant = " + activityinstance.varianttag + " id = " + activityinstance.id + " state = " + activityinstance.state + " participants: " + activityinstance.playerparticipants.size;
}

// Namespace namespace_634561435cfb3169
// Params 1
// Checksum 0x2c351569, Offset: 0x3e2
// Size: 0x2a, Type: bool
function function_a940a26e08d4ac7e( var_c5662bd3996b5293 )
{
    return getdvarint( @"hash_ec6951bf3fb06da", 0 ) == 0 && getdvarint( var_c5662bd3996b5293, 0 ) == 1;
}

// Namespace namespace_634561435cfb3169
// Params 1, eflags: 0x4
// Checksum 0xd92f48bc, Offset: 0x415
// Size: 0xc6
function private function_f8f1cafdaa77b29c( player )
{
    playerguid = utility::callsharedfunc( #"player", #"getPlayerGuid", player );
    playername = player.name ?? "no name defined";
    activityplayerstring = " player: name = " + playername + " guid = " + playerguid;
    teamstring = player.team ?? "undefined";
    squadidstring = player.sessionsquadid ?? "undefined";
    activityplayerstring = activityplayerstring + " team    = " + teamstring + " ";
    activityplayerstring = activityplayerstring + " squadID = " + squadidstring;
    return activityplayerstring;
}

// Namespace namespace_634561435cfb3169
// Params 0, eflags: 0x4
// Checksum 0xffb11a26, Offset: 0x4e4
// Size: 0x22
function private function_bfb41a0d5e029e5d()
{
    var_ca3f65fdba0a9ed2 = level.activities;
    return var_ca3f65fdba0a9ed2.var_2ec883b1e0ee497e;
}

